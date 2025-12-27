// scripts/build_vm.js
// Filtered VM generator (CN factories -> KR VM outputs)
// Rule:
// - Only write VMs for factories that are joined by core pages (Unit/Equipment flows).
// - VM keeps the original Factory record shape (no computed/derived fields).
// - Strings are translated by ConfigLanguage (factory/field), missing => keep CN.
// - Output format: { [id:string]: recordObject }  (recordObject keeps original fields)

import fs from 'fs';
import path from 'path';

import { readJson, writeJson, normalizeRootJson, buildIdMap, loadConfigLanguage, safeNumber, tr, pickSkillIdsFromListRec, pickCampTagIds, pickSpecialTagIds } from './lib.js';

const ROOT = process.cwd();

const CN_DIR = path.join(ROOT, 'public', 'data', 'CN');
const KR_DIR = path.join(ROOT, 'public', 'data', 'KR');

const CONFIG_LANG_PATH = path.join(KR_DIR, 'ConfigLanguage.json');

// Factories (only those used by existing core join logic: unit_vm.js / equipment_vm.js / unit_skill_vm.js / equipment_skill_vm.js)
const PATHS = {
  UnitFactory: path.join(CN_DIR, 'UnitFactory.json'),
  UnitViewFactory: path.join(CN_DIR, 'UnitViewFactory.json'),
  ProfilePhotoFactory: path.join(CN_DIR, 'ProfilePhotoFactory.json'),

  EquipmentFactory: path.join(CN_DIR, 'EquipmentFactory.json'),
  GrowthFactory: path.join(CN_DIR, 'GrowthFactory.json'),

  SkillFactory: path.join(CN_DIR, 'SkillFactory.json'),
  CardFactory: path.join(CN_DIR, 'CardFactory.json'),

  TagFactory: path.join(CN_DIR, 'TagFactory.json'),
  ListFactory: path.join(CN_DIR, 'ListFactory.json'),
  TalentFactory: path.join(CN_DIR, 'TalentFactory.json'),
  BreakthroughFactory: path.join(CN_DIR, 'BreakthroughFactory.json'),
  HomeSkillFactory: path.join(CN_DIR, 'HomeSkillFactory.json')
};

// Outputs
const OUT = {
  UnitVM: path.join(KR_DIR, 'UnitVM.json'),
  UnitViewVM: path.join(KR_DIR, 'UnitViewVM.json'),
  ProfilePhotoVM: path.join(KR_DIR, 'ProfilePhotoVM.json'),

  EquipmentVM: path.join(KR_DIR, 'EquipmentVM.json'),
  GrowthVM: path.join(KR_DIR, 'GrowthVM.json'),

  SkillVM: path.join(KR_DIR, 'SkillVM.json'),
  CardVM: path.join(KR_DIR, 'CardVM.json'),

  TagVM: path.join(KR_DIR, 'TagVM.json'),
  ListVM: path.join(KR_DIR, 'ListVM.json'),
  TalentVM: path.join(KR_DIR, 'TalentVM.json'),
  BreakthroughVM: path.join(KR_DIR, 'BreakthroughVM.json'),
  HomeSkillVM: path.join(KR_DIR, 'HomeSkillVM.json')
};

// [변경 후] (scripts/build_vm.js) build_vm_old.js의 케이스 보정 로직 추가
function existsOrNull(absPath) {
  return fs.existsSync(absPath) ? absPath : null;
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

      const rel = path.relative(rootDirAbs, abs).replace(/\\/g, '/'); // file list entry
      const relNoExt = rel.replace(/\.png$/i, ''); // file list entry (no-ext)
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
  const hasMap = pngNoExtMap && typeof pngNoExtMap.get === "function" && pngNoExtMap.size > 0;

  function fixStringIfMatch(s) {
    if (!s) return s;

    // 공통 로직: 항상 \\ -> / (저장값 자체를 통일)
    const v0 = String(s);
    const v = v0.includes("\\") ? v0.replace(/\\/g, "/") : v0;

    // 경로 형태가 아니면 종료
    if (!v.includes("/")) return v;

    // map이 있을 때만 케이스 교정
    if (!hasMap) return v;

    const hit = pngNoExtMap.get(v.toLowerCase());
    return hit ? hit : v;
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
          if (fixed !== it) node[i] = fixed;
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
        if (fixed !== val) node[key] = fixed;
        continue;
      }

      walk(val);
    }
  }

  walk(rootObj);
}

