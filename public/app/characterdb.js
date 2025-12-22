import {
  dataPath,
  assetPath,
  uiCharacterListPath,
  uiSideIconPath
} from './utils/path.js';

import { DEFAULT_LANG } from './utils/config.js';
import { fetchJson } from './utils/fetch.js';

import {
  normalizeRootJson,
  safeNumber,
  UnitFactory,
  mapUnitQualityToRarity
} from './utils/data.js';

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
  if (v === null || v === undefined) { return ''; }
  return String(v);
}

function isInvalidGroupValue(v) {
  const s = String(v || '').trim();
  if (!s) { return true; }
  if (s.startsWith('00')) { return true; }
  if (s.includes('测试') || s.includes('亂斗') || s.includes('乱斗')) { return true; }
  return false;
}

function setStatus(text, isError) {
  const el = document.getElementById('status');
  if (!el) { return; }

  el.className = isError ? 'error' : 'loading';
  el.textContent = text;
}

function setCount(n) {
  const el = document.getElementById('countBadge');
  if (!el) { return; }

  el.textContent = `총 ${n}명`;
}

// 확장자 없는 path에 .png 기본 부착
function ensureImageExt(pathLike) {
  const raw = normalizePathSlash(pathLike);
  if (!raw) { return ''; }

  const low = raw.toLowerCase();
  const hasExt =
    low.endsWith('.png') ||
    low.endsWith('.jpg') ||
    low.endsWith('.jpeg') ||
    low.endsWith('.webp');

  return hasExt ? raw : `${raw}.png`;
}

// UnitViewFactory 경로들은 보통 "RolePlus/..." 처럼 루트 상대 경로
function buildAssetUrlFromPath(pathLike) {
  const raw = normalizePathSlash(pathLike);
  if (!raw) { return ''; }

  // 이미 http/https 또는 /로 시작하면 그대로 사용
  if (raw.startsWith('http://') || raw.startsWith('https://')) { return raw; }
  if (raw.startsWith('/')) { return raw; }

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

  if (n === 1) { return '전열'; }
  if (n === 2) { return '중열'; }
  if (n === 3) { return '후열'; }

  return '';
}

// TagFactory 연결 전에는 sideId를 그대로 들고 있다가, 아이콘만 tagMap으로 해석
function extractFactionFromUnit(unitRec) {
  const v = unitRec?.sideId;
  if (v === null || v === undefined) { return ''; }
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
  if (idNum === null) { return ''; }

  const tag = sideTagById.get(idNum);
  if (!tag) { return ''; }

  const sideName = byString(tag.sideName);

  // 1) iconPath(camp_*) 우선
  {
    const raw = normalizePathSlash(tag.iconPath);
    const base = raw ? raw.split('/').pop() : '';

    if (base && base.startsWith('camp_')) {
      // 예외: 이세계 손님(12601524)은 iconPath가 camp_2로 겹침 → icon 사용
      if (idNum === 12601524 || sideName.includes('이세계')) {
        // 아래 icon 로직으로 넘김
      } else {
        return uiSideIconPath(`${base}.png`);
      }
    }
  }

  // 2) icon(Common_icon_camp_9) 사용
  {
    const raw = normalizePathSlash(tag.icon);
    const base = raw ? raw.split('/').pop() : '';
    if (base) {
      return uiSideIconPath(`${base}.png`);
    }
  }

  // 3) gachaSSRPath fallback
  {
    const raw = normalizePathSlash(tag.gachaSSRPath);
    const base = raw ? raw.split('/').pop() : '';
    if (base) {
      return uiSideIconPath(`${base}.png`);
    }
  }

  return '';
}

