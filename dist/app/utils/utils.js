// =========================
// 1. 상수 / 매핑
// =========================



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
