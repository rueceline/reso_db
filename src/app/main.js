const langButtons = document.querySelectorAll('.lang-btn');

langButtons.forEach(btn => {
  btn.addEventListener('click', () => {
    const lang = btn.getAttribute('data-lang');
    langButtons.forEach(b => b.classList.toggle('active', b === btn));

    console.log('Selected language:', lang);
    // 나중에 다국어 UI 적용할 때 여기서 텍스트 교체 로직을 추가하면 됩니다.
  });
});
