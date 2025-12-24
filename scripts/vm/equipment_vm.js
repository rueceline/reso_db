// scripts/vm/equipment_vm.js
// Build EquipmentVM.json (KR output) from CN factories + KR ConfigLanguage mapping.
//
// Output record is a single object (no db/detail split).
// - fixed: single skillId (or null)
// - random: flattened skillId[]
// - imageRel: tipsPath 그대로, normalizePathSlash만 적용
// - strings are translated by ConfigLanguage (factory/field), missing => keep CN

import {
  normalizePathSlash,
  safeNumber,
  mapQualityToRarity,
  calcMainStatWithGrowth,
  normalizeAcquireText,
  pickFirstFixedSkillId,
  pickSkillIdsFromListRec,
  tr,
} from "../lib.js";

function resolveFactionAndCategory(equipRaw, tagById, cfg) {
  const equipTagId = safeNumber(equipRaw?.equipTagId);
  const campTagId = safeNumber(equipRaw?.campTagId);

  let category = "-";
  let faction = "-";

  if (equipTagId && tagById.has(equipTagId)) {
    const t = tagById.get(equipTagId);
    const rawName = String(t?.Name || t?.tagName || "").trim();
    category = rawName ? tr(cfg, "TagFactory", "Name", rawName) : "-";
  }

  if (campTagId && tagById.has(campTagId)) {
    const t = tagById.get(campTagId);
    const rawSide = String(t?.sideName || "").trim();
    faction = rawSide ? tr(cfg, "TagFactory", "sideName", rawSide) : "-";
  }

  return { category, faction };
}

function buildRandomSkillIdList(equipRaw, listById, skillById, usedSkillIdSet) {
  const out = [];
  const src = Array.isArray(equipRaw?.randomSkillList) ? equipRaw.randomSkillList : [];

  for (const p of src) {
    const listId = safeNumber(p?.skillId);
    if (!listId) continue;

    const listRec = listById.get(listId) || null;
    if (!listRec) continue;

    const skillIds = pickSkillIdsFromListRec(listRec);
    for (const sid of skillIds) {
      if (!skillById.has(sid)) continue;

      usedSkillIdSet.add(sid);
      out.push(sid);
    }
  }

  return Array.from(new Set(out));
}

export function buildEquipmentVM(ctx) {
  const {
    cfg,
    factories: { equipmentList, skillById, tagById, growthById, listById },
    usedSkillIds,
  } = ctx;

  const outById = {};

  for (const raw of equipmentList) {
    const id = safeNumber(raw?.id);
    if (id === null) continue;

    // (기존과 동일) idCN이 "00..."로 시작하면 제외
    if (String(raw?.idCN || "").startsWith("00")) continue;

    const rarity = mapQualityToRarity(raw?.quality);
    const { category, faction } = resolveFactionAndCategory(raw, tagById, cfg);

    const growthId = safeNumber(raw?.growthId);
    const growthRec = growthId ? (growthById.get(growthId) || null) : null;
    const stat = calcMainStatWithGrowth(raw, growthRec);

    // imageRel: tipsPath 그대로 저장 (normalizePathSlash만)
    const tipsPath = String(raw?.tipsPath || raw?.iconPath || raw?.icon || raw?.imagePath || "").trim();
    const imageRel = tipsPath ? normalizePathSlash(tipsPath) : "";

    // strings (CN->KR)
    const nameCN = String(raw?.name || "").trim();
    const desCN = String(raw?.des || raw?.description || "").trim();

    const name = nameCN ? tr(cfg, "EquipmentFactory", "name", nameCN) : "-";
    const description = desCN ? tr(cfg, "EquipmentFactory", "des", desCN) : "";

    // fixed: single skillId
    const fixed = pickFirstFixedSkillId(raw?.skillList);
    if (fixed && skillById.has(fixed)) {
      usedSkillIds.add(fixed);
    }

    // random: flattened skillId[]
    const random = buildRandomSkillIdList(raw, listById, skillById, usedSkillIds);

    // acquire (CN->KR if mapping exists)
    // Getway: [{ DisplayName: "..." }, ...] 형태는 DisplayName 단위로 번역 후 join
    let acquire = "";
    const gw = raw?.Getway;

    if (Array.isArray(gw) && gw.length > 0) {
      const names = [];
      for (const it of gw) {
        const cn = String(it?.DisplayName ?? "").trim();

        if (!cn) continue;

        const ko = tr(cfg, "EquipmentFactory", "DisplayName", cn);
        console.log('ko:', ko);
        names.push(ko || cn);
      }

      acquire = names.join(" / ");
    } 

    outById[String(id)] = {
      id,

      name,
      rarity,
      category,
      faction,

      imageRel,

      fixed: fixed ?? null,
      random,

      stat: {
        label: stat.label,
        min: stat.min,
        max: stat.max,
      },

      description,
      acquire,
    };
  }

  return outById;
}
