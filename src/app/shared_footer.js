// app/shared_footer.js
const CACHE_BUST = "2025-12-18_03";

function addCacheBust(url) {
  if (!url) return url;
  const s = String(url);
  if (s.includes("v=")) return s;
  return s.includes("?") ? (s + "&v=" + CACHE_BUST) : (s + "?v=" + CACHE_BUST);
}

document.addEventListener('DOMContentLoaded', () => {
  const host = document.getElementById('shared-footer');
  if (!host) { return; }

  const parts = (location.pathname || '').split('/').filter(Boolean);
  const srcIndex = parts.lastIndexOf('src');
  const basePath = srcIndex > 0 ? '/' + parts.slice(0, srcIndex).join('/') : '';

  const footerUrl = basePath + '/src/page/common/footer_main.html';

  fetch(addCacheBust(footerUrl))
    .then((r) => {
      if (!r.ok) {
        throw new Error(`Fetch failed: ${footerUrl} (${r.status})`);
      }
      return r.text();
    })
    .then((html) => {
      host.innerHTML = html;
    })
    .catch((err) => {
      console.error('[shared_footer] load failed:', err);
      host.innerHTML = '';
    });
});