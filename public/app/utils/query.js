/**
 * URL 쿼리 유틸
 * - 페이지 전반에서 공통으로 사용하는 쿼리 파라미터 접근 함수
 */

/**
 * URLSearchParams에서 특정 키 값을 가져온다.
 * - 없으면 null 반환
 */
export function getQueryParam(key) {
  const params = new URLSearchParams(window.location.search);
  const v = params.get(key);
  return v === null ? null : v;
}
