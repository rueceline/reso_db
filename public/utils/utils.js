// app/utils/utils.js
//
// 목적:
// - DOM(dom.js), 데이터 해석(data.js), 경로(path.js), 설정(config.js)은 분리 유지
// - 그 외 공통 유틸(fetch / query / text / 기본)을 한 파일로 묶어 관리

// =========================
// 0. Imports
// =========================
import { CACHE_BUST } from "./config.js";

// =========================
// 1. Fetch helpers
// =========================

/**
 * JSON fetch 공통 유틸
 * - cache bust를 자동 반영한다.
 * - 실패 시 일관된 에러 메시지로 throw 한다.
 */
export async function fetchJson(url, opt = {}) {
  const bust = opt.cacheBust ?? CACHE_BUST;
  const u = bust ? `${url}?v=${encodeURIComponent(bust)}` : url;

  const res = await fetch(u, { cache: "no-store" });
  if (!res.ok) {
    throw new Error("fetch failed: " + res.status + " " + u);
  }

  return await res.json();
}

// =========================
// 2. Query helpers (URL params)
// =========================

/**
 * URLSearchParams에서 특정 키 값을 가져온다.
 * - 없으면 null 반환
 */
export function getQueryParam(key) {
  const params = new URLSearchParams(window.location.search);
  const v = params.get(key);
  return v === null ? null : v;
}

// =========================
// 3. Text / Markup helpers
// =========================

/**
 * <color=#RRGGBB>...</color> 태그를 span 스타일로 변환한다.
 * - 기본적으로 단순 치환(정규식)으로 처리한다.
 * - 알 수 없는/깨진 태그는 가능한 그대로 남긴다.
 */
export function formatColorTagsToHtml(text) {
  if (text == null) { return ""; }

  let out = String(text);

  // 시작 태그: <color=#RRGGBB> 또는 <color=#AARRGGBB>
  // - AA가 포함되면 무시하고 뒤 6자리만 사용(프로젝트 내 사용 패턴 기준)
  out = out.replace(/<color\s*=\s*#([0-9a-fA-F]{6}|[0-9a-fA-F]{8})\s*>/g, function (_, hex) {
    const h = String(hex);
    const rgb = h.length === 8 ? h.slice(2) : h;
    return `<span style="color:#${rgb};">`;
  });

  // 종료 태그
  out = out.replace(/<\/color\s*>/g, "</span>");

  return out;
}

/**
 * HTML escape
 */
export function escapeHtml(s) {
  return String(s ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}

// =========================
// 4. Basic helpers (non-DOM)
// =========================

/**
 * \ -> / 로 슬래시 통일
 * - path.js의 join 규칙과는 별개로 "문자열 정규화"만 담당
 */
export function normalizePathSlash(s) {
  return String(s || "").replaceAll("\\", "/");
}
