// scripts/vm/unit_skill_vm.js
// Build UnitSkillVM.json from SkillFactory using usedUnitSkillIds collected in UnitVM build.
//
// Output: { [skillId:number]: { id, name, iconRel, description, detailDescription } }

import { normalizePathSlash, safeNumber, tr } from '../lib.js';

function stripLeadingSlashes(p) {
  return String(p || '')
    .replace(/\\/g, '/')
    .replace(/^\/+/g, '');
}

function toRelNoExt(pathLike) {
  const raw = String(pathLike || '').trim();
  if (!raw) return '';

  const norm = stripLeadingSlashes(normalizePathSlash(raw));
  return norm.replace(/\.(png|webp|jpg|jpeg)$/i, '');
}

function pickFirstString(obj, keys) {
  for (const k of keys) {
    const v = obj?.[k];
    if (v === null || v === undefined) continue;

    const s = String(v).trim();
    if (s) return s;
  }
  return '';
}

export function buildUnitSkillVM(ctx) {
  const {
    cfg,
    factories: { skillById, cardById, talentById },
    usedUnitSkillIds
  } = ctx;

  const outById = {};
  if (!usedUnitSkillIds || usedUnitSkillIds.size === 0) {
    return outById;
  }

  // usedUnitSkillIds + ExSkillList로 확장된 전체 대상 id 집합
  const allSkillIds = new Set();

  // 1) 시작점: 유닛이 직접 가진 스킬들
  for (const sid of usedUnitSkillIds) {
    const n = safeNumber(sid);
    if (n) allSkillIds.add(n);
  }

  // TalentFactory.skillIntensify 스킬도 포함
  if (talentById && typeof talentById.forEach === 'function') {
    talentById.forEach((trec) => {
      const intensifyId = safeNumber(trec?.skillIntensify);
      if (intensifyId) allSkillIds.add(intensifyId);
    });
  }

  // 2) ExSkillList로 1-depth 확장 (무한 재귀/구조 변경 없이: "포함되는 스킬도 추가" 목적)
  for (const sid of Array.from(allSkillIds)) {
    const rec = skillById.get(sid);
    if (!rec) continue;

    const exListRaw = Array.isArray(rec?.ExSkillList) ? rec.ExSkillList : [];
    for (const ex of exListRaw) {
      const exId = typeof ex === 'number' ? safeNumber(ex) : safeNumber(ex?.ExSkillName);
      if (exId) allSkillIds.add(exId);
    }
  }

  // 3) allSkillIds 대상으로 VM 생성
  for (const sid of allSkillIds) {
    const rec = skillById.get(sid);
    if (!rec) continue;

    const nameCN = pickFirstString(rec, ['Name', 'name']);
    const descCN = pickFirstString(rec, ['description', 'Description', 'des', 'Des']);
    const detailCN = pickFirstString(rec, ['detailDescription', 'DetailDescription', 'detailDes', 'DetailDes']);

    const iconCN = pickFirstString(rec, ['iconPath', 'IconPath', 'icon', 'Icon']);
    const iconRel = iconCN ? toRelNoExt(iconCN) : '';

    const exSkillIds = [];
    const exListRaw = Array.isArray(rec?.ExSkillList) ? rec.ExSkillList : [];
    for (const ex of exListRaw) {
      const exId = typeof ex === 'number' ? safeNumber(ex) : safeNumber(ex?.ExSkillName);
      if (exId) exSkillIds.push(exId);
    }

    const cardID = safeNumber(rec?.cardID);
    const cardRec = cardID && cardById ? cardById.get(cardID) : null;

    const cost = cardRec && Number.isFinite(Number(cardRec?.cost_SN)) ? Number(cardRec.cost_SN) / 10000 : undefined;

    outById[sid] = {
      id: sid,
      name: nameCN ? tr(cfg, 'SkillFactory', 'name', nameCN) : '',
      iconRel,
      description: descCN ? tr(cfg, 'SkillFactory', 'description', descCN) : '',
      detailDescription: detailCN ? tr(cfg, 'SkillFactory', 'detailDescription', detailCN) : '',
      ExSkillList: exSkillIds,
      cardID: cardID || undefined,
      cost
    };
  }

  return outById;
}
