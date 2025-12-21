// app/utils/utils.js
//
// 목적:
// - "팩토리(JSON) 로드" 및 "공통 유틸" 제공
//
// 원칙:
// - 도메인별 계산 로직(장비 스탯 계산 등)은 별도 파일로 분리한다 (예: equipment.js)
// - 이 파일은 "데이터 접근 + 범용 유틸"만 담당
function uniqSorted(list) {
  const arr = Array.from(
    new Set(
      (list || [])
        .filter(Boolean)
        .map((v) => String(v).trim())
        .filter(Boolean),
    ),
  );
  arr.sort((a, b) => a.localeCompare(b, "ko"));
  return arr;
}
function isInvalidGroupValue(v) {
  const s = String(v || "").trim();
  if (!s) return true;
  // 예: 00测试, 00乱斗 같은 테스트/더미 그룹값
  if (s.startsWith("00")) return true;
  return false;
}

// base 의존
function rsBase() {
  return (typeof window !== "undefined" && window.RSBase) ? window.RSBase : {};
}

// ---------------- Factory loader ----------------
function factoryPath(factoryName, region = "KR") {
  const name = String(factoryName || "").trim();
  const reg = String(region || "KR").trim();
  return rsBase().withBase(`public/data/${reg}/${name}.json`);
}
async function loadFactory(factoryName, region = "KR", opt) {
  const url = factoryPath(factoryName, region);
  const json = await rsBase().fetchJson(url, opt);
  return rsBase().normalizeRootJson(json);
}
async function loadFactories(factoryNames, region = "KR", opt) {
  const names = Array.isArray(factoryNames) ? factoryNames : [];
  const tasks = names.map((n) => loadFactory(n, region, opt).then((list) => [n, list]));
  const pairs = await Promise.all(tasks);
  const out = {};
  for (const [n, list] of pairs) {
    out[n] = list;
  }
  return out;
}

// ---- global export (classic script) ----
(function () {
  if (typeof window === "undefined") { return; }
  window.RSUtils = window.RSUtils || {};
  window.RSUtils.uniqSorted = uniqSorted;
  window.RSUtils.isInvalidGroupValue = isInvalidGroupValue;
  window.RSUtils.factoryPath = factoryPath;
  window.RSUtils.loadFactory = loadFactory;
  window.RSUtils.loadFactories = loadFactories;
})();
