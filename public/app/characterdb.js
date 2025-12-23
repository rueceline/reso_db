import { dataPath, assetPath, uiCharacterListPath, uiSideIconPath, pagePath } from './utils/path.js';
import { DEFAULT_LANG } from './utils/config.js';
import { fetchJson } from './utils/fetch.js';
import { normalizeRootJson, safeNumber, UnitFactory, mapUnitQualityToRarity } from './utils/data.js';
import { normalizePathSlash } from './utils/utils.js';

const RARITY_ORDER = ['SSR', 'SR', 'R', 'N'];
const GENDER_ORDER = ['남성', '여성', '불명', '없음', '여(?)'];

// =========================================================
// Character DB Page Script
// - 실행 흐름: main() → loadCharacterDbData() → applyCharacterToDom()
// - 아래(엔트리)에서 위(헬퍼)로 역추적하기 쉽게 배치
// =========================================================

// -------------------------
// URLs
// -------------------------
const UNIT_URL = dataPath(DEFAULT_LANG, 'UnitFactory.json');
const UNIT_VIEW_URL = dataPath(DEFAULT_LANG, 'UnitViewFactory.json');
const TAG_URL = dataPath(DEFAULT_LANG, 'TagFactory.json');

// assets root
const ASSET_BASE = assetPath('');

// -------------------------
// helpers
// -------------------------
function byString(v) {
  if (v === null || v === undefined) {
    return '';
  }
  return String(v);
}

function setStatus(text, isError) {
  const el = document.getElementById('status');
  if (!el) {
    return;
  }

  el.className = isError ? 'error' : 'loading';
  el.textContent = text;
}

function setCount(n) {
  const el = document.getElementById('countBadge');
  if (!el) {
    return;
  }

  el.textContent = `총 ${n}명`;
}

// 확장자 없는 path에 .png 기본 부착
function ensureImageExt(pathLike) {
  const raw = normalizePathSlash(pathLike);
  if (!raw) {
    return '';
  }

  const low = raw.toLowerCase();
  const hasExt = low.endsWith('.png') || low.endsWith('.jpg') || low.endsWith('.jpeg') || low.endsWith('.webp');

  return hasExt ? raw : `${raw}.png`;
}

// UnitViewFactory 경로들은 보통 "RolePlus/..." 처럼 루트 상대 경로
function buildAssetUrlFromPath(pathLike) {
  const raw = normalizePathSlash(pathLike);
  if (!raw) {
    return '';
  }

  // 이미 http/https 또는 /로 시작하면 그대로 사용
  if (raw.startsWith('http://') || raw.startsWith('https://')) {
    return raw;
  }
  if (raw.startsWith('/')) {
    return raw;
  }

  const withExt = ensureImageExt(raw);
  const base = String(ASSET_BASE || '').replace(/\/$/, '');
  return `${base}/${withExt}`;
}

// UnitViewFactory 기준: 리스트용 half 우선
function pickPortraitUrlsFromView(viewRec) {
  const half = buildAssetUrlFromPath(viewRec?.roleListResUrl);
  const squads = buildAssetUrlFromPath(viewRec?.squadsHalf1);

  return {
    primary: half,
    secondary: squads
  };
}

function extractGenderFromUnit(unitRec) {
  return String(unitRec?.gender ?? '').trim();
}

function extractPositionFromUnit(unitRec) {
  const n = Number(unitRec?.line);  

  if (n === 1) {
    return '전열';
  }
  if (n === 2) {
    return '중열';
  }
  if (n === 3) {
    return '후열';
  }

  return '';
}

// TagFactory 연결 전에는 sideId를 그대로 들고 있다가, 아이콘만 tagMap으로 해석
function extractFactionFromUnit(unitRec) {
  const v = unitRec?.sideId;
  if (v === null || v === undefined) {
    return '';
  }
  return String(v);
}

function extractLifeSkillFromUnit(unitRec) {
  const v = unitRec?.lifeSkill ?? unitRec?.homeSkill ?? '';
  return String(v ?? '').trim();
}

function mapUnitToViewModel(unitRec, viewRec) {
  const id = safeNumber(unitRec?.id);
  const name = byString(unitRec?.name || unitRec?.idCN || unitRec?.EnglishName || '');

  const rarity = mapUnitQualityToRarity(unitRec?.quality ?? viewRec?.quality);

  const gender = extractGenderFromUnit(unitRec);
  const position = extractPositionFromUnit(unitRec);
  const faction = extractFactionFromUnit(unitRec);
  const lifeSkill = extractLifeSkillFromUnit(unitRec);

  const portrait = pickPortraitUrlsFromView(viewRec);

  return {
    id: byString(id ?? ''),
    name: byString(name),

    rarity: byString(rarity),
    gender: byString(gender),
    position: byString(position),
    faction: byString(faction),
    lifeSkill: byString(lifeSkill),

    sideId: safeNumber(unitRec?.sideId),

    portraitUrl: byString(portrait.primary),
    portraitFallbackUrl: byString(portrait.secondary)
  };
}

