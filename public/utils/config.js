/**
 * 공통 설정
 * - 페이지별로 흩어지는 상수를 한 곳에서 관리한다.
 * - Astro + ESM 환경을 전제로 한다.
 */

// 캐시 무효화용 버전 문자열 (필요 시 값만 변경)
export const CACHE_BUST = "2025-12-18_03";

// 기본 언어 (필요 시 페이지에서 override 가능)
export const DEFAULT_LANG = "KR";

// 이미지 확장자
export const IMAGE_EXT = 'png';

// 실행 환경: 'dev' | 'prod'
export const APP_ENV = 'dev';

// fetch cache 옵션 (환경별)
export const FETCH_CACHE_MODE = APP_ENV === 'dev' ? 'no-store' : 'force-cache';

// export const FETCH_CACHE_MODE = import.meta.env.DEV ? 'no-store' : 'force-cache';