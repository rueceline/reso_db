/* shared_header.js
   - Loads /src/page/common/header.html into #shared-header
   - Normalizes nav links (data-path) to correct relative hrefs
   - Marks active nav item based on current page
*/
(function () {
  if (window.__RSO_SHARED_HEADER_LOADED__) { return; }
  window.__RSO_SHARED_HEADER_LOADED__ = true;

  function getRootPrefix() {
    const path = window.location.pathname;              // 예: /reso_db/index.html
    const parts = path.split('/').filter(Boolean);      // 예: ["reso_db","index.html"]

    // 로컬/개발 서버(도메인 루트에서 서빙되는 경우) 또는 /src/... 로 직접 열었을 때
    // -> base는 "/"
    if (parts.length === 0 || parts[0] === 'src') {
      return '/';
    }

    // github.io 프로젝트 페이지: /<repo>/... 형태
    if (window.location.hostname.endsWith('github.io')) {
      return '/' + parts[0] + '/';                      // 예: "/reso_db/"
    }

    // 그 외(커스텀 도메인 등)는 일단 루트 기준
    return '/';
  }

  function resolveHref(rootPrefix, dataPath) {
    if (!dataPath) { return '#'; }

    if (dataPath.startsWith('http://') || dataPath.startsWith('https://')) {
      return dataPath;
    }

    if (dataPath.startsWith('#')) {
      return dataPath;
    }

    // allow "index.html" or "src/page/xxx.html"
    let target = dataPath;
    if (!target.endsWith('.html') && !target.includes('.')) {
      target = target + '.html';
    }

    return rootPrefix + target;
  }

  function setActiveNav(rootPrefix) {
    const here = (location.pathname || '').replace(/\/+$/, '');
    const links = document.querySelectorAll('[data-role="shared-header"] a[data-path]');

    links.forEach((a) => {
      const p = a.getAttribute('data-path') || '';
      const href = resolveHref(rootPrefix, p);

      // mark active only for internal html targets
      let active = false;
      if (!(p.startsWith('http://') || p.startsWith('https://')) && !p.startsWith('#')) {
        // Normalize compare by ending with target path (no query)
        const targetPath = (href || '').split('?')[0].replace(rootPrefix, '/').replace(/\/+$/, '');
        active = (here === targetPath) || (here.endsWith('/' + (p.split('/').pop() || '')));
      }

      a.classList.toggle('is-active', active);
      if (active) {
        a.setAttribute('aria-current', 'page');
      } else {
        a.removeAttribute('aria-current');
      }
    });
  }

  function normalizeNavLinks(rootPrefix) {
    const links = document.querySelectorAll('[data-role="shared-header"] a[data-path]');
    links.forEach((a) => {
      const p = a.getAttribute('data-path') || '';
      const href = resolveHref(rootPrefix, p);

      a.href = href;

      if (p.startsWith('http://') || p.startsWith('https://')) {
        a.target = '_blank';
        a.rel = 'noopener noreferrer';
      } else {
        // Ensure navigation happens even if href is "#"
        a.addEventListener('click', (e) => {
          if (p.startsWith('#')) { return; }
          // allow normal open-in-new-tab etc
          if (e.defaultPrevented) { return; }
          if (e.metaKey || e.ctrlKey || e.shiftKey || e.altKey || e.button !== 0) { return; }
          e.preventDefault();
          location.href = href;
        });
      }
    });
  }

  async function loadSharedHeader() {
    const mount = document.getElementById('shared-header');
    if (!mount) { return; }

    const rootPrefix = getRootPrefix();
    const headerUrl = rootPrefix + 'src/page/common/header.html';

    // const res = await fetch(headerUrl, { cache: 'no-store' });
    const res = await fetch(headerUrl);

    if (!res.ok) {
      console.warn('[shared_header] header fetch failed:', res.status, headerUrl);
      return;
    }

    mount.innerHTML = await res.text();

    mount.setAttribute('data-root-prefix', rootPrefix);

    const headerRoot = mount.querySelector('.topbar');
    if (headerRoot) {
      headerRoot.setAttribute('data-role', 'shared-header');
    } else {
      mount.setAttribute('data-role', 'shared-header');
    }

    normalizeNavLinks(rootPrefix);
    setActiveNav(rootPrefix);
  }


  function onReady(fn) {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', fn);
    } else {
      fn();
    }
  }

  onReady(() => {
    loadSharedHeader().catch((err) => {
      console.warn('[shared_header] load failed:', err);
    });
  });
})();