// -------------------------
// side tag (TagFactory -> icon)
// -------------------------
const sideTagById = new Map();

function pickSideIconUrlFromTag(sideId) {
  const idNum = safeNumber(sideId);

  if (idNum === null) {
    return '';
  }

  const tag = sideTagById.get(idNum);
  if (!tag) {
    return '';
  }

  // icon만 사용: "UI/Common/Common_icon_camp_10" -> "Common_icon_camp_10"
  const raw = normalizePathSlash(tag.icon);
  const base = raw ? raw.split('/').pop() : '';
  if (!base) {
    return '';
  }

  return uiSideIconPath(`${base}.png`);
}

function pickPositionRowUrl(position) {
  const pos = byString(position).trim();

  if (pos === '전열') {
    return buildAssetUrlFromPath('ui/common/row/RowFront.png');
  }

  if (pos === '중열') {
    return buildAssetUrlFromPath('ui/common/row/RowMiddle.png');
  }

  if (pos === '후열') {
    return buildAssetUrlFromPath('ui/common/row/RowBack.png');
  }

  return '';
}

async function loadSideTags() {
  const tagJson = await fetchJson(TAG_URL);
  const list = normalizeRootJson(tagJson);

  sideTagById.clear();

  for (const t of list) {
    const id = safeNumber(t?.id);
    if (id === null) {
      continue;
    }

    // mod == '阵营'만 (진영 태그)
    if (byString(t?.mod) !== '阵营') {
      continue;
    }

    const icon = byString(t?.icon);
    const gachaSSRPath = byString(t?.gachaSSRPath);
    const iconPath = byString(t?.iconPath);

    // 셋 다 비면 저장 X
    if (!icon && !gachaSSRPath && !iconPath) {
      continue;
    }

    sideTagById.set(id, {
      icon: icon,
      gachaSSRPath: gachaSSRPath,
      iconPath: iconPath,
      sideName: byString(t?.sideName)
    });
  }
}

// -------------------------
// filter
// -------------------------
function uniqSorted(list) {
  const arr = Array.from(
    new Set(
      list
        .filter(Boolean)
        .map((v) => String(v).trim())
        .filter(Boolean)
    )
  );
  arr.sort((a, b) => a.localeCompare(b, 'ko'));
  return arr;
}

function buildRarityOptions(list) {
  const present = new Set(list.map((x) => String(x.rarity || '').trim()).filter(Boolean));
  const ordered = ['UR', 'SSR', 'SR', 'R', 'N'];

  const out = [];
  for (const r of ordered) {
    if (present.has(r)) {
      out.push(r);
    }
  }

  const extras = Array.from(present).filter((r) => !ordered.includes(r));
  extras.sort((a, b) => a.localeCompare(b, 'ko'));
  return out.concat(extras);
}

function createFilterState() {
  return {
    rarity: new Set(),
    gender: new Set(),
    position: new Set(),
    faction: new Set(),
    lifeSkill: new Set()
  };
}

function toggleValue(stateSet, value) {
  if (stateSet.has(value)) {
    stateSet.delete(value);
  } else {
    stateSet.add(value);
  }
}

function makeToggle(label, selected, onClick) {
  const btn = document.createElement('button');
  btn.type = 'button';
  btn.className = 'toggle';
  btn.textContent = label;
  btn.dataset.selected = selected ? '1' : '0';
  btn.addEventListener('click', onClick);
  return btn;
}

function renderFilters(options, state, onChange) {
  const root = document.getElementById('filters');
  if (!root) {
    return;
  }

  root.replaceChildren();
  root.classList.add('filter-grid');

  function row(labelText, values, setRef) {
    if (!values || values.length === 0) {
      return null;
    }

    const rowWrap = document.createElement('div');
    rowWrap.className = 'filter-row';

    const label = document.createElement('div');
    label.className = 'filter-label';
    label.textContent = labelText;

    const buttons = document.createElement('div');
    buttons.className = 'filter-buttons';

    for (const v of values) {
      const btn = makeToggle(v, setRef.has(v), () => {
        toggleValue(setRef, v);
        onChange();
      });

      buttons.appendChild(btn);
    }

    rowWrap.appendChild(label);
    rowWrap.appendChild(buttons);
    return rowWrap;
  }  

  const rows = [
    row('희귀도', options.rarity, state.rarity), 
    row('성별', options.gender, state.gender), 
    row('위치', options.position, state.position), 
    row('세력', options.faction, state.faction), 
    row('생활', options.lifeSkill, state.lifeSkill)
  ].filter(Boolean);

  for (const r of rows) {
    root.appendChild(r);
  }
}

