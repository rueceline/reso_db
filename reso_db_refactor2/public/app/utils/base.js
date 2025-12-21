// app/utils/base.js
//
// 목적:
// - GitHub Pages(서브 경로) / 로컬 서버 어디서든 동일한 BASE 경로 제공
// - 페이지 전반에서 사용하는 "환경/경로/기본 유틸" 제공
//
// 원칙:
// - 이 파일은 "환경/경로/기본 유틸"만 담당
// - 도메인(equipment/skill/character 등) 로직은 넣지 않는다

function normalizeBase(v) {
  let s = String(v || "/").trim();
  if (!s) s = "/";

  // 항상 끝에 '/' 유지
  if (!s.endsWith("/")) s += "/";

  return s;
}
function getMetaBase() {
  const el = document.querySelector('meta[name="app-base"]');
  if (!el) return null;

  const v = el.getAttribute("content");
  if (!v) return null;

  return normalizeBase(v);
}
function getBodyBase() {
  const v = document.body ? document.body.getAttribute("data-base") : null;
  if (!v) return null;

  return normalizeBase(v);
}
function getAppBase() {
  // 1) <meta name="app-base" content="..."> (Astro BaseLayout)
  const m = getMetaBase();
  if (m) return m;

  // 2) <body data-base="..."> (정적 페이지 fallback)
  const b = getBodyBase();
  if (b) return b;

  // 3) pathname 기반 보정(최후 수단): GitHub Pages에서 루트가 /repo/ 인 경우가 많음
  //    여기서는 "현재 경로가 /public/ 를 포함하면 그 앞을 BASE로 본다" 정도만 수행.
  const path = String(location && location.pathname ? location.pathname : "/");
  const idx = path.indexOf("/public/");
  if (idx >= 0) {
    const cand = path.slice(0, idx + 1); // trailing '/'
    return normalizeBase(cand);
  }

  return "/";
}
function withBase(path) {
  const base = getAppBase();
  const p = String(path || "");
  if (!p) return base;

  // 이미 절대 URL이면 그대로
  if (/^https?:\/\//i.test(p)) return p;

  // 중복 슬래시 방지
  if (base.endsWith("/") && p.startsWith("/")) return base + p.slice(1);

  return base + p;
}
function byString(v) {
  if (v === null || v === undefined) return "";
  return String(v);
}
function safeNumber(v, fallback = 0) {
  const n = Number(v);
  return Number.isFinite(n) ? n : fallback;
}
function formatNumber(v) {
  const n = safeNumber(v, NaN);
  if (!Number.isFinite(n)) return "";

  try {
    return n.toLocaleString("ko-KR");
  } catch (e) {
    return String(n);
  }
}
function escapeHtml(s) {
  const str = byString(s);
  return str
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}
function normalizePathSlash(path) {
  return byString(path).replaceAll("\\", "/");
}
function addCacheBust(url, bust) {
  const u = byString(url);
  if (!u) return u;

  const b = byString(bust);
  if (!b) return u;

  return u + (u.includes("?") ? "&" : "?") + "v=" + encodeURIComponent(b);
}
async function fetchJson(url, opt) {
  const res = await fetch(url, opt || { cache: "no-store" });
  if (!res.ok) {
    const msg = "[fetchJson] " + res.status + " " + url;
    throw new Error(msg);
  }

  return await res.json();
}
function normalizeRootJson(v) {
  // 여러 파서 결과가 { list: [...] } 또는 직접 [...] 로 올 수 있는 걸 흡수
  if (Array.isArray(v)) return v;
  if (v && typeof v === "object") {
    if (Array.isArray(v.list)) return v.list;
    if (Array.isArray(v.data)) return v.data;
  }

  return [];
}
function buildIdMap(list, key = "id") {
  const map = new Map();
  const arr = Array.isArray(list) ? list : [];
  for (const it of arr) {
    if (!it) continue;
    const k = it[key];
    if (k === null || k === undefined) continue;
    map.set(k, it);
  }
  return map;
}

// ---- global export (classic script) ----
(function () {
  if (typeof window === "undefined") { return; }

  window.RSBase = window.RSBase || {};
  window.RSBase.normalizeBase = normalizeBase;
  window.RSBase.getMetaBase = getMetaBase;
  window.RSBase.getBodyBase = getBodyBase;
  window.RSBase.getAppBase = getAppBase;
  window.RSBase.withBase = withBase;
  window.RSBase.byString = byString;
  window.RSBase.safeNumber = safeNumber;
  window.RSBase.formatNumber = formatNumber;
  window.RSBase.escapeHtml = escapeHtml;
  window.RSBase.normalizePathSlash = normalizePathSlash;
  window.RSBase.addCacheBust = addCacheBust;
  window.RSBase.fetchJson = fetchJson;
  window.RSBase.normalizeRootJson = normalizeRootJson;
  window.RSBase.buildIdMap = buildIdMap;

  // 레거시 호환
  window.getAppBase = getAppBase;
  window.withBase = withBase;
})();