async function loadSideTags() {
  const tagJson = await fetchJson(TAG_URL);
  const list = normalizeRootJson(tagJson);

  sideTagById.clear();

  for (const t of list) {
    const id = safeNumber(t?.id);
    if (id === null) { continue; }

    // mod == '阵营'만 (진영 태그)
    if (byString(t?.mod) !== '阵营') { continue; }

    const icon = byString(t?.icon);
    const gachaSSRPath = byString(t?.gachaSSRPath);
    const iconPath = byString(t?.iconPath);

    // 셋 다 비면 저장 X
    if (!icon && !gachaSSRPath && !iconPath) { continue; }

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
  const arr = Array.from(new Set(list.filter(Boolean).map((v) => String(v).trim()).filter(Boolean)));
  arr.sort((a, b) => a.localeCompare(b, 'ko'));
  return arr;
}

function buildRarityOptions(list) {
  const present = new Set(list.map((x) => String(x.rarity || '').trim()).filter(Boolean));
  const ordered = ['UR', 'SSR', 'SR', 'R', 'N'];

  const out = [];
  for (const r of ordered) {
    if (present.has(r)) { out.push(r); }
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
  if (!root) { return; }

  root.replaceChildren();
  root.classList.add('filter-grid');

  function row(labelText, values, setRef) {
    if (!values || values.length === 0) { return null; }

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
  const q = String(query || '').trim().toLowerCase();

  return list.filter((item) => {
    if (q) {
      const name = String(item.name || '').toLowerCase();
      if (!name.includes(q)) { return false; }
    }

    if (state.rarity.size > 0 && !state.rarity.has(item.rarity)) { return false; }
    if (state.gender.size > 0 && !state.gender.has(item.gender)) { return false; }
    if (state.position.size > 0 && !state.position.has(item.position)) { return false; }
    if (state.faction.size > 0 && !state.faction.has(item.faction)) { return false; }
    if (state.lifeSkill.size > 0 && !state.lifeSkill.has(item.lifeSkill)) { return false; }

    return true;
  });
}

function buildFilterOptions(list) {
  const rarity = buildRarityOptions(list);
  const gender = uniqSorted(list.map((x) => x.gender).filter((v) => !isInvalidGroupValue(v))).sort((a, b) => {
    const ia = GENDER_ORDER.indexOf(a);
    const ib = GENDER_ORDER.indexOf(b);
    return (ia === -1) - (ib === -1) || ia - ib || a.localeCompare(b, 'ko');
  });
  const position = uniqSorted(list.map((x) => x.position).filter((v) => !isInvalidGroupValue(v)));
  const faction = uniqSorted(list.map((x) => x.faction).filter((v) => !isInvalidGroupValue(v)));
  const lifeSkill = uniqSorted(list.map((x) => x.lifeSkill).filter((v) => !isInvalidGroupValue(v)));

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
  const a = document.createElement('a');
  a.className = 'char-card';
  a.href = `character_detail.html?id=${encodeURIComponent(byString(item.id))}`;
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

    img.style.display = 'none';
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

function updateCard(a, item) {
  a.href = `character_detail.html?id=${encodeURIComponent(byString(item.id))}`;
  a.setAttribute('aria-label', byString(item.name));

    const portrait = a.querySelector('img.char-portrait');
  if (portrait) {
    const noimg = a.querySelector('.char-noimg');

    // 현재 카드가 fallback으로 넘어갔는지 추적 (한 번 fallback이면 updateCard에서 primary로 되돌리지 않음)
    const usedFallback = portrait.dataset.usedFallback === '1';

    // error 핸들러는 1회만 바인딩 (updateCard가 여러 번 불려도 중복 등록 방지)
    if (portrait.dataset.errBound !== '1') {
      portrait.dataset.errBound = '1';

      portrait.addEventListener('error', () => {
        if (portrait.dataset.usedFallback !== '1' && item.portraitFallbackUrl) {
          portrait.dataset.usedFallback = '1';
          portrait.src = item.portraitFallbackUrl;
          return;
        }

        portrait.style.display = 'none';
        if (noimg) {
          noimg.style.display = 'grid';
        }
      });
    }

    // src 결정
    // - 이미 fallback 상태면: fallback(있으면) 유지
    // - 아직 primary 상태면: primary 우선, 없으면 fallback
    let nextSrc = '';

    if (usedFallback) {
      nextSrc = item.portraitFallbackUrl || portrait.getAttribute('src') || '';
    } else {
      nextSrc = item.portraitUrl || item.portraitFallbackUrl || '';
      portrait.dataset.usedFallback = item.portraitUrl ? '0' : (item.portraitFallbackUrl ? '1' : '0');
    }

    if (nextSrc) {
      if (portrait.getAttribute('src') !== nextSrc) {
        portrait.setAttribute('src', nextSrc);
      }

      portrait.style.display = '';
      if (noimg) {
        noimg.style.display = 'none';
      }
    } else {
      portrait.style.display = 'none';
      if (noimg) {
        noimg.style.display = 'grid';
      }
    }

    portrait.alt = byString(item.name);
  }

  const nameIn = a.querySelector('.char-name-in');
  if (nameIn) {
    const rawName = byString(item.name);
    const BREAK_LEN = 7;

    let prettyName = rawName;
    if (rawName.includes('·') && rawName.length >= BREAK_LEN) {
      prettyName = rawName.replace(/·\s*/g, '\n');
    }

    nameIn.textContent = prettyName;
  }

  // rarity bg/front 갱신
  const rarityKey = byString(item.rarity || '').toUpperCase() || 'N';
  const bgBackUrl = uiCharacterListPath(`CharacterList_bg_rarity_${rarityKey}.png`);
  const bgMaskUrl = uiCharacterListPath(`CharacterList_bg_rarity_${rarityKey}_mask.png`);

  const bgBack = a.querySelector('img.char-bg-rarity-back');
  if (bgBack && bgBack.getAttribute('src') !== bgBackUrl) {
    bgBack.setAttribute('src', bgBackUrl);
  }

  const bgFront = a.querySelector('img.char-bg-rarity-front');
  if (bgFront && bgFront.getAttribute('src') !== bgMaskUrl) {
    bgFront.setAttribute('src', bgMaskUrl);
  }

  // 소속 아이콘 갱신
  const sideUrl = pickSideIconUrlFromTag(item.sideId ?? item.faction);

  const sideEl = a.querySelector('img.char-side-icon');
  if (sideUrl) {
    if (sideEl) {
      if (sideEl.getAttribute('src') !== sideUrl) {
        sideEl.setAttribute('src', sideUrl);
      }
    } else {
      const thumb = a.querySelector('.char-thumb');
      if (thumb) {
        const cardMaskUrl = uiCharacterListPath('CharacterList_mask.png');
        thumb.style.setProperty('--card-mask-url', `url("${cardMaskUrl}")`);

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
    }
  } else {
    if (sideEl) {
      sideEl.remove();
    }
  }
}

function getOrCreateCard(item) {
  const key = getCardKey(item);
  let el = cardCache.get(key);

  if (!el) {
    el = buildCard(item);
    cardCache.set(key, el);
    return el;
  }

  updateCard(el, item);
  return el;
}

function renderGrid(list) {
  const root = document.getElementById('characterGrid');
  if (!root) { return; }

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

    if (isInvalidGroupValue(vm.name)) { continue; }
    if (!vm.portraitUrl && !vm.portraitFallbackUrl) { continue; }

    viewAll.push(vm);
  }

  // 진영 아이콘용 TagFactory (실패해도 리스트는 동작)
  try {
    await loadSideTags();
  } catch (e) {
    // ignore
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

  function updateWithFilters() {
    renderFilters(options, filterState, updateWithFilters);
    update();
  }

  renderFilters(options, filterState, updateWithFilters);
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

      updateWithFilters();
    });
  }

  updateWithFilters();
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
