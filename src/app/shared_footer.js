// app/shared_footer.js
document.addEventListener('DOMContentLoaded', () => {
  const host = document.getElementById('shared-footer');
  if (!host) { return; }

  fetch('page/common/footer_main.html')
    .then((r) => r.text())
    .then((html) => {
      host.innerHTML = html;
    })
    .catch(() => {
      host.innerHTML = '';
    });
});
