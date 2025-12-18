// src/app/shared_header.js
document.addEventListener('DOMContentLoaded', () => {
  const host = document.getElementById('shared-header');
  if (!host) { return; }

  const parts = (location.pathname || '').split('/').filter(Boolean);
  const srcIndex = parts.lastIndexOf('src');
  const basePath = srcIndex > 0 ? '/' + parts.slice(0, srcIndex).join('/') : '';

  const headerUrl = basePath + '/src/page/common/header.html';

  const getMode = () => {
    try { return localStorage.getItem('theme_mode') || 'dark'; } catch { return 'dark'; }
  };

  const setMode = (mode) => {
    try { localStorage.setItem('theme_mode', mode); } catch {}
  };

  const applyTheme = (mode) => {
    if (mode === 'light') {
      document.documentElement.setAttribute('data-theme', 'light');
    } else {
      document.documentElement.removeAttribute('data-theme');
    }
  };

  applyTheme(getMode());

  fetch(headerUrl, { cache: 'no-cache' })
    .then((r) => {
      if (!r.ok) { throw new Error('header fetch failed: ' + r.status + ' ' + headerUrl); }
      return r.text();
    })
    .then((html) => {
      host.innerHTML = html;

      // resolve href from data-path (GitHub Pages 서브경로 대응)
      host.querySelectorAll('[data-path]').forEach((el) => {
        const p = el.getAttribute('data-path') || '';
        const clean = p.replace(/^\/+/, '');
        el.setAttribute('href', basePath + '/' + clean);
      });

      // active state
      const path = (location.pathname || '').toLowerCase();
      const markActive = (key, pred) => {
        const el = host.querySelector(`[data-nav="${key}"]`);
        if (!el) { return; }
        if (pred()) { el.classList.add('active'); }
      };

      markActive('character', () => path.includes('/characterdb'));
      markActive('equipment', () => path.includes('/equipmentdb') || path.includes('/equipment_detail'));
      markActive('dex_home', () => path.includes('/dex'));
      markActive('home', () => path.endsWith('/index.html') || path.endsWith('/'));

      // dropdown click support (mobile)
      const group = host.querySelector('.nav-group');
      const trigger = host.querySelector('.nav-trigger');
      if (group && trigger) {
        trigger.addEventListener('click', (e) => {
          e.preventDefault();
          const open = group.classList.toggle('open');
          trigger.setAttribute('aria-expanded', open ? 'true' : 'false');
        });
      }

      // theme toggle (label shows CURRENT mode)
      const themeBtn = host.querySelector('#theme-toggle');
      const refreshThemeBtn = () => {
        if (!themeBtn) { return; }
        const mode = getMode();
        themeBtn.textContent = (mode === 'light') ? '라이트' : '다크';
      };

      if (themeBtn) {
        refreshThemeBtn();
        themeBtn.addEventListener('click', (e) => {
          e.preventDefault();
          const cur = getMode();
          const next = (cur === 'light') ? 'dark' : 'light';
          setMode(next);
          applyTheme(next);
          refreshThemeBtn();
        });
      }
    })
    .catch((err) => {
      console.error('[shared_header] load failed:', err);
      host.innerHTML = '';
    });
});
