// scripts/vm/equipment_skill_vm.js
// Build EquipmentSkillVM.json (KR output) from usedSkillIds.
// - faction: { [label]: [{ id, description }] }
// - common:  [{ id, description }]
// Classification uses TagFactory.sideName with priority:
// 0) skillRec.sideName
// 1) campList -> TagFactory.sideName
// 2) specialTagList -> TagFactory.sideName
//
// label/description are translated by ConfigLanguage (missing => keep CN)

import { resolveFactionLabelFromSkillRec, tr } from "../lib.js";

function translateFactionLabel(cfg, labelCN) {
  const s = String(labelCN || "").trim();
  if (!s) return "";
  return tr(cfg, "TagFactory", "sideName", s);
}

export function buildEquipmentSkillVM(ctx) {
  const {
    cfg,
    factories: { skillById, tagById },
    usedSkillIds,
  } = ctx;

  const factionMap = new Map();
  const common = [];

  for (const sid of usedSkillIds) {
    const s = skillById.get(sid) || null;
    if (!s) continue;

    const descCN = String(s?.description || s?.tempdescription || "").trim();
    const desc = descCN ? tr(cfg, "SkillFactory", "description", descCN) : "";

    const labelCN = resolveFactionLabelFromSkillRec(s, tagById);
    const label = translateFactionLabel(cfg, labelCN);

    const pair = { id: sid, description: desc };

    if (label) {
      if (!factionMap.has(label)) factionMap.set(label, []);
      factionMap.get(label).push(pair);
    } else {
      common.push(pair);
    }
  }

  for (const arr of factionMap.values()) {
    arr.sort((a, b) => a.id - b.id);
  }
  common.sort((a, b) => a.id - b.id);

  return {
    faction: Object.fromEntries(Array.from(factionMap.entries())),
    common,
  };
}
