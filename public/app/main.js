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

    html.setAttribute("data-theme", mode);

    if (mode === "light") {
      html.classList.add("theme-light");
      html.classList.remove("theme-dark");
    } else {
      html.classList.add("theme-dark");
      html.classList.remove("theme-light");
    }

    var btns = document.querySelectorAll(".js-theme-toggle");

    for (var i = 0; i < btns.length; i += 1) {
      var btn = btns[i];

      var pillIcon = btn.querySelector(".pill-icon");
      var pillText = btn.querySelector(".pill-text");

      if (pillIcon) {
        pillIcon.textContent = mode === "light" ? "☀" : "🌙";
      }

      if (pillText) {
        pillText.textContent = mode === "light" ? "라이트" : "다크";
      }

      btn.setAttribute("aria-pressed", mode === "light" ? "true" : "false");
      btn.classList.toggle("is-light", mode === "light");
    }
  }


  function setupThemeToggle() {
    var mode = getStored("theme_mode", "dark");
    applyTheme(mode);

    var btns = document.querySelectorAll(".js-theme-toggle");
    if (!btns || btns.length === 0) {
      return;
    }

    for (var i = 0; i < btns.length; i += 1) {
      btns[i].addEventListener("click", function () {
        var cur = getStored("theme_mode", "dark");
        var next = cur === "light" ? "dark" : "light";
        setStored("theme_mode", next);
        applyTheme(next);
      });
    }
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

  function setupLangSelectSync() {
    var desktop = qs("#lang-select");
    var mobile = qs("#lang-select-mobile");
    if (!desktop || !mobile) {
      return;
    }

    // 초기 동기화
    mobile.value = desktop.value;

    // desktop -> mobile
    desktop.addEventListener("change", function () {
      mobile.value = desktop.value;
      setStored("lang", (desktop.value || "KR").toLowerCase());
    });

    // mobile -> desktop
    mobile.addEventListener("change", function () {
      desktop.value = mobile.value;

      // 기존 change 로직이 desktop에만 붙어있을 수 있으니 트리거
      desktop.dispatchEvent(new Event("change"));

      setStored("lang", (mobile.value || "KR").toLowerCase());
    });
  }

  // ---------- Mobile nav ----------
  function setupMobileNav() {
    var burger = qs(".header-burger");
    var mobileNav = qs(".mobile-nav");
    var header = qs(".site-header"); // [추가]
    if (!burger || !mobileNav || !header) { // [수정]
      return;
    }

    function open() {
      burger.setAttribute("aria-expanded", "true");
      mobileNav.setAttribute("aria-hidden", "false");

      // [추가] CSS 토글 기준
      header.classList.add("is-mobile-open");

      // [유지] 기존도 유지(밖 클릭 닫기 조건에 쓰고 있음)
      document.body.classList.add("nav-open");
    }

    function close() {
      burger.setAttribute("aria-expanded", "false");
      mobileNav.setAttribute("aria-hidden", "true");

      // [추가]
      header.classList.remove("is-mobile-open");

      // [유지]
      document.body.classList.remove("nav-open");
    }

    function toggle() {
      // [수정] header 기준으로 판단 (aria만 믿지 말기)
      var expanded = header.classList.contains("is-mobile-open");
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
      // [유지] 기존 조건 그대로
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
    setupLangSelectSync();
    setupMobileNav();
    setupActiveNav();
  });
})();

(function () {
  function setupLangCaretClick() {
    var wraps = document.querySelectorAll(".header-select-wrap");
    if (!wraps || wraps.length === 0) { return; }

    for (var i = 0; i < wraps.length; i += 1) {
      var wrap = wraps[i];

      var sel = wrap.querySelector(".header-select");
      var caret = wrap.querySelector(".header-select-caret");
      if (!sel || !caret) { continue; }

      caret.addEventListener("click", function (e) {
        e.preventDefault();
        e.stopPropagation();

        var s = e.currentTarget && e.currentTarget.parentNode
          ? e.currentTarget.parentNode.querySelector(".header-select")
          : null;
        if (!s) { return; }

        s.focus();

        if (typeof s.showPicker === "function") {
          s.showPicker();
          return;
        }

        s.dispatchEvent(new MouseEvent("mousedown", { bubbles: true }));
        s.click();
      });
    }
  }


  document.addEventListener("DOMContentLoaded", setupLangCaretClick);
})();