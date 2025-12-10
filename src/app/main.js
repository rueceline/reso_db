// scripts/main.js

document.addEventListener('DOMContentLoaded', () => {
  setupLangButtons();
});

/**
 * 상단 언어 버튼(KR / JP / EN / CN) 클릭 처리
 * - active 클래스 토글
 * - <html lang="..."> 갱신 (ko / ja / en / zh)
 */
function setupLangButtons() {
  const langButtons = document.querySelectorAll('.lang-btn');
  if (!langButtons.length) {
    return;
  }

  const htmlEl = document.documentElement;
  const initialLang = htmlEl.getAttribute('lang') || 'ko';

  // 초기 상태에서 html lang 기준으로 active 동기화
  langButtons.forEach(btn => {
    const btnLang = btn.getAttribute('data-lang');
    const htmlLangFromBtn = mapButtonLangToHtmlLang(btnLang);

    if (htmlLangFromBtn === initialLang) {
      btn.classList.add('active');
    } else {
      btn.classList.remove('active');
    }
  });

  langButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const selectedBtnLang = btn.getAttribute('data-lang');

      // 버튼 active 토글
      langButtons.forEach(b => {
        b.classList.toggle('active', b === btn);
      });

      // html lang 속성 갱신
      const htmlLang = mapButtonLangToHtmlLang(selectedBtnLang);
      htmlEl.setAttribute('lang', htmlLang);

      console.log('Selected language:', selectedBtnLang);
      // 나중에 다국어 UI 적용할 때 여기에서 텍스트 교체 로직을 추가하면 됩니다.
    });
  });
}

/**
 * 버튼 data-lang 값(KR/JP/EN/CN)을
 * 실제 html lang 속성 값(ko/ja/en/zh)으로 변환
 */
function mapButtonLangToHtmlLang(buttonLang) {
  switch (buttonLang) {
    case 'kr':
      return 'ko';
    case 'jp':
      return 'ja';
    case 'cn':
      return 'zh';
    case 'en':
      return 'en';
    default:
      return 'ko';
  }
}