function loadFactoryList(factoryName) {
  const p = existsOrNull(PATHS[factoryName]);
  if (!p) return [];
  return normalizeRootJson(readJson(p));
}

// Translate strings deeply:
// - Keep record shape & keys unchanged.
// - For any string value under key `fieldName`, translate by (factoryName, fieldName).
function translateDeep(cfg, factoryName, node, fieldNameForString = '') {
  if (node === null || node === undefined) return node;

  if (typeof node === 'string') {
    // Only translate when we know the field name (object key)
    if (!fieldNameForString) return node;
    return tr(cfg, factoryName, fieldNameForString, node);
  }

  if (typeof node !== 'object') return node;

  if (Array.isArray(node)) {
    return node.map((it) => translateDeep(cfg, factoryName, it, fieldNameForString));
  }

  const out = {};
  for (const k of Object.keys(node)) {
    const v = node[k];
    if (typeof v === 'string') {
      out[k] = translateDeep(cfg, factoryName, v, k);
      continue;
    }
    out[k] = translateDeep(cfg, factoryName, v, k);
  }
  return out;
}

// ---------- Core filters (copied from existing page-VM logic) ----------

function isUnitIncludedByCoreFilter(unitRec) {
  // from unit_vm.js
  if (unitRec?.mod !== '玩家角色') return false;

  const idcn = String(unitRec?.idCN || '');

  // exclude: unreleased/story NPC/conductor
  if (idcn.includes('50未上线')) return false;
  if (idcn.includes('剧情NPC')) return false;
  if (idcn.includes('01列车长')) return false;

  // include: 02/03/04/05-star
  if (!idcn.includes('05五星') && !idcn.includes('04四星') && !idcn.includes('03三星') && !idcn.includes('02二星')) {
    return false;
  }

  // exclude: gender empty
  const gender = String(unitRec?.gender ?? '').trim();
  if (gender === '') return false;

  const id = safeNumber(unitRec?.id);
  if (!id) return false;

  return true;
}

function isEquipmentIncludedByCoreFilter(equipRec) {
  // from equipment_vm.js
  const id = safeNumber(equipRec?.id);
  if (id === null) return false;
  if (String(equipRec?.idCN || '').startsWith('00')) return false;
  return true;
}

// ---------- ID collectors ----------

function addId(set, v) {
  const n = safeNumber(v);
  if (n) set.add(n);
}

function addIdsFromArray(set, arr, pickFn) {
  const list = Array.isArray(arr) ? arr : [];
  for (const it of list) {
    const v = pickFn ? pickFn(it) : it;
    addId(set, v);
  }
}

function collectFromUnits(unitList) {
  const used = {
    unitIds: new Set(),
    unitViewIds: new Set(),
    profilePhotoIds: new Set(),
    listIds: new Set(),
    breakthroughIds: new Set(),
    homeSkillIds: new Set(),
    talentIds: new Set(),
    skillIds: new Set(),
    tagIds: new Set() // sideId
  };

  for (const u of unitList) {
    if (!isUnitIncludedByCoreFilter(u)) continue;

    addId(used.unitIds, u?.id);
    addId(used.tagIds, u?.sideId);
    addId(used.unitViewIds, u?.viewId);

    // skinList[*].unitViewId
    addIdsFromArray(used.unitViewIds, u?.skinList, (sk) => sk?.unitViewId);

    // ProfilePhotoList[*].id
    addIdsFromArray(used.profilePhotoIds, u?.ProfilePhotoList, (p) => p?.id);

    // fileList[*].file -> ListFactory.id
    addIdsFromArray(used.listIds, u?.fileList, (f) => f?.file);

    // breakthroughList[*].breakthroughId
    addIdsFromArray(used.breakthroughIds, u?.breakthroughList, (b) => b?.breakthroughId);

    // homeSkillList[*].id
    addIdsFromArray(used.homeSkillIds, u?.homeSkillList, (hs) => hs?.id);

    // talentList[*].talentId
    addIdsFromArray(used.talentIds, u?.talentList, (t) => t?.talentId);

    // skillList[*].skillId
    addIdsFromArray(used.skillIds, u?.skillList, (s) => s?.skillId);
  }

  return used;
}

