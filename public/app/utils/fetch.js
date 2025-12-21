/**
 * fetch 공통 유틸
 * - CACHE_BUST를 자동으로 반영해 캐시 문제를 줄인다.
 * - 페이지별 에러 메시지 일관성을 위해 여기서 throw한다.
 */
import { CACHE_BUST } from "./config.js";

export async function fetchJson(url, opt = {}) {
  const bust = opt.cacheBust ?? CACHE_BUST;
  const u = bust ? `${url}?v=${encodeURIComponent(bust)}` : url;

  const res = await fetch(u, { cache: "no-store" });
  if (!res.ok) {
    throw new Error("fetch failed: " + res.status + " " + u);
  }
  return await res.json();
}