function applyFilters(list, query, state) {
  const q = String(query || '')
    .trim()
    .toLowerCase();

  return list.filter((item) => {
    if (q) {
      const name = String(item.name || '').toLowerCase();
      if (!name.includes(q)) {
        return false;
      }
    }

    if (state.rarity.size > 0 && !state.rarity.has(item.rarity)) {
      return false;
    }
    if (state.gender.size > 0 && !state.gender.has(item.gender)) {
      return false;
    }
    if (state.position.size > 0 && !state.position.has(item.position)) {
      return false;
    }
    if (state.faction.size > 0 && !state.faction.has(item.faction)) {
      return false;
    }
    if (state.lifeSkill.size > 0 && !state.lifeSkill.has(item.lifeSkill)) {
      return false;
    }

    return true;
  });
}

function buildFilterOptions(list) {
  const rarity = buildRarityOptions(list);
  const gender = uniqSorted(list.map((x) => x.gender)).sort((a, b) => {
    const ia = GENDER_ORDER.indexOf(a);
    const ib = GENDER_ORDER.indexOf(b);
    return (ia === -1) - (ib === -1) || ia - ib || a.localeCompare(b, 'ko');
  });  

  const position = uniqSorted(list.map((x) => x.position));
  const faction = uniqSorted(list.map((x) => x.faction));
  const lifeSkill = uniqSorted(list.map((x) => x.lifeSkill));

  return { rarity, gender, position, faction, lifeSkill };
}

// -------------------------
// render grid
// -------------------------
const cardCache = new Map();

function getCardKey(item) {
  return String(item?.id ?? item?.name ?? item?.portraitUrl ?? '');
}

function buildCard(item) {
  const detailHref =`${pagePath('/character_detail')}?id=${encodeURIComponent(String(item.id))}`;

  const a = document.createElement('a');
  a.className = 'char-card';
  a.href = detailHref;
  a.setAttribute('aria-label', byString(item.name));

  const thumb = document.createElement('div');
  thumb.className = 'char-thumb';

  const rarityKey = byString(item.rarity || '').toUpperCase() || 'N';
  const bgBackUrl = uiCharacterListPath(`CharacterList_bg_rarity_${rarityKey}.png`);
  const bgMaskUrl = uiCharacterListPath(`CharacterList_bg_rarity_${rarityKey}_mask.png`);

  const cardMaskUrl = uiCharacterListPath('CharacterList_mask.png');
  thumb.style.setProperty('--card-mask-url', `url("${cardMaskUrl}")`);

  const bgBack = document.createElement('img');
  bgBack.className = 'char-bg-rarity-back';
  bgBack.alt = '';
  bgBack.loading = 'lazy';
  bgBack.decoding = 'async';
  bgBack.src = bgBackUrl;
  thumb.appendChild(bgBack);

  const img = document.createElement('img');

  img.className = 'char-portrait';
  img.loading = 'lazy';
  img.decoding = 'async';
  img.alt = byString(item.name);

  const noimg = document.createElement('div');
  noimg.className = 'char-noimg';
  noimg.textContent = 'NO IMAGE';
  noimg.style.display = 'none';

  let triedFallback = false;

  img.addEventListener('error', () => {
    if (!triedFallback && item.portraitFallbackUrl) {
      triedFallback = true;
      img.src = item.portraitFallbackUrl;
      return;
    }

    // 최종 실패: src 자체를 제거해서, 필터로 DOM 재부착 시 재요청이 반복되지 않게 함
    img.style.display = 'none';
    img.removeAttribute('src');
    img.src = '';
    noimg.style.display = 'grid';
  });

  if (item.portraitUrl) {
    img.src = item.portraitUrl;
  } else if (item.portraitFallbackUrl) {
    triedFallback = true;
    img.src = item.portraitFallbackUrl;
  } else {
    img.style.display = 'none';
    noimg.style.display = 'grid';
  }

  thumb.appendChild(img);

  const bgFront = document.createElement('img');
  bgFront.className = 'char-bg-rarity-front';
  bgFront.alt = '';
  bgFront.loading = 'lazy';
  bgFront.decoding = 'async';
  bgFront.src = bgMaskUrl;
  thumb.appendChild(bgFront);

  // 포지션
  const posUrl = pickPositionRowUrl(item.position);
  if (posUrl) {
    const posImg = document.createElement('img');
    posImg.className = 'char-pos-icon';
    posImg.alt = '';
    posImg.loading = 'lazy';
    posImg.decoding = 'async';
    posImg.src = posUrl;

    posImg.addEventListener('error', () => {
      posImg.remove();
    });

    thumb.appendChild(posImg);
  }

  // 소속(진영) 아이콘
  const sideUrl = pickSideIconUrlFromTag(item.sideId ?? item.faction);
  if (sideUrl) {
    const side = document.createElement('img');
    side.className = 'char-side-icon';
    side.alt = '';
    side.loading = 'lazy';
    side.decoding = 'async';
    side.src = sideUrl;

    side.addEventListener('error', () => {
      side.remove();
    });

    thumb.appendChild(side);
  }

  // 이름(thumb 내부 오버레이)
  const nameIn = document.createElement('div');
  nameIn.className = 'char-name-in';

  const rawName = byString(item.name);
  const BREAK_LEN = 7;

  let prettyName = rawName;
  if (rawName.includes('·') && rawName.length >= BREAK_LEN) {
    prettyName = rawName.replace(/·\s*/g, '\n');
  }

  nameIn.textContent = prettyName;

  thumb.appendChild(nameIn);

  thumb.appendChild(noimg);
  a.appendChild(thumb);

  return a;
}