function collectFromEquipments(equipmentList, listById) {
  const used = {
    equipIds: new Set(),
    growthIds: new Set(),
    listIds: new Set(), // randomSkillList[*].skillId points to ListFactory
    skillIds: new Set(), // fixed/random skill ids referenced
    tagIds: new Set() // equipTagId, campTagId
  };

  for (const e of equipmentList) {
    if (!isEquipmentIncludedByCoreFilter(e)) continue;

    addId(used.equipIds, e?.id);
    addId(used.growthIds, e?.growthId);
    addId(used.tagIds, e?.equipTagId);
    addId(used.tagIds, e?.campTagId);

    // fixed skills: we don't compute "first"; we conservatively collect all skillList[*].skillId
    addIdsFromArray(used.skillIds, e?.skillList, (s) => s?.skillId);

    // randomSkillList[*].skillId -> ListFactory.id, then listRec -> EquipmentEntryList[*].id => skillId
    const rands = Array.isArray(e?.randomSkillList) ? e.randomSkillList : [];
    for (const r of rands) {
      const listId = safeNumber(r?.skillId);
      if (!listId) continue;

      used.listIds.add(listId);

      const listRec = listById.get(listId) || null;
      if (!listRec) continue;

      const skillIds = pickSkillIdsFromListRec(listRec);
      for (const sid of skillIds) {
        addId(used.skillIds, sid);
      }
    }
  }

  return used;
}

function expandSkillIdsWithUnitSkillLogic(skillById, talentById, baseSkillIds) {
  // Matches unit_skill_vm.js behavior:
  // - include base skills
  // - include TalentFactory.skillIntensify
  // - expand ExSkillList 1-depth
  const all = new Set();

  for (const sid of baseSkillIds) addId(all, sid);

  if (talentById && typeof talentById.forEach === 'function') {
    talentById.forEach((trec) => {
      addId(all, trec?.skillIntensify);
    });
  }

  for (const sid of Array.from(all)) {
    const rec = skillById.get(sid) || null;
    if (!rec) continue;

    const exListRaw = Array.isArray(rec?.ExSkillList) ? rec.ExSkillList : [];
    for (const ex of exListRaw) {
      if (typeof ex === 'number') {
        addId(all, ex);
      } else {
        addId(all, ex?.ExSkillName);
      }
    }
  }

  return all;
}

function collectCardIdsFromSkills(skillById, skillIds) {
  const out = new Set();
  for (const sid of skillIds) {
    const rec = skillById.get(sid) || null;
    if (!rec) continue;
    addId(out, rec?.cardID);
  }
  return out;
}

function collectTagIdsFromSkills(skillById, skillIds) {
  // For EquipmentSkillVM label logic: uses campList/specialTagList ids (tag ids).
  const out = new Set();
  for (const sid of skillIds) {
    const rec = skillById.get(sid) || null;
    if (!rec) continue;

    for (const tid of pickCampTagIds(rec)) addId(out, tid);
    for (const tid of pickSpecialTagIds(rec)) addId(out, tid);
  }
  return out;
}

// ---------- Builders (Factory -> VM) ----------

function buildFilteredVMById(cfg, factoryName, srcList, includeIdSet) {
  const outById = {};
  for (const r of Array.isArray(srcList) ? srcList : []) {
    const id = safeNumber(r?.id);
    if (!id) continue;
    if (!includeIdSet.has(id)) continue;

    outById[String(id)] = translateDeep(cfg, factoryName, r, '');
  }
  return outById;
}

export function buildUnitVM(ctx) {
  const { cfg, unitList } = ctx;

  const outById = {};
  for (const u of unitList) {
    if (!isUnitIncludedByCoreFilter(u)) continue;

    const id = safeNumber(u?.id);
    if (!id) continue;

    outById[String(id)] = translateDeep(cfg, 'UnitFactory', u, '');
  }

  return outById;
}

export function buildEquipmentVM(ctx) {
  const { cfg, equipmentList } = ctx;

  const outById = {};
  for (const e of equipmentList) {
    if (!isEquipmentIncludedByCoreFilter(e)) continue;

    const id = safeNumber(e?.id);
    if (!id) continue;

    outById[String(id)] = translateDeep(cfg, 'EquipmentFactory', e, '');
  }

  return outById;
}

export function buildUnitViewVM(ctx, includeIdSet) {
  const { cfg, unitViewList } = ctx;
  return buildFilteredVMById(cfg, 'UnitViewFactory', unitViewList, includeIdSet);
}

