// app/main.js
// 공통 인터랙션(헤더/테마/언어/모바일 메뉴)

(function () {
  function qs(sel, root) {
    return (root || document).querySelector(sel);
  }

  function getStored(key, fallback) {
    try {
      var v = localStorage.getItem(key);
      return v ? v : fallback;
    } catch (e) {
      return fallback;
    }
  }

  function setStored(key, value) {
    try {
      localStorage.setItem(key, value);
    } catch (e) {
      // ignore
    }
  }

  // ---------- Theme ----------
  function applyTheme(mode) {
    var html = document.documentElement;

    // [추가] CSS가 보는 기준은 data-theme 이므로 이걸 반드시 설정
    html.setAttribute("data-theme", mode);

    // [유지] 기존 class 방식도 혹시 다른 곳에서 쓰면 깨질 수 있으니 같이 유지
    if (mode === "light") {
      html.classList.add("theme-light");
      html.classList.remove("theme-dark");
    } else {
      html.classList.add("theme-dark");
      html.classList.remove("theme-light");
    }

    var btn = qs("#theme-toggle");
    if (btn) {
      var pillIcon = btn.querySelector(".pill-icon");
      var pillText = btn.querySelector(".pill-text");

      if (pillIcon) {
        pillIcon.textContent = mode === "light" ? "☀" : "🌙";
      }

      if (pillText) {
        pillText.textContent = mode === "light" ? "라이트" : "다크";
      }

      // [수정] textContent로 버튼 내부를 갈아엎지 말고, .pill-text만 바꿈
      var pillText = btn.querySelector(".pill-text");
      if (pillText) {
        pillText.textContent = mode === "light" ? "라이트" : "다크";
      } else {
        // 혹시 구조가 다르면 fallback
        btn.textContent = mode === "light" ? "라이트" : "다크";
      }

      btn.setAttribute("aria-pressed", mode === "light" ? "true" : "false");
      btn.classList.toggle("is-light", mode === "light");
    }
  }

  function setupThemeToggle() {
    var mode = getStored("theme_mode", "dark");
    applyTheme(mode);

    var btn = qs("#theme-toggle");
    if (!btn) {
      return;
    }

    btn.addEventListener("click", function () {
      var cur = getStored("theme_mode", "dark");
      var next = cur === "light" ? "dark" : "light";
      setStored("theme_mode", next);
      applyTheme(next);
    });
  }

  // ---------- Language ----------
  // UI는 단일 토글 버튼(#lang-toggle) 기준으로 운용
  var LANG_ORDER = ["kr", "en", "jp", "cn"];

  function mapToHtmlLang(code) {
    if (code === "kr") {
      return "ko";
    }
    if (code === "jp") {
      return "ja";
    }
    if (code === "cn") {
      return "zh";
    }
    if (code === "en") {
      return "en";
    }
    return "ko";
  }

  function mapToLabel(code) {
    if (code === "kr") {
      return "KR";
    }
    if (code === "jp") {
      return "JP";
    }
    if (code === "cn") {
      return "CN";
    }
    if (code === "en") {
      return "EN";
    }
    return "KR";
  }

  function applyLang(code) {
    document.documentElement.setAttribute("lang", mapToHtmlLang(code));
    var btn = qs("#lang-toggle");
    if (btn) {
      btn.textContent = mapToLabel(code);
      btn.setAttribute("data-lang", code);
    }
  }

  function setupLangToggle() {
    var btn = qs("#lang-toggle");
    if (!btn) {
      return;
    }

    var stored = getStored("lang", "kr");
    if (LANG_ORDER.indexOf(stored) < 0) {
      stored = "kr";
    }

    applyLang(stored);

    btn.addEventListener("click", function () {
      var cur = getStored("lang", "kr");
      var idx = LANG_ORDER.indexOf(cur);
      if (idx < 0) {
        idx = 0;
      }
      var next = LANG_ORDER[(idx + 1) % LANG_ORDER.length];
      setStored("lang", next);
      applyLang(next);
    });
  }

  // ---------- Mobile nav ----------
  function setupMobileNav() {
    var burger = qs(".header-burger");
    var mobileNav = qs(".mobile-nav");
    if (!burger || !mobileNav) {
      return;
    }

    function open() {
      burger.setAttribute("aria-expanded", "true");
      mobileNav.setAttribute("aria-hidden", "false");
      document.body.classList.add("nav-open");
    }

    function close() {
      burger.setAttribute("aria-expanded", "false");
      mobileNav.setAttribute("aria-hidden", "true");
      document.body.classList.remove("nav-open");
    }

    function toggle() {
      var expanded = burger.getAttribute("aria-expanded") === "true";
      if (expanded) {
        close();
      } else {
        open();
      }
    }

    burger.addEventListener("click", function () {
      toggle();
    });

    // 메뉴 바깥 클릭 닫기
    document.addEventListener("click", function (e) {
      if (!document.body.classList.contains("nav-open")) {
        return;
      }
      var t = e.target;
      if (t === burger || burger.contains(t)) {
        return;
      }
      if (t === mobileNav || mobileNav.contains(t)) {
        return;
      }
      close();
    });

    // ESC 닫기
    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape") {
        close();
      }
    });
  }

  // ---------- Active nav ----------
  function setupActiveNav() {
    var base =
      document.body && document.body.dataset && document.body.dataset.baseUrl
        ? document.body.dataset.baseUrl
        : "/";
    var path = location.pathname || "/";
    // base가 '/repo/' 형태인 경우, path에서 base prefix 제거하고 비교
    if (base !== "/" && path.indexOf(base) === 0) {
      path = path.slice(base.length - 1);
    }

    // data-nav를 가진 링크를 우선 활성화
    var links = document.querySelectorAll("a[data-nav]");
    for (var i = 0; i < links.length; i += 1) {
      var a = links[i];
      a.classList.remove("is-active");
      var href = a.getAttribute("href") || "";
      try {
        var u = new URL(href, location.origin + base);
        if (
          u.pathname === location.pathname ||
          (u.pathname !== "/" && location.pathname.indexOf(u.pathname) === 0)
        ) {
          a.classList.add("is-active");
        }
      } catch (e) {
        // ignore
      }
    }
  }

  document.addEventListener("DOMContentLoaded", function () {
    setupThemeToggle();
    setupLangToggle();
    setupMobileNav();
    setupActiveNav();
  });
})();

(function () {
  function setupLangCaretClick() {
    var wrap = document.querySelector(".header-select-wrap");
    if (!wrap) return;

    var sel = wrap.querySelector(".header-select");
    var caret = wrap.querySelector(".header-select-caret");
    if (!sel || !caret) return;

    caret.addEventListener("click", function (e) {
      e.preventDefault();
      e.stopPropagation();

      // 포커스 주고 드롭다운 열기 시도
      sel.focus();

      // 최신 브라우저: showPicker 지원
      if (typeof sel.showPicker === "function") {
        sel.showPicker();
        return;
      }

      // fallback: 클릭 이벤트로 열기 유도
      sel.dispatchEvent(new MouseEvent("mousedown", { bubbles: true }));
      sel.click();
    });
  }

  document.addEventListener("DOMContentLoaded", setupLangCaretClick);
})();
