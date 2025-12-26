// scripts/vm/equipment_skill_vm.js
// Build EquipmentSkillVM.json (KR output) from usedSkillIds.
// - flat object: { [label]: [{ id, description }] }
// - label 예: "철도연맹", "아니타", ... , "공용"
// Classification uses TagFactory.sideName with priority:
// 0) skillRec.sideName
// 1) campList -> TagFactory.sideName
// 2) specialTagList -> TagFactory.sideName
//
// label/description are translated by ConfigLanguage (missing => keep CN)

import { resolveFactionLabelFromSkillRec, tr } from '../lib.js';

function translateFactionLabel(cfg, labelCN) {
  const s = String(labelCN || '').trim();
  if (!s) return '';
  return tr(cfg, 'TagFactory', 'sideName', s);
}

export function buildEquipmentSkillVM(ctx) {
  const {
    cfg,
    factories: { skillById, tagById },
    usedSkillIds
  } = ctx;

  const groupMap = new Map();
  const COMMON_LABEL = '공용';

  for (const sid of usedSkillIds) {
    const s = skillById.get(sid) || null;
    if (!s) continue;

    const descCN = String(s?.description || s?.tempdescription || '').trim();
    const desc = descCN ? tr(cfg, 'SkillFactory', 'description', descCN) : '';

    const labelCN = resolveFactionLabelFromSkillRec(s, tagById);
    const label = translateFactionLabel(cfg, labelCN);

    const pair = { id: sid, description: desc };

    const key = label || COMMON_LABEL;
    const arr = groupMap.get(key) || [];
    arr.push(pair);
    groupMap.set(key, arr);
  }

  for (const arr of groupMap.values()) {
    arr.sort((a, b) => a.id - b.id);
  }

  return Object.fromEntries(Array.from(groupMap.entries()));
}