export function buildProfilePhotoVM(ctx, includeIdSet) {
  const { cfg, profilePhotoList } = ctx;
  return buildFilteredVMById(cfg, 'ProfilePhotoFactory', profilePhotoList, includeIdSet);
}

export function buildListVM(ctx, includeIdSet) {
  const { cfg, listList } = ctx;
  return buildFilteredVMById(cfg, 'ListFactory', listList, includeIdSet);
}

export function buildBreakthroughVM(ctx, includeIdSet) {
  const { cfg, breakthroughList } = ctx;
  return buildFilteredVMById(cfg, 'BreakthroughFactory', breakthroughList, includeIdSet);
}

export function buildHomeSkillVM(ctx, includeIdSet) {
  const { cfg, homeSkillList } = ctx;
  return buildFilteredVMById(cfg, 'HomeSkillFactory', homeSkillList, includeIdSet);
}

// [변경 후] buildTalentVM (scripts/build_vm.js) :contentReference[oaicite:1]{index=1}
export function buildTalentVM(ctx, includeIdSet) {
  const { cfg, talentList } = ctx;

  const outById = {};
  for (const r of Array.isArray(talentList) ? talentList : []) {
    const id = safeNumber(r?.id);
    if (!id) continue;
    if (!includeIdSet.has(id)) continue;

    const rec = translateDeep(cfg, "TalentFactory", r, "");

    // TalentVM.path: 원본 팩토리 저장 경로 차이(\\)를 /로 통일해서 저장
    if (typeof rec?.path === "string") {
      rec.path = rec.path.replace(/\\/g, "/");
    }
    if (typeof rec?.Path === "string") {
      rec.Path = rec.Path.replace(/\\/g, "/");
    }

    outById[String(id)] = rec;
  }

  return outById;
}


export function buildGrowthVM(ctx, includeIdSet) {
  const { cfg, growthList } = ctx;
  return buildFilteredVMById(cfg, 'GrowthFactory', growthList, includeIdSet);
}

export function buildSkillVM(ctx, includeIdSet) {
  const { cfg, skillList } = ctx;
  return buildFilteredVMById(cfg, 'SkillFactory', skillList, includeIdSet);
}

export function buildTagVM(ctx, includeIdSet) {
  const { cfg, tagList } = ctx;
  return buildFilteredVMById(cfg, 'TagFactory', tagList, includeIdSet);
}

export function buildCardVM(ctx, includeIdSet) {
  const { cfg, cardList } = ctx;
  return buildFilteredVMById(cfg, 'CardFactory', cardList, includeIdSet);
}

// ---------- Main ----------