function getOrCreateCard(item) {
  const key = getCardKey(item);
  let el = cardCache.get(key);

  if (!el) {
    el = buildCard(item);
    cardCache.set(key, el);
    return el;
  }

  //updateCard(el, item);
  return el;
}

function renderGrid(list) {
  const root = document.getElementById('characterGrid');
  if (!root) {
    return;
  }

  const frag = document.createDocumentFragment();
  for (const item of list) {
    frag.appendChild(getOrCreateCard(item));
  }

  root.replaceChildren(frag);
  setCount(list.length);
}

// -------------------------
// main flow
// -------------------------
async function loadCharacterDbData() {
  const unitFactory = new UnitFactory({
    unitUrl: UNIT_URL,
    unitViewUrl: UNIT_VIEW_URL
  });

  await unitFactory.load();

  // join + 기본 필터
  const joined = unitFactory.buildList();

  // view model 변환(표시용 필드 확정)
  const viewAll = [];
  for (const j of joined) {
    const vm = mapUnitToViewModel(j.unit, j.view);
    
    if (!vm.portraitUrl && !vm.portraitFallbackUrl) {
      continue;
    }

    viewAll.push(vm);
  }

  // 진영 아이콘용 TagFactory (실패해도 리스트는 동작)
  try {
    await loadSideTags();
  } catch (e) {
    // ignore
  }

  // faction(세력) 텍스트를 sideId -> TagFactory.sideName으로 치환
  for (const vm of viewAll) {
    const idNum = safeNumber(vm?.sideId);
    if (idNum === null) {
      continue;
    }

    const tag = sideTagById.get(idNum);
    const sideName = byString(tag?.sideName);

    if (sideName) {
      vm.faction = sideName;
    }
  }

  return { viewAll };
}

function applyCharacterToDom(ctx) {
  const listAll = Array.from(ctx.viewAll).sort((a, b) => {
    const ia = RARITY_ORDER.indexOf(a.rarity);
    const ib = RARITY_ORDER.indexOf(b.rarity);

    if (ia !== -1 && ib !== -1) {
      return ia - ib;
    }

    if (ia !== -1) {
      return -1;
    }

    if (ib !== -1) {
      return 1;
    }

    return String(a.rarity).localeCompare(String(b.rarity), 'ko');
  });

  const statusEl = document.getElementById('status');
  if (statusEl) {
    statusEl.remove();
  }

  const filterState = createFilterState();
  const options = buildFilterOptions(listAll);

  const input = document.getElementById('searchInput');
  const clearBtn = document.getElementById('clearFilters');

  function update() {
    const q = input ? input.value : '';
    const filtered = applyFilters(listAll, q, filterState);
    renderGrid(filtered);
  }

  renderFilters(options, filterState, () => {
    update();
  });
  renderGrid(listAll);

  if (input) {
    input.addEventListener('input', () => update());
  }

  if (clearBtn) {
    clearBtn.addEventListener('click', () => {
      filterState.rarity.clear();
      filterState.gender.clear();
      filterState.position.clear();
      filterState.faction.clear();
      filterState.lifeSkill.clear();

      if (input) {
        input.value = '';
      }

      update();
    });
  }

  update();
  document.title = '캐릭터 DB';
}

async function main() {
  setStatus('데이터 로딩 중...', false);

  const ctx = await loadCharacterDbData();
  applyCharacterToDom(ctx);
}

main().catch((err) => {
  console.error(err);
  setStatus(`데이터를 불러오는 데 실패했습니다.\n${String(err)}`, true);
});
