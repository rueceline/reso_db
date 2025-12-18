/* shared_header.js
   - Loads /src/page/common/header.html into #shared-header
   - Normalizes nav links (data-path) to correct relative hrefs
   - Marks active nav item based on current page
*/
(function () {
  if (window.__RSO_SHARED_HEADER_LOADED__) { return; }
  window.__RSO_SHARED_HEADER_LOADED__ = true;

  function getRootPrefix() {
    // Example:
    //  - /index.html               -> ""
    //  - /src/page/equipmentdb.html -> "../../"
    //  - /src/characterdb.html     -> "../"
    const path = (location.pathname || '/').replace(/\/+$/, '');
    const parts = path.split('/').filter(Boolean);

    // If pointing to a file, drop it for directory depth
    const isFile = parts.length > 0 && parts[parts.length - 1].includes('.');
    const depth = isFile ? Math.max(0, parts.length - 1) : parts.length;

    return '../'.repeat(depth);
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
    const headerUrl = new URL('common/header.html', window.location.href).href;

    // const res = await fetch(headerUrl, { cache: 'no-store' });
    const res = await fetch(headerUrl);

    if (!res.ok) {
      console.warn('[shared_header] header fetch failed:', res.status, headerUrl);
      return;
    }

    mount.innerHTML = await res.text();

    // Ensure rootPrefix is available to any inline logic (if needed)
    mount.setAttribute('data-root-prefix', rootPrefix);

    // Add a marker for scoping
    const headerRoot = mount.querySelector('.topbar');
    if (headerRoot) {
      headerRoot.setAttribute('data-role', 'shared-header');
    } else {
      // fallback: set marker on mount so selectors still work
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