// scripts/build_vm.js
// One-shot VM generator (CN factories -> KR VM outputs).
//
// Inputs:
// - public/data/CN/*.json
// - public/data/KR/ConfigLanguage.json
//
// Outputs (overwrite):
// - public/data/KR/EquipmentVM.json
// - public/data/KR/EquipmentSkillVM.json

import fs from 'fs';
import path from 'path';
import { readJson, writeJson, normalizeRootJson, buildIdMap, loadConfigLanguage } from './lib.js';

import { buildEquipmentVM } from './vm/equipment_vm.js';
import { buildEquipmentSkillVM } from './vm/equipment_skill_vm.js';
import { buildUnitVM } from './vm/unit_vm.js';
import { buildUnitSkillVM } from './vm/unit_skill_vm.js';

const ROOT = process.cwd();

const CN_DIR = path.join(ROOT, 'public', 'factory', 'CN');
const KR_DIR = path.join(ROOT, 'public', 'factory', 'KR');

const EQUIP_PATH = path.join(CN_DIR, 'EquipmentFactory.json');
const SKILL_PATH = path.join(CN_DIR, 'SkillFactory.json');
const TAG_PATH = path.join(CN_DIR, 'TagFactory.json');
const GROWTH_PATH = path.join(CN_DIR, 'GrowthFactory.json');
const LIST_PATH = path.join(CN_DIR, 'ListFactory.json');
const CARD_PATH = path.join(CN_DIR, 'CardFactory.json');
const TALENT_PATH = path.join(CN_DIR, 'TalentFactory.json');
const BREAKTHROUGH_PATH = path.join(CN_DIR, 'BreakthroughFactory.json');
const HOME_SKILL_PATH = path.join(CN_DIR, 'HomeSkillFactory.json');

const CONFIG_LANG_PATH = path.join(KR_DIR, 'ConfigLanguage.json');

const OUT_EQUIP_VM = path.join(KR_DIR, 'EquipmentVM.json');
const OUT_EQUIP_SKILL_VM = path.join(KR_DIR, 'EquipmentSkillVM.json');

const UNIT_PATH = path.join(CN_DIR, 'UnitFactory.json');
const UNIT_VIEW_PATH = path.join(CN_DIR, 'UnitViewFactory.json');
const PROFILE_PHOTO_PATH = path.join(CN_DIR, 'ProfilePhotoFactory.json');

const OUT_UNIT_VM = path.join(KR_DIR, 'UnitVM.json');
const OUT_UNIT_SKILL_VM = path.join(KR_DIR, 'UnitSkillVM.json');

function loadFactories() {
  const equipmentList = normalizeRootJson(readJson(EQUIP_PATH));
  const skillById = buildIdMap(normalizeRootJson(readJson(SKILL_PATH)));
  const tagById = buildIdMap(normalizeRootJson(readJson(TAG_PATH)));
  const growthById = buildIdMap(normalizeRootJson(readJson(GROWTH_PATH)));
  const listById = buildIdMap(normalizeRootJson(readJson(LIST_PATH)));
  const cardById = buildIdMap(normalizeRootJson(readJson(CARD_PATH)));
  const talentById = buildIdMap(normalizeRootJson(readJson(TALENT_PATH)));
  const breakthroughById = buildIdMap(normalizeRootJson(readJson(BREAKTHROUGH_PATH)));
  const homeSkillById = buildIdMap(normalizeRootJson(readJson(HOME_SKILL_PATH)));
  const unitList = normalizeRootJson(readJson(UNIT_PATH));
  const unitViewList = normalizeRootJson(readJson(UNIT_VIEW_PATH));
  const photoById = buildIdMap(normalizeRootJson(readJson(PROFILE_PHOTO_PATH)));

  return {
    equipmentList,
    skillById,
    tagById,
    growthById,
    listById,
    cardById,
    talentById,
    breakthroughById,
    unitList,
    unitViewList,
    homeSkillById,
    photoById
  };
}

function normalizeSlash(p) {
  return String(p || '').replace(/\\/g, '/');
}

function stripLeadingSlashes(p) {
  return normalizeSlash(p).replace(/^\/+/g, '');
}

function removePngExt(p) {
  return String(p || '').replace(/\.png$/i, '');
}

// - 지정된 폴더 내 전체 .png 파일 경로 리스트 생성
// - .png 제외하고 맵에 저장 (key: lower(no-ext rel), value: actual-case no-ext rel)
function buildPngNoExtMap(rootDirAbs) {
  const map = new Map();

  function walk(dirAbs) {
    const entries = fs.readdirSync(dirAbs, { withFileTypes: true });

    for (const e of entries) {
      const abs = path.join(dirAbs, e.name);

      if (e.isDirectory()) {
        walk(abs);
        continue;
      }

      if (!e.isFile()) continue;

      if (!/\.png$/i.test(e.name)) continue;

      const rel = normalizeSlash(path.relative(rootDirAbs, abs)); // includes .png
      const relNoExt = removePngExt(rel); // 리스트 저장 시에만 .png 제거
      const key = relNoExt.toLowerCase();

      if (!map.has(key)) {
        map.set(key, relNoExt);
      }
    }
  }

  walk(rootDirAbs);
  return map;
}

// - VM의 모든 중첩된 필드 검색
// - / 포함된 문자열인 경우 파일 리스트에서 검색(값 가공 금지: 그대로 비교)
// - 일치하는 경우 대소문자 변경
function applyCaseFixDeepFromPngList(pngNoExtMap, rootObj) {
  const seen = new Set();

  function fixStringIfMatch(s) {
    if (!s) return s;

    const v = String(s);
    if (!v.includes('/')) return s;

    const raw = stripLeadingSlashes(v);
    const norm = normalizeSlash(raw);

    const hit = pngNoExtMap.get(norm.toLowerCase());
    return hit ? hit : s;
  }

  function walk(node) {
    if (node === null || node === undefined) return;

    const t = typeof node;
    if (t !== 'object') return;

    if (seen.has(node)) return;
    seen.add(node);

    if (Array.isArray(node)) {
      for (let i = 0; i < node.length; i += 1) {
        const it = node[i];

        if (typeof it === 'string') {
          const fixed = fixStringIfMatch(it);
          if (fixed !== it) {
            node[i] = fixed;
          }

          continue;
        }

        walk(it);
      }

      return;
    }

    for (const key of Object.keys(node)) {
      const val = node[key];

      if (typeof val === 'string') {
        const fixed = fixStringIfMatch(val);
        if (fixed !== val) {
          node[key] = fixed;
        }

        continue;
      }

      walk(val);
    }
  }

  walk(rootObj);
}


function main() {
  const cfg = loadConfigLanguage(CONFIG_LANG_PATH);
  const factories = loadFactories();

  const usedSkillIds = new Set();
  const usedUnitSkillIds = new Set();

  const ctx = { cfg, factories, usedSkillIds, usedUnitSkillIds };

  const equipVm = buildEquipmentVM(ctx);
  const equipSkillVm = buildEquipmentSkillVM(ctx);

  const unitVm = buildUnitVM(ctx);
  const unitSkillVm = buildUnitSkillVM(ctx);

  const assetsRootAbs = path.join(ROOT, 'public', 'assets');

  // 1) assets 아래 모든 png를 스캔해서 (확장자 제외) 맵 생성
  let pngNoExtMap = new Map();
  if (!fs.existsSync(assetsRootAbs)) {
    console.log(`[skip] assets folder not found: ${path.relative(ROOT, assetsRootAbs)}`);
  } else {
    // 1) assets 아래 모든 png를 스캔해서 (확장자 제외) 맵 생성
    pngNoExtMap = buildPngNoExtMap(assetsRootAbs);
  }  

  // 2) VM 전체(중첩 포함)에서 '/' 포함 문자열을 찾아 케이스만 교정
  applyCaseFixDeepFromPngList(pngNoExtMap, unitVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, unitSkillVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, equipVm);

  writeJson(OUT_EQUIP_VM, equipVm);
  writeJson(OUT_EQUIP_SKILL_VM, equipSkillVm);

  writeJson(OUT_UNIT_VM, unitVm);
  writeJson(OUT_UNIT_SKILL_VM, unitSkillVm);

  console.log(`[ok] ${path.relative(ROOT, OUT_EQUIP_VM)} (equip=${Object.keys(equipVm).length})`);
  console.log(`[ok] ${path.relative(ROOT, OUT_EQUIP_SKILL_VM)} (usedSkills=${usedSkillIds.size})`);
  console.log(`[ok] ${path.relative(ROOT, OUT_UNIT_VM)} (unit=${Object.keys(unitVm).length})`);
  console.log(`[ok] ${path.relative(ROOT, OUT_UNIT_SKILL_VM)} (usedUnitSkills=${usedUnitSkillIds.size})`);
}

main();

