import {
  dataPath,
  assetPath,
  pagePath,
  uiCharacterListPath,
  uiSideIconPath,
} from "../utils/path.js";

import { qs, setText, clearChildren } from "../utils/dom.js";
import { DEFAULT_LANG } from "../utils/config.js";

import {
  UnitFactory,
  TagFactory,
  safeNumber,
  mapUnitQualityToRarity,
} from "../utils/data.js";

// -------------------------
// URLs
// -------------------------
const UNIT_URL = dataPath(DEFAULT_LANG, "UnitFactory.json");
const UNIT_VIEW_URL = dataPath(DEFAULT_LANG, "UnitViewFactory.json");
const TAG_URL = dataPath(DEFAULT_LANG, "TagFactory.json");

// -------------------------
// local helpers
// -------------------------
function byString(v) {
  return v === null || v === undefined ? "" : String(v);
}

// characterdb.js 상단 헬퍼 영역에 추가
function buildSideIconUrlFromIconName(iconName) {
  const base = byString(iconName).trim();
  if (!base) {
    return "";
  }
  return uiSideIconPath(`${base}.png`);
}

function applyImageFallback(imgEl, text) {
  imgEl.addEventListener("error", () => {
    imgEl.style.display = "none";

    const fallback = document.createElement("div");
    fallback.className = "img-fallback-text";
    fallback.textContent = text || "이미지 없음";

    imgEl.parentElement.appendChild(fallback);
  });
}

function mapLineToPosKey(line) {
  // UnitFactory.line 기준
  // 1 = Front, 2 = Middle, 3 = Back (관측 기준)
  if (line === 1) {
    return "RowFront.png";
  }
  if (line === 2) {
    return "RowMiddle.png";
  }
  if (line === 3) {
    return "RowBack.png";
  }
  return "";
}

function buildPosIconUrl(line) {
  const key = mapLineToPosKey(line);
  if (!key) {
    return "";
  }

  // 프로젝트에 이미 존재하는 포지션 아이콘 규칙이 있으면 그 경로로 바꿔도 됨.
  // (예: assets/ui/common/pos_front.png 등)
  return assetPath(`ui/common/row/${key}`);
}

function buildCard(item) {
  const a = document.createElement("a");
  a.className = "char-card";
  a.href = `${pagePath("character_detail.html")}?id=${encodeURIComponent(byString(item.id))}`;

  const thumb = document.createElement("div");
  thumb.className = "char-thumb";

  // (중요) 카드 공통 마스크 URL을 thumb에 주입
  // 실제 마스크 파일명이 너 프로젝트에서 쓰는 것으로 교체
  // 예: assets/ui/characterlist/CharacterList_mask.png
  thumb.style.setProperty("--card-mask-url", `url(${uiCharacterListPath("CharacterList_mask.png")})`);

  const rarityKey = byString(item.rarity || "N").toUpperCase() || "N";

  const bgBack = document.createElement("img");
  bgBack.className = "char-bg-rarity-back";
  bgBack.alt = "";
  bgBack.loading = "lazy";
  bgBack.decoding = "async";
  bgBack.src = uiCharacterListPath(`CharacterList_bg_rarity_${rarityKey}.png`);

  const portrait = document.createElement("img");
  portrait.className = "char-portrait";
  portrait.alt = "";
  portrait.loading = "lazy";
  portrait.decoding = "async";
  portrait.src = item.portraitUrl || "";

  applyImageFallback(portrait, item.name);

  // (중요) CSS가 기대하는 전면 띠 클래스
  const bgFront = document.createElement("img");
  bgFront.className = "char-bg-rarity-front";
  bgFront.alt = "";
  bgFront.loading = "lazy";
  bgFront.decoding = "async";
  bgFront.src = uiCharacterListPath(`CharacterList_bg_rarity_${rarityKey}_mask.png`);

  const pos = document.createElement("img");
  pos.className = "char-pos-icon";
  pos.alt = "";
  pos.loading = "lazy";
  pos.decoding = "async";
  pos.src = item.posIconUrl || "";
  pos.hidden = !pos.src;  

  const side = document.createElement("img");
  side.className = "char-side-icon";
  side.alt = "";
  side.loading = "lazy";
  side.decoding = "async";
  side.src = item.factionIconUrl || "";
  side.hidden = !side.src;

  // (중요) 이름은 thumb 내부
  const nameIn = document.createElement("div");
  nameIn.className = "char-name-in";
  nameIn.textContent = byString(item.name);

  thumb.appendChild(bgBack);
  thumb.appendChild(portrait);
  thumb.appendChild(bgFront);
  thumb.appendChild(pos);
  thumb.appendChild(side);
  thumb.appendChild(nameIn);

  a.appendChild(thumb);
  return a;
}

