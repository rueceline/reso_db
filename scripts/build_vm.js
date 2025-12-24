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

import path from "path";
import {
  readJson,
  writeJson,
  normalizeRootJson,
  buildIdMap,
  loadConfigLanguage,
} from "./lib.js";

import { buildEquipmentVM } from "./vm/equipment_vm.js";
import { buildEquipmentSkillVM } from "./vm/equipment_skill_vm.js";

const ROOT = process.cwd();

const CN_DIR = path.join(ROOT, "public", "factory", "CN");
const KR_DIR = path.join(ROOT, "public", "factory", "KR");

const EQUIP_PATH = path.join(CN_DIR, "EquipmentFactory.json");
const SKILL_PATH = path.join(CN_DIR, "SkillFactory.json");
const TAG_PATH = path.join(CN_DIR, "TagFactory.json");
const GROWTH_PATH = path.join(CN_DIR, "GrowthFactory.json");
const LIST_PATH = path.join(CN_DIR, "ListFactory.json");

const CONFIG_LANG_PATH = path.join(KR_DIR, "ConfigLanguage.json");

const OUT_EQUIP_VM = path.join(KR_DIR, "EquipmentVM.json");
const OUT_EQUIP_SKILL_VM = path.join(KR_DIR, "EquipmentSkillVM.json");

function loadFactories() {
  const equipmentList = normalizeRootJson(readJson(EQUIP_PATH));
  const skillById = buildIdMap(normalizeRootJson(readJson(SKILL_PATH)));
  const tagById = buildIdMap(normalizeRootJson(readJson(TAG_PATH)));
  const growthById = buildIdMap(normalizeRootJson(readJson(GROWTH_PATH)));
  const listById = buildIdMap(normalizeRootJson(readJson(LIST_PATH)));

  return { equipmentList, skillById, tagById, growthById, listById };
}

function main() {
  const cfg = loadConfigLanguage(CONFIG_LANG_PATH);
  const factories = loadFactories();

  const usedSkillIds = new Set();
  const ctx = { cfg, factories, usedSkillIds };

  const equipVm = buildEquipmentVM(ctx);
  const equipSkillVm = buildEquipmentSkillVM(ctx);

  writeJson(OUT_EQUIP_VM, equipVm);
  writeJson(OUT_EQUIP_SKILL_VM, equipSkillVm);

  console.log(`[ok] ${path.relative(ROOT, OUT_EQUIP_VM)} (equip=${Object.keys(equipVm).length})`);
  console.log(`[ok] ${path.relative(ROOT, OUT_EQUIP_SKILL_VM)} (usedSkills=${usedSkillIds.size})`);
}

main();
