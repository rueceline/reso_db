// utils/utils.js
// 장비 공통 유틸 (Equipment DB / Detail 공용)

// =========================
// 1. 상수 / 매핑
// =========================

export const factionMap = {
  '铁盟': '철도연맹',
  '混沌海': '혼돈해',
  '学会': '시타델',
  '黑月': '흑월',
  '帝国': '제국',
  'ANITA': '아니타',
};

export const categoryMap = {
  '武器': '무기',
  '护甲': '방어구',
  '挂件': '장신구',
};

export const qualityToRarityMap = {
  Orange: 'UR',
  Golden: 'SSR',
  Purple: 'SR',
  Blue: 'R',
  White: 'N',
};

// =========================
// 2. 기본 유틸
// =========================

export function safeNumber(v) {
  const n = Number(v);
  return Number.isFinite(n) ? n : 0;
}

export function normalizePathSlash(s) {
  return String(s || '').replaceAll('\\', '/');
}

// =========================
// 3. idCN 파싱 (통합)
// =========================

/**
 * idCN 예:
 * 铁盟装备/橙/武器/狩猎左轮
 */
export function parseIdCN(idCN) {
  const raw = normalizePathSlash(idCN);
  const parts = raw.split('/').map(s => s.trim()).filter(Boolean);

  const factionCN = parts[0]?.replace(/装备$/u, '') ?? '';
  const categoryCN = parts[2] ?? '';

  return {
    faction: factionMap[factionCN] || factionCN || '-',
    category: categoryMap[categoryCN] || categoryCN || '-',
  };
}

// =========================
// 4. 레어리티
// =========================

export function mapQualityToRarity(quality) {
  return qualityToRarityMap[String(quality)] || '-';
}

// =========================
// 5. 장비 주 스탯 판별
// =========================

export function resolveMainStat(e) {
  if (safeNumber(e?.attack_SN) > 0) {
    return { key: 'atk', label: '공격력', sn: e.attack_SN };
  }
  if (safeNumber(e?.healthPoint_SN) > 0) {
    return { key: 'hp', label: '체력', sn: e.healthPoint_SN };
  }
  if (safeNumber(e?.defence_SN) > 0) {
    return { key: 'def', label: '방어력', sn: e.defence_SN };
  }
  return { key: '', label: '-', sn: 0 };
}

// =========================
// 6. 성장 계산 (확정식)
// =========================

/**
 * @param equipSN   EquipmentFactory의 *_SN
 * @param growthSN  GrowthFactory의 g*_SN
 * @param maxLevel  기본 80
 */
export function calcEquipStatRange(equipSN, growthSN, maxLevel = 80) {
  const equipBase = equipSN / 10000;
  const growthInitial = growthSN / 1000;
  const perLevel = growthSN / 10000;

  const growthMax =
    growthInitial + perLevel * (maxLevel - 1);

  const delta = equipBase - growthInitial;

  return {
    min: Math.round(equipBase),
    max: Math.round(growthMax + delta),
  };
}

/**
 * Equipment + Growth 전체 객체 기준 계산
 */
export function calcMainStatWithGrowth(e, growthRec) {
  const main = resolveMainStat(e);
  if (!main.key || !growthRec) {
    return { label: main.label, min: '-', max: '-' };
  }

  let growthSN = 0;
  if (main.key === 'atk') growthSN = growthRec.gAtk_SN;
  if (main.key === 'hp') growthSN = growthRec.gHp_SN;
  if (main.key === 'def') growthSN = growthRec.gDef_SN;

  if (!growthSN) {
    const v = Math.round(main.sn / 10000);
    return { label: main.label, min: v, max: v };
  }

  const r = calcEquipStatRange(main.sn, growthSN);

  return {
    label: main.label,
    min: r.min,
    max: r.max,
  };
}

// =========================
// 7. 고정 옵션 최대 개수
// =========================

export function getFixedOptionMax(category) {
  if (category === '장신구') return 6;
  return 4;
}