function main() {
  const cfg = loadConfigLanguage(CONFIG_LANG_PATH);

  // Load only required factories
  const unitList = loadFactoryList('UnitFactory');
  const unitViewList = loadFactoryList('UnitViewFactory');
  const profilePhotoList = loadFactoryList('ProfilePhotoFactory');

  const equipmentList = loadFactoryList('EquipmentFactory');
  const growthList = loadFactoryList('GrowthFactory');

  const skillList = loadFactoryList('SkillFactory');
  const cardList = loadFactoryList('CardFactory');

  const tagList = loadFactoryList('TagFactory');
  const listList = loadFactoryList('ListFactory');
  const talentList = loadFactoryList('TalentFactory');
  const breakthroughList = loadFactoryList('BreakthroughFactory');
  const homeSkillList = loadFactoryList('HomeSkillFactory');

  // Build id maps for join expansion steps
  const listById = buildIdMap(listList);
  const skillById = buildIdMap(skillList);
  const talentById = buildIdMap(talentList);

  // 1) Core filters
  const unitUsed = collectFromUnits(unitList);
  const equipUsed = collectFromEquipments(equipmentList, listById);

  // 2) Skill expansion (unit_skill_vm.js behavior) over union(unit+equipment skills)
  const baseSkillIds = new Set();
  for (const x of unitUsed.skillIds) baseSkillIds.add(x);
  for (const x of equipUsed.skillIds) baseSkillIds.add(x);

  const expandedSkillIds = expandSkillIdsWithUnitSkillLogic(skillById, talentById, baseSkillIds);

  // 3) Secondary joins based on skills
  const cardIds = collectCardIdsFromSkills(skillById, expandedSkillIds);
  const skillTagIds = collectTagIdsFromSkills(skillById, expandedSkillIds);

  // 4) Tag ids = from unit/equip + from skills (campList/specialTagList)
  const tagIds = new Set();
  for (const x of unitUsed.tagIds) tagIds.add(x);
  for (const x of equipUsed.tagIds) tagIds.add(x);
  for (const x of skillTagIds) tagIds.add(x);

  // 5) List ids = from unit fileList + from equipment randomSkillList
  const listIds = new Set();
  for (const x of unitUsed.listIds) listIds.add(x);
  for (const x of equipUsed.listIds) listIds.add(x);

  // 6) UnitView ids = from unit viewId + skins
  const unitViewIds = new Set(unitUsed.unitViewIds);

  // 7) Build each VM
  const ctx = {
    cfg,

    unitList,
    unitViewList,
    profilePhotoList,

    equipmentList,
    growthList,

    skillList,
    cardList,

    tagList,
    listList,
    talentList,
    breakthroughList,
    homeSkillList
  };

  const unitVm = buildUnitVM(ctx);
  const equipVm = buildEquipmentVM(ctx);
  const unitViewVm = buildUnitViewVM(ctx, unitViewIds);
  const profilePhotoVm = buildProfilePhotoVM(ctx, unitUsed.profilePhotoIds);
  const talentVm = buildTalentVM(ctx, unitUsed.talentIds);
  const breakthroughVm = buildBreakthroughVM(ctx, unitUsed.breakthroughIds);
  const homeSkillVm = buildHomeSkillVM(ctx, unitUsed.homeSkillIds);
  const listVm = buildListVM(ctx, listIds);
  const growthVm = buildGrowthVM(ctx, equipUsed.growthIds);
  const skillVm = buildSkillVM(ctx, expandedSkillIds);
  const cardVm = buildCardVM(ctx, cardIds);
  const tagVm = buildTagVM(ctx, tagIds);

  const assetsRootAbs = path.join(ROOT, 'public', 'assets');

  // 1) assets 아래 모든 png를 스캔해서 (확장자 제외) 맵 생성
  let pngNoExtMap = new Map();
  if (!fs.existsSync(assetsRootAbs)) {
    console.log(`[skip] assets folder not found: ${path.relative(ROOT, assetsRootAbs)}`);
  } else {
    pngNoExtMap = buildPngNoExtMap(assetsRootAbs);
  }

  applyCaseFixDeepFromPngList(pngNoExtMap, unitVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, equipVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, unitViewVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, profilePhotoVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, talentVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, breakthroughVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, homeSkillVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, listVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, growthVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, skillVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, cardVm);
  applyCaseFixDeepFromPngList(pngNoExtMap, tagVm);

  // 8) Write
  writeJson(OUT.UnitVM, unitVm);
  writeJson(OUT.EquipmentVM, equipVm);
  writeJson(OUT.UnitViewVM, unitViewVm);
  writeJson(OUT.ProfilePhotoVM, profilePhotoVm);
  writeJson(OUT.TalentVM, talentVm);
  writeJson(OUT.BreakthroughVM, breakthroughVm);
  writeJson(OUT.HomeSkillVM, homeSkillVm);
  writeJson(OUT.ListVM, listVm);
  writeJson(OUT.GrowthVM, growthVm);
  writeJson(OUT.SkillVM, skillVm);
  writeJson(OUT.CardVM, cardVm);
  writeJson(OUT.TagVM, tagVm);

  // keep minimal progress logs (counts only; not "diff logs")
  console.log(`[ok] UnitVM=${Object.keys(unitVm).length}, EquipmentVM=${Object.keys(equipVm).length}`);
  console.log(`[ok] UnitViewVM=${Object.keys(unitViewVm).length}, ProfilePhotoVM=${Object.keys(profilePhotoVm).length}`);
  console.log(`[ok] TalentVM=${Object.keys(talentVm).length}, BreakthroughVM=${Object.keys(breakthroughVm).length}, HomeSkillVM=${Object.keys(homeSkillVm).length}`);
  console.log(`[ok] ListVM=${Object.keys(listVm).length}, GrowthVM=${Object.keys(growthVm).length}`);
  console.log(`[ok] SkillVM=${Object.keys(skillVm).length}, CardVM=${Object.keys(cardVm).length}, TagVM=${Object.keys(tagVm).length}`);
}

main();
