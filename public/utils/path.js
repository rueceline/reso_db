// public/app/utils/path.js
//
// 목적:
// - 프로젝트 전역에서 경로 조합 규칙을 1곳으로 통일
// - 페이지 코드에서 'data/..', 'assets/..' 문자열 조합 금지
//
// 원칙:
// - 런타임 URL 기준으로만 생성한다.
// - BASE는 window.getAppBase()가 있으면 그 값을 사용한다.
// - cache bust(쿼리)는 fetchJson(url, CACHE_BUST)에서 처리한다.

const META_BASE = (document.querySelector('meta[name="app-base"]') && document.querySelector('meta[name="app-base"]').getAttribute('content')) || '/';
const BASE = (window.getAppBase && window.getAppBase()) || META_BASE || '/';
function normalizeSlash(s) {
  return String(s || "").replace(/\\/g, "/");
}

function stripSlashes(s) {
  return normalizeSlash(s).replace(/^\/+|\/+$/g, "");
}

function joinPath() {
  const parts = Array.prototype.slice.call(arguments);
  const cleaned = parts.map(stripSlashes).filter((v) => v.length > 0);

  return cleaned.join("/");
}

function joinUrl() {
  const joined = joinPath.apply(null, arguments);
  if (!joined) return BASE;

  const baseClean = normalizeSlash(BASE).replace(/\/+$/g, "");
  if (!baseClean || baseClean === "/") return "/" + joined;
  return baseClean + "/" + joined;
}

// data/{lang}/{file}
export function dataPath(lang, file) {
  return joinUrl("data", lang, file);
}

// assets/{subPath}
export function assetPath(subPath) {
  return joinUrl("assets", subPath);
}

export function pagePath(rel) {
  return joinUrl(rel);
}

// assets/ui/{relPath}
export function uiImagePath(relPath) {
  return assetPath(joinPath("ui", relPath));
}

// assets/book/{relPath}
export function bookImagePath(relPath) {
  return assetPath(joinPath("book", relPath));
}

// assets/showcharacter/{relPath}
export function showCharacterPath(relPath) {
  return assetPath(joinPath("showcharacter", relPath));
}

// assets/ui/common/{relPath}
export function uiCommonPath(relPath) {
  return assetPath(joinPath("ui/common", relPath));
}

// assets/ui/common/characterlist/{relPath}
export function uiCharacterListPath(relPath) {
  return uiCommonPath(joinPath("characterlist", relPath));
}

// assets/ui/common/sideicon/{relPath}
export function uiSideIconPath(relPath) {
  return uiCommonPath(joinPath("sideicon", relPath));
}

// 점진 마이그레이션 편의: window에도 노출 (원하면 사용)
if (typeof window !== "undefined") {
  window.dataPath = dataPath;
  window.assetPath = assetPath;
  window.weaponImagePath = weaponImagePath;
  window.uiImagePath = uiImagePath;
  window.bookImagePath = bookImagePath;
  window.showCharacterPath = showCharacterPath;
  window.uiCommonPath = uiCommonPath;
  window.uiCharacterListPath = uiCharacterListPath;
  window.uiSideIconPath = uiSideIconPath;
}