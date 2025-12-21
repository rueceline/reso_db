// app/utils/equipment.js
// 장비 도메인 유틸 (Equipment DB / Detail 공용)
//
// 원칙:
// - 장비/성장/옵션 계산만 담당 (데이터 로드/BASE 경로는 utils.js/base.js가 담당)

import { safeNumber, normalizePathSlash } from "./base.js";

const qualityToRarityMap = {
  Orange: "UR",
  Golden: "SSR",
  Purple: "SR",
  Blue: "R",
  White: "N",
};

export function parseIdCN(idCN) {
  const raw = String(idCN || "").trim();
  if (!raw) {
    return { raw: "", parts: [], category: "", faction: "", type: "" };
  }

  const parts = raw.split("/").map((s) => String(s || "").trim()).filter(Boolean);

  // 관례: .../품질/분류/이름 혹은 .../품질/소속/분류/이름 등 변형이 있어 완벽히 고정하지 않음
  // 여기서는 장비 목록 필터링용으로 "분류/소속" 후보만 뽑는다.
  const category = parts.length >= 3 ? parts[parts.length - 2] : "";
  const faction = parts.length >= 4 ? parts[parts.length - 3] : "";

  return {
    raw,
    parts,
    category,
    faction,
    type: "",
  };
}

export function mapQualityToRarity(quality) {
  const q = String(quality || "").trim();
  return qualityToRarityMap[q] || "N";
}

// 아래 함수들은 기존 utils.js 에 있던 내용을 그대로 유지하면서 파일만 분리했다.
export function resolveMainStat(item) {
  // main option(주옵션) 후보 필드들을 순서대로 확인
  // (원본 데이터 스키마가 계속 변동 가능해서 널널하게 대응)
  const keys = [
    "attack_SN",
    "healthPoint_SN",
    "defence_SN",
  ];

  for (const k of keys) {
    const v = safeNumber(item && item[k], 0);
    if (v !== 0) return { key: k, value: v };
  }

  return { key: "", value: 0 };
}

// 성장 스탯 범위 계산 (성장 테이블 기준)
export function calcEquipStatRange(baseValue, growthList) {
  const base = safeNumber(baseValue, 0);
  const list = Array.isArray(growthList) ? growthList : [];

  if (list.length <= 0) {
    return { min: base, max: base };
  }

  let mn = base;
  let mx = base;

  for (const g of list) {
    const v = safeNumber(g && g.value, 0);
    if (v < mn) mn = v;
    if (v > mx) mx = v;
  }

  return { min: mn, max: mx };
}

export function calcMainStatWithGrowth(baseValue, growth, level) {
  const base = safeNumber(baseValue, 0);
  const lv = Math.max(1, safeNumber(level, 1));
  if (!growth) return base;

  // 성장 구조가 바뀔 수 있어서 널널하게: growth.levelValueList / growth.valueList 등 후보
  const list = growth.levelValueList || growth.valueList || growth.list || [];
  if (!Array.isArray(list) || list.length <= 0) return base;

  // level-1 인덱스 접근 (범위 밖이면 마지막값)
  const idx = Math.min(Math.max(lv - 1, 0), list.length - 1);
  const v = safeNumber(list[idx] && (list[idx].value ?? list[idx]), 0);

  return v || base;
}

export function getFixedOptionMax(option) {
  if (!option) return 0;

  // 후보 필드(프로젝트에서 이미 쓰는 패턴 유지)
  const max = safeNumber(option.max, 0);
  if (max) return max;

  return safeNumber(option.valueMax, 0);
}
