let allCharacters = [];

// GitHub Pages / 로컬 서버 경로 모두 대응용 basePath
function getBasePath() {
  const parts = (location.pathname || "").split("/").filter(Boolean);
  const srcIndex = parts.lastIndexOf("src");
  return srcIndex > 0 ? "/" + parts.slice(0, srcIndex).join("/") : "";
}

function setLoadingUI(text) {
  const list = document.getElementById("list");
  const count = document.getElementById("count");

  if (count) {
    count.textContent = "";
  }

  if (list) {
    // 레이아웃은 유지하면서 안내만 표시
    list.innerHTML = `
      <div class="bento-card" style="grid-column: 1 / -1;">
        <div class="bento-title">${text}</div>
        <div class="bento-desc">데이터 연결은 추후 단계에서 진행합니다.</div>
      </div>
    `;
  }
}

function setEmptyUI() {
  const list = document.getElementById("list");
  const count = document.getElementById("count");

  if (count) {
    count.textContent = "데이터 준비 중";
  }

  if (list) {
    list.innerHTML = `
      <div class="bento-card" style="grid-column: 1 / -1;">
        <div class="bento-title">데이터 준비 중</div>
        <div class="bento-desc">characters.json이 아직 없어서 목록을 표시하지 않습니다.</div>
      </div>
    `;
  }
}

// characters.json 위치 후보들(환경마다 다를 수 있어서)
function getCandidateUrls() {
  const basePath = getBasePath();
  return [
    basePath + "/public/data/characters.json",
    basePath + "/data/characters.json",
    basePath + "/public/characters.json",
    basePath + "/characters.json",
  ];
}

async function tryFetchJson(url) {
  const res = await fetch(url, { cache: "no-cache" });

  if (!res.ok) {
    return null;
  }

  try {
    return await res.json();
  } catch {
    return null;
  }
}

async function loadData() {
  setLoadingUI("불러오는 중...");

  // 1) 여러 후보 URL을 순서대로 시도
  const urls = getCandidateUrls();

  for (const url of urls) {
    const data = await tryFetchJson(url);

    // data가 정상 배열/객체면 사용
    if (data && (Array.isArray(data) || typeof data === "object")) {
      allCharacters = Array.isArray(data) ? data : (data.data || data.characters || []);
      applyFilters();
      return;
    }
  }

  // 2) 전부 실패(404 포함)면: 정상적으로 “데이터 준비 중” UI만 보여주고 끝
  allCharacters = [];
  setEmptyUI();
}

function applyFilters() {
  const searchInput = document.getElementById("search");
  const raritySelect = document.getElementById("rarity");
  const elementSelect = document.getElementById("element");
  const roleSelect = document.getElementById("role");

  const q = (searchInput?.value || "").trim().toLowerCase();
  const rarity = raritySelect?.value || "all";
  const element = elementSelect?.value || "all";
  const role = roleSelect?.value || "all";

  const filtered = (allCharacters || []).filter((ch) => {
    // 데이터 스키마 확정 전이라 방어적으로 처리
    const name = String(ch.name || ch.name_ko || ch.displayName || "").toLowerCase();
    const tags = Array.isArray(ch.tags) ? ch.tags.join(" ").toLowerCase() : "";

    const matchQ = !q || name.includes(q) || tags.includes(q);
    const matchRarity = rarity === "all" || String(ch.rarity || ch.star || "") === String(rarity);
    const matchElement = element === "all" || String(ch.element || ch.attr || "") === String(element);
    const matchRole = role === "all" || String(ch.role || ch.job || "") === String(role);

    return matchQ && matchRarity && matchElement && matchRole;
  });

  renderList(filtered);
}

function renderList(listData) {
  const list = document.getElementById("list");
  const count = document.getElementById("count");

  if (!list) {
    return;
  }

  if (!Array.isArray(listData) || listData.length === 0) {
    // 데이터가 없거나 필터 결과가 없을 때도 레이아웃 유지
    if ((allCharacters || []).length === 0) {
      setEmptyUI();
      return;
    }

    if (count) {
      count.textContent = "검색 결과 0";
    }

    list.innerHTML = `
      <div class="bento-card" style="grid-column: 1 / -1;">
        <div class="bento-title">검색 결과가 없습니다</div>
        <div class="bento-desc">조건을 바꿔서 다시 시도하세요.</div>
      </div>
    `;
    return;
  }

  if (count) {
    count.textContent = `검색 결과 ${listData.length}`;
  }

  list.innerHTML = "";

  listData.forEach((ch) => {
    const div = document.createElement("div");
    div.className = "bento-card";

    const title = ch.name || ch.name_ko || ch.displayName || "(이름 없음)";
    const sub = ch.desc || ch.description || ch.name_zh || "";

    div.innerHTML = `
      <div class="bento-title">${title}</div>
      <div class="bento-desc">${sub}</div>
    `;

    list.appendChild(div);
  });
}

function setupEvents() {
  const search = document.getElementById("search");
  const rarity = document.getElementById("rarity");
  const element = document.getElementById("element");
  const role = document.getElementById("role");

  if (search) search.addEventListener("input", applyFilters);
  if (rarity) rarity.addEventListener("change", applyFilters);
  if (element) element.addEventListener("change", applyFilters);
  if (role) role.addEventListener("change", applyFilters);
}

setupEvents();
loadData();