// -------------------------
// main
// -------------------------
async function loadData() {
  const unitF = new UnitFactory({ unitUrl: UNIT_URL, unitViewUrl: UNIT_VIEW_URL });
  const tagF = new TagFactory({ tagUrl: TAG_URL });

  await Promise.all([unitF.load(), tagF.load()]);

  // 기준 집합: UnitViewFactory (플레이어블 = character > 0)
  const views = unitF.viewFactory.getPrimaryPlayableViews(unitF);

  const items = [];
  for (const viewRec of views) {
    const unitId = safeNumber(viewRec?.character);
    if (unitId === null || unitId <= 0) {
      continue;
    }

    // UnitFactory는 조인 대상(lookup) 역할만
    const unitRec = unitF.getUnitById(unitId);
    if (!unitRec) {
      continue;
    }

    const name = String(unitRec?.name || viewRec?.name || "").trim();
    if (!name) {
      continue;
    }

    const rarity = mapUnitQualityToRarity(unitRec?.quality ?? viewRec?.quality);
    const faction = unitF.resolveFaction(unitRec, tagF); // { name, iconName, tagId }    
    const line = safeNumber(unitRec?.line);
    const posIconUrl = buildPosIconUrl(line);
    const portrait = unitF.viewFactory.pickPortraitUrls(viewRec);
    const portraitUrl = portrait.half || portrait.squadsHalf1 || portrait.squadsHalf2 || "";

    console.log(unitId, name, rarity, faction.iconName, faction.name)

    items.push({
      id: unitId,
      name,
      rarity,
      factionName: faction.name,
      factionIconUrl: buildSideIconUrlFromIconName(faction.iconName),
      posIconUrl,
      portraitUrl,
    });
  }

  // 정렬: rarity 우선, 그 다음 이름
  const rarityRank = { SSR: 0, SR: 1, R: 2, N: 3 };
  items.sort((a, b) => {
    const ra = rarityRank[a.rarity] ?? 9;
    const rb = rarityRank[b.rarity] ?? 9;
    if (ra !== rb) {
      return ra - rb;
    }

    const ia = safeNumber(a.id) ?? 0;
    const ib = safeNumber(b.id) ?? 0;
    if (ia !== ib) {
      return ia - ib;
    }

    return a.name.localeCompare(b.name, 'ko');
  });

  return items;
}

function render(items) {
  const root = qs("#characterGrid");
  if (!root) {
    console.error("[characterdb] #characterGrid 요소를 찾지 못함");
    return;
  }

  clearChildren(root);

  for (const it of items) {
    root.appendChild(buildCard(it));
  }

  setText("countBadge", `총 ${items.length}명`);
}


async function main() {
  try {
    setText("status", "불러오는 중...");
    const items = await loadData();
    render(items);
    setText("status", "");
  } catch (e) {
    console.error(e);
    setText("status", `데이터를 불러오는 데 실패했습니다.\n${String(e?.message || e)}`);
  }
}

document.addEventListener("DOMContentLoaded", () => {
  main();
});
