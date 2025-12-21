// app/utils/base.js
//
// 목적:
// - GitHub Pages(서브 경로) / 로컬 서버 어디서든 동일한 BASE 경로 제공
// - 페이지 전반에서 사용하는 공용 유틸리티 제공
//
// 원칙:
// - 이 파일은 "환경/경로/기본 유틸"만 담당
// - 도메인(equipment/skill 등) 로직은 절대 넣지 않는다
//
// 제공 기능:
// - BASE 계산 (getAppBase / withBase)
// - 문자열 / 숫자 / JSON / fetch 유틸
// - 경로 정규화

(function () {
  /* ==========================================================================
   * BASE URL 처리
   * ========================================================================== */

  function normalizeBase(v) {
    var s = String(v || '/').trim();
    if (!s) s = '/';

    // 항상 끝에 '/' 유지
    if (!s.endsWith('/')) s += '/';

    // '//' 방지 (프로토콜 제외)
    return s;
  }

  // <meta name="app-base" content="..."> 에서 BASE 읽기
  function getMetaBase() {
    var meta = document.querySelector('meta[name="app-base"]');
    if (!meta) return '';
    var v = meta.getAttribute('content');
    return v ? String(v) : '';
  }

  // <body data-base-url="..."> 에서 BASE 읽기
  function getBodyBase() {
    var b = document.body;
    if (!b) return '';
    var v = b.getAttribute('data-base-url') || (b.dataset ? b.dataset.baseUrl : '');
    return v ? String(v) : '';
  }

  // 앱 전체 BASE URL 결정
  // 우선순위:
  // 1) meta[name="app-base"]
  // 2) body[data-base-url]
  // 3) '/'
  function getAppBase() {
    var metaBase = getMetaBase();
    if (metaBase) return normalizeBase(metaBase);

    var bodyBase = getBodyBase();
    if (bodyBase) return normalizeBase(bodyBase);

    return '/';
  }

  // BASE를 고려하여 경로를 완성한다
  function withBase(path) {
    var base = getAppBase();
    var p = String(path || '');

    if (!p) return base;

    // 절대 URL은 그대로
    if (p.startsWith('http://') || p.startsWith('https://')) return p;

    // query / hash 전용
    if (p.startsWith('?') || p.startsWith('#')) {
      return base.replace(/\/$/, '') + p;
    }

    // '/xxx' 형태
    if (p.startsWith('/')) {
      return base.replace(/\/$/, '') + p;
    }

    // './xxx' 제거
    p = p.replace(/^\.\//, '');
    return base + p;
  }

  /* ==========================================================================
   * 문자열 / 숫자 유틸
   * ========================================================================== */

  // null / undefined 안전 문자열 변환
  function byString(v) {
    if (v === null || v === undefined) return '';
    return String(v);
  }

  // 숫자 변환 (실패 시 빈 문자열)
  function safeNumber(v) {
    if (v === null || v === undefined) return '';
    if (typeof v === 'number') return v;

    var n = Number(v);
    if (Number.isFinite(n)) return n;
    return '';
  }

  // 숫자 포맷 (표시용)
  function formatNumber(v) {
    if (v === null || v === undefined || v === '') return '';

    var n = Number(v);
    if (!Number.isFinite(n)) return byString(v);

    return n.toLocaleString('en-US', { maximumFractionDigits: 3 });
  }

  // HTML 이스케이프 (XSS 방지)
  function escapeHtml(v) {
    var s = byString(v);

    return s
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&#039;');
  }

  /* ==========================================================================
   * 경로 / JSON / fetch 유틸
   * ========================================================================== */

  // '\\' → '/' 경로 정규화 (Unity / Windows 경로 대응)
  function normalizePathSlash(s) {
    return String(s || '').replaceAll('\\', '/');
  }

  // cache bust 파라미터 추가
  function addCacheBust(url, cacheBust) {
    if (!url) return url;

    var s = String(url);
    if (s.includes('v=')) return s;

    var v = String(cacheBust || '').trim();
    if (!v) return s;

    return s.includes('?') ? (s + '&v=' + v) : (s + '?v=' + v);
  }

  // JSON fetch 공통 함수
  function fetchJson(url, cacheBust) {
    return fetch(addCacheBust(url, cacheBust), { cache: 'no-store' })
      .then(function (res) {
        if (!res.ok) {
          throw new Error('Fetch failed: ' + url + ' (' + res.status + ')');
        }
        return res.json();
      });
  }

  // { data: [...] } / { list: [...] } / [...] 모두 배열로 정규화
  function normalizeRootJson(json) {
    if (Array.isArray(json)) return json;
    if (json && Array.isArray(json.data)) return json.data;
    if (json && Array.isArray(json.list)) return json.list;
    return [];
  }

  // id → row Map 생성
  function buildIdMap(list) {
    var map = new Map();
    for (var i = 0; i < (list || []).length; i++) {
      var row = list[i];
      var id = Number(row && row.id || 0);
      if (id) map.set(id, row);
    }
    return map;
  }

  /* ==========================================================================
   * 전역 노출 (기존 코드와의 호환 유지)
   * ========================================================================== */

  window.getAppBase = getAppBase;
  window.withBase = withBase;

  // 공용 유틸
  window.byString = byString;
  window.safeNumber = safeNumber;
  window.formatNumber = formatNumber;
  window.escapeHtml = escapeHtml;
  window.normalizePathSlash = normalizePathSlash;
  window.addCacheBust = addCacheBust;
  window.fetchJson = fetchJson;
  window.normalizeRootJson = normalizeRootJson;
  window.buildIdMap = buildIdMap;
})();
