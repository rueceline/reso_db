// pages/index.js
// index.astro 전용(패치 노트 모달 등)

(function () {
  var openBtn = document.getElementById("openPatchNotes");
  var closeBtn = document.getElementById("closePatchNotes");
  var modal = document.getElementById("patchModal");

  function openModal() {
    if (!modal) { return; }
    modal.classList.add("is-open");
    modal.setAttribute("aria-hidden", "false");
  }

  function closeModal() {
    if (!modal) { return; }
    modal.classList.remove("is-open");
    modal.setAttribute("aria-hidden", "true");
  }

  if (openBtn) {
    openBtn.addEventListener("click", function (e) {
      e.preventDefault();
      openModal();
    });
  }

  if (closeBtn) {
    closeBtn.addEventListener("click", function (e) {
      e.preventDefault();
      closeModal();
    });
  }

  if (modal) {
    modal.addEventListener("click", function (e) {
      // 배경 클릭 닫기
      if (e.target === modal) {
        closeModal();
      }
    });

    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape") {
        closeModal();
      }
    });
  }
})();

// app/pages/index.js
(function () {
  const card = document.querySelector('.preview-placeholder');
  if (!card) { return; }

  const maxRotate = 10;   // 기울기 강도 (deg)
  const maxLift = 1.03;   // 살짝 확대
  let raf = 0;

  function setTransform(rx, ry) {
    card.style.transform =
      `perspective(900px) rotateX(${rx}deg) rotateY(${ry}deg) scale(${maxLift})`;
  }

  function resetTransform() {
    card.style.transform = 'perspective(900px) rotateX(4deg) rotateY(6deg) scale(1)';
  }

  card.addEventListener('mousemove', (ev) => {
    if (raf) { cancelAnimationFrame(raf); }

    raf = requestAnimationFrame(() => {
      const r = card.getBoundingClientRect();
      const cx = r.left + r.width / 2;
      const cy = r.top + r.height / 2;

      const dx = (ev.clientX - cx) / (r.width / 2);   // -1..1
      const dy = (ev.clientY - cy) / (r.height / 2);  // -1..1

      const ry = dx * maxRotate;
      const rx = -dy * maxRotate;

      setTransform(rx, ry);
    });
  });

  card.addEventListener('mouseenter', () => {
    card.style.transition = 'transform 90ms ease';
  });

  card.addEventListener('mouseleave', () => {
    if (raf) { cancelAnimationFrame(raf); raf = 0; }
    card.style.transition = 'transform 180ms ease';
    resetTransform();
  });

  // 초기 상태
  resetTransform();
})();

