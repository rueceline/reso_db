const BASE = (window.getAppBase && window.getAppBase()) || '/';

// 캐시 무효화용 쿼리 스트링
const CACHE_BUST = "2025-12-21_02";

// 1) 메인: UnitFactory + UnitViewFactory 조인
// 2) 폴백: HomeCharacterFactory
const DATA_URL_UNIT = `${BASE}data/KR/UnitFactory.json`;
const DATA_URL_VIEW = `${BASE}data/KR/UnitViewFactory.json`;
const DATA_URL_FALLBACK = `${BASE}data/KR/HomeCharacterFactory.json`;
const DATA_URL_TAG = `${BASE}data/KR/TagFactory.json`;

// 에셋 베이스
// (서빙 경로 기준: public/assets/* -> /assets/*)
const ASSET_BASE = `${BASE}assets`;

const POSITION_ICON_BY_LABEL = {
  '전열': `${ASSET_BASE}/book/character_illustration/RowFront.png`,
  '중열': `${ASSET_BASE}/book/character_illustration/RowMiddle.png`,
  '후열': `${ASSET_BASE}/book/character_illustration/RowBack.png`,
};

const sideTagById = new Map();

function pickSideIconUrlFromTag(sideId) {
  const idNum = safeNumber(sideId);
  if (idNum === null) { return ''; }

  const tag = sideTagById.get(idNum);
  if (!tag) { return ''; }

  const sideName = byString(tag.sideName);

  // 1) 기본은 iconPath(camp_*) 우선 (너 폴더에 camp_1~7이 있으니까)
  {
    const raw = normalizePathSlash(tag.iconPath);
    const base = raw ? raw.split('/').pop() : '';

    if (base && base.startsWith('camp_')) {
      // 예외: 이세계 손님(12601524)은 iconPath가 camp_2로 “겹침” → icon을 쓰자
      if (idNum === 12601524 || sideName.includes('이세계')) {
        // 아래 icon 로직으로 넘김

        console.log('idNum', idNum)
      } else {
        return `${ASSET_BASE}/ui/sideicon/${base}.png`;
      }
    }
  }

  // 2) 예외/특수는 icon(Common_icon_camp_9) 사용
  {
    const raw = normalizePathSlash(tag.icon);
    const base = raw ? raw.split('/').pop() : '';
    if (base) {
      console.log('base', base)

      return `${ASSET_BASE}/ui/sideicon/${base}.png`;
    }
  }

  // 3) 마지막 fallback: gachaSSRPath(camp_8 같은 것)
  {
    const raw = normalizePathSlash(tag.gachaSSRPath);
    const base = raw ? raw.split('/').pop() : '';
    if (base) {
      return `${ASSET_BASE}/ui/sideicon/${base}.png`;
    }
  }

  return '';
}


async function loadSideTags() {
  const tagJson = await fetchJson(DATA_URL_TAG, CACHE_BUST);
  const list = normalizeRootJson(tagJson);

  sideTagById.clear();

  for (const t of list) {
    const id = safeNumber(t?.id);
    if (id === null) { continue; }

    if (byString(t?.mod) !== '阵营') { continue; }

    const icon = byString(t?.icon);
    const gachaSSRPath = byString(t?.gachaSSRPath);
    const iconPath = byString(t?.iconPath);

    // 셋 다 비면 저장할 가치 없음
    if (!icon && !gachaSSRPath && !iconPath) { continue; }

    sideTagById.set(id, {
      icon: icon,
      gachaSSRPath: gachaSSRPath,
      iconPath: iconPath,
      sideName: byString(t?.sideName),
    });
  }
}


const SHOWCHAR_BASE = `${ASSET_BASE}/showcharacter`;

const SHOWCHAR_GRAD_BG = `${SHOWCHAR_BASE}/sactx-2048x512-DXT5-UIShowCharactershowcharacter_bg_huangyanAtlas-3b2bb9b2.png`;

function pickCampBgUrl(campIndex) {
  if (!campIndex) { return ''; }
  return `${SHOWCHAR_BASE}/camp_${campIndex}.png`;
}

function pickPositionIconUrl(positionLabel) {
  const key = String(positionLabel || '').trim();
  return POSITION_ICON_BY_LABEL[key] || '';
}

function hasNonEmptyList(v) {
  return Array.isArray(v) && v.length > 0;
}


function setStatus(text, isError) {
  const el = document.getElementById('status');
  if (!el) return;

  el.className = isError ? 'error' : 'loading';
  el.textContent = text;
}

function setCount(n) {
  const el = document.getElementById('countBadge');
  if (!el) return;

  el.textContent = `총 ${n}명`;
}

function normalizePathSlash(p) {
  return String(p || '').replaceAll('\\', '/').trim();
}

function byString(v) {
  if (v === null || v === undefined) return '';
  return String(v);
}

function safeNumber(v) {
  const n = Number(v);
  return Number.isFinite(n) ? n : null;
}

async function fetchJson(url, cacheBust) {
  const u = cacheBust ? `${url}?v=${encodeURIComponent(cacheBust)}` : url;
  const res = await fetch(u, { cache: 'no-store' });
  if (!res.ok) {
    throw new Error(`fetch failed: ${res.status} ${u}`);
  }

  return await res.json();
}

// JSON 루트가 { list: [...] } / { data: [...] } / 그냥 [...] 등 섞여도 최대한 대응
function normalizeRootJson(obj) {
  if (Array.isArray(obj)) return obj;
  if (!obj || typeof obj !== 'object') return [];

  if (Array.isArray(obj.list)) return obj.list;
  if (Array.isArray(obj.data)) return obj.data;
  if (Array.isArray(obj.items)) return obj.items;

  for (const k of Object.keys(obj)) {
    if (Array.isArray(obj[k])) return obj[k];
  }

  return [];
}

// 테스트/더미 그룹 값 필터링 (equipmentdb와 같은 규칙)
function isInvalidGroupValue(v) {
  const s = String(v || '').trim();
  if (!s) return true;
  if (s.startsWith('00')) return true;
  if (s.includes('测试') || s.includes('亂斗') || s.includes('乱斗')) return true;
  return false;
}

// -----------------------------------------------------------------------------
// 실제 데이터 기반: UnitFactory + UnitViewFactory 조인 ViewModel
// -----------------------------------------------------------------------------

// UnitFactory.quality(예: FiveStar/fourStar/threeStar...) 우선 처리
// + 기존 장비쪽 quality(Orange/Golden...)도 남겨서 혹시 섞여도 안전하게
function mapQualityToRarity(quality) {
  const q = String(quality || '').trim();

  // 캐릭터(별등급)
  if (q === 'FiveStar') return 'SSR';
  if (q === 'fourStar') return 'SR';
  if (q === 'threeStar') return 'R';
  if (q === 'twoStar') return 'N';
  if (q === 'oneStar') return 'N';

  // 기존(장비식 컬러)
  if (q === 'Orange') return 'UR';
  if (q === 'Golden') return 'SSR';
  if (q === 'Purple') return 'SR';
  if (q === 'Blue') return 'R';
  if (q === 'White') return 'N';

  return q || '';
}

// 확장자 없는 path에 .png 기본 부착
function ensureImageExt(pathLike) {
  const raw = normalizePathSlash(pathLike);
  if (!raw) return '';

  const low = raw.toLowerCase();
  const hasExt =
    low.endsWith('.png') ||
    low.endsWith('.jpg') ||
    low.endsWith('.jpeg') ||
    low.endsWith('.webp');

  return hasExt ? raw : `${raw}.png`;
}

// UnitViewFactory 경로들은 보통 "RolePlus/..." 처럼 이미 루트부터 시작함
function buildAssetUrlFromPath(pathLike) {
  const raw = normalizePathSlash(pathLike);
  if (!raw) return '';

  // 이미 http/https 또는 /로 시작하면 그대로 사용
  if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
  if (raw.startsWith('/')) return raw;

  const withExt = ensureImageExt(raw);
  return `${ASSET_BASE}/${withExt}`;
}

// 리스트 초상화: UnitViewFactory.roleListResUrl 우선
// 리스트 페이지 전용: Half.png만 사용
function pickPortraitUrlsFromView(viewRec) {
  // 1순위: Half (roleListResUrl)
  const half = buildAssetUrlFromPath(viewRec?.roleListResUrl);

  // 2순위: squadsHalf1
  const squads = buildAssetUrlFromPath(viewRec?.squadsHalf1);

  return {
    primary: half,
    secondary: squads,
  };
}



// UnitFactory 기준 고정
function extractGenderFromUnit(unitRec) {
  // UnitFactory.gender (문자열)
  const s = String(unitRec?.gender ?? '').trim();
  return s;
}

function extractPositionFromUnit(unitRec) {
  // UnitFactory.line (숫자)
  // 아직 매핑 표준 확정 전이라 "전/중/후/기타" 정도로만 뿌림
  const n = Number(unitRec?.line);

  if (n === 1) return '전열';
  if (n === 2) return '중열';
  if (n === 3) return '후열';

  return '';
}

function extractFactionFromUnit(unitRec) {
  // UnitFactory.sideId (숫자 태그)
  const v = unitRec?.sideId;
  if (v === null || v === undefined) return '';
  return String(v);
}

// 아직 TagFactory 매핑 전이라 lifeSkill은 비워둠(필터에 자동으로 안 뜸)
function extractLifeSkillFromUnit(unitRec) {
  const v = unitRec?.lifeSkill ?? unitRec?.homeSkill ?? '';
  return String(v ?? '').trim();
}

function mapUnitToViewModel(unitRec, viewRec) {
  const id = safeNumber(unitRec?.id) ?? byString(unitRec?.idCN) ?? byString(unitRec?.name) ?? '';
  const name = byString(unitRec?.name || unitRec?.idCN || unitRec?.EnglishName || '');

  const rarity = mapQualityToRarity(unitRec?.quality ?? viewRec?.quality);

  const gender = extractGenderFromUnit(unitRec);
  const position = extractPositionFromUnit(unitRec);
  const faction = extractFactionFromUnit(unitRec);
  const lifeSkill = extractLifeSkillFromUnit(unitRec);

  const portrait = pickPortraitUrlsFromView(viewRec);

  return {
    id: byString(id),
    name: byString(name),

    rarity: byString(rarity),
    gender: byString(gender),
    position: byString(position),
    faction: byString(faction),
    lifeSkill: byString(lifeSkill),

     sideId: safeNumber(unitRec?.sideId),

    portraitUrl: byString(portrait.primary),
    portraitFallbackUrl: byString(portrait.secondary),
  };
}

// -----------------------------------------------------------------------------
// Filter UI (기존 유지)
// -----------------------------------------------------------------------------

function uniqSorted(list) {
  const arr = Array.from(new Set(list.filter(Boolean).map(v => String(v).trim()).filter(Boolean)));
  arr.sort((a, b) => a.localeCompare(b, 'ko'));
  return arr;
}

function buildRarityOptions(list) {
  const present = new Set(list.map(x => String(x.rarity || '').trim()).filter(Boolean));
  const ordered = ['UR', 'SSR', 'SR', 'R', 'N'];

  const out = [];
  for (const r of ordered) {
    if (present.has(r)) out.push(r);
  }

  const extras = Array.from(present).filter(r => !ordered.includes(r));
  extras.sort((a, b) => a.localeCompare(b, 'ko'));
  return out.concat(extras);
}

function createFilterState() {
  return {
    rarity: new Set(),
    gender: new Set(),
    position: new Set(),
    faction: new Set(),
    lifeSkill: new Set(),
  };
}

function isSelected(stateSet, value) {
  return stateSet.has(value);
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
  if (!root) return;

  root.replaceChildren();
  root.classList.add('filter-grid');

  function row(labelText, values, setRef) {
    if (!values || values.length === 0) return null;

    const rowWrap = document.createElement('div');
    rowWrap.className = 'filter-row';

    const label = document.createElement('div');
    label.className = 'filter-label';
    label.textContent = labelText;

    const buttons = document.createElement('div');
    buttons.className = 'filter-buttons';

    for (const v of values) {
      const btn = makeToggle(v, isSelected(setRef, v), () => {
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
    row('생활', options.lifeSkill, state.lifeSkill),
  ].filter(Boolean);

  for (const r of rows) {
    root.appendChild(r);
  }
}

function applyFilters(list, query, state) {
  const q = String(query || '').trim().toLowerCase();

  return list.filter(item => {
    if (q) {
      const name = String(item.name || '').toLowerCase();
      if (!name.includes(q)) return false;
    }

    if (state.rarity.size > 0 && !state.rarity.has(item.rarity)) return false;
    if (state.gender.size > 0 && !state.gender.has(item.gender)) return false;
    if (state.position.size > 0 && !state.position.has(item.position)) return false;
    if (state.faction.size > 0 && !state.faction.has(item.faction)) return false;
    if (state.lifeSkill.size > 0 && !state.lifeSkill.has(item.lifeSkill)) return false;

    return true;
  });
}

// -----------------------------------------------------------------------------
// Render Grid (기존 유지)
// -----------------------------------------------------------------------------

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

  // rarity 키 (예: 'SSR', 'SR', 'R', 'N')
  const rarityKey = byString(item.rarity || '').toUpperCase() || 'N';

  // 파일 경로 (네가 옮긴 폴더)
  const bgBackUrl = `${ASSET_BASE}/ui/characterlist/CharacterList_bg_rarity_${rarityKey}.png`;
  const bgMaskUrl = `${ASSET_BASE}/ui/characterlist/CharacterList_bg_rarity_${rarityKey}_mask.png`;

  // 공통 클리핑 마스크
  const cardMaskUrl = `${ASSET_BASE}/ui/characterlist/CharacterList_mask.png`;
  thumb.style.setProperty('--card-mask-url', `url("${cardMaskUrl}")`);

  // 1) bg rarity (뒤)
  const bgBack = document.createElement('img');
  bgBack.className = 'char-bg-rarity-back';
  bgBack.alt = '';
  bgBack.loading = 'lazy';
  bgBack.decoding = 'async';
  bgBack.src = bgBackUrl;
  thumb.appendChild(bgBack);

  // 2) 캐릭터 Half 이미지
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

  // 3) bg rarity (앞) - 오버레이(아래 대각선 띠)
  const bgFront = document.createElement('img');
  bgFront.className = 'char-bg-rarity-front';
  bgFront.alt = '';
  bgFront.loading = 'lazy';
  bgFront.decoding = 'async';
  bgFront.src = bgMaskUrl;
  thumb.appendChild(bgFront);

  // 4) 포지션 아이콘 (좌상단)
  const posUrl = pickPositionIconUrl(item.position);
  if (posUrl) {
    const pos = document.createElement('img');
    pos.className = 'char-pos-icon';
    pos.alt = byString(item.position);
    pos.loading = 'lazy';
    pos.decoding = 'async';
    pos.src = posUrl;
    thumb.appendChild(pos);
  }

  // 5) 소속 아이콘 (우상단)
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

  // 6) 이름 (이미지 내부 우하단)
  const nameIn = document.createElement('div');
  nameIn.className = 'char-name-in';
  const rawName = byString(item.name);

  let prettyName = rawName;
  
  const BREAK_LEN = 7;

  // 조건:
  // 1) '·' 포함
  // 2) 전체 길이가 BREAK_LEN 이상
  if (rawName.includes('·') && rawName.length >= BREAK_LEN) {
    prettyName = rawName.replace(/·\s*/g, '\n');
  }

  nameIn.textContent = prettyName;

  thumb.appendChild(nameIn);

  // 7) NO IMAGE (최상단)
  thumb.appendChild(noimg);

  a.appendChild(thumb);

  // 기존 아래 이름은 제거(이제 안 씀)
  // const name = document.createElement('div');
  // name.className = 'char-name';
  // name.textContent = byString(item.name);
  // a.appendChild(name);

  return a;
}

function updateCard(a, item) {
  a.href = `character_detail.html?id=${encodeURIComponent(byString(item.id))}`;
  a.setAttribute('aria-label', byString(item.name));

  // portrait만 갱신 (bgBack 건드리면 레이어가 깨짐)
  const portrait = a.querySelector('img.char-portrait');
  if (portrait) {
    let triedFallback = false;

    portrait.addEventListener('error', () => {
      if (!triedFallback && item.portraitFallbackUrl) {
        triedFallback = true;
        portrait.src = item.portraitFallbackUrl;
        return;
      }

      portrait.style.display = 'none';
      const noimg = a.querySelector('.char-noimg');
      if (noimg) {
        noimg.style.display = 'grid';
      }
    });

    if (item.portraitUrl) {
      if (portrait.getAttribute('src') !== item.portraitUrl) {
        portrait.setAttribute('src', item.portraitUrl);
      }
      portrait.style.display = '';
    }

    portrait.alt = byString(item.name);
  }

  // 이름(thumb 내부 오버레이)
  const nameIn = a.querySelector('.char-name-in');
  if (nameIn) {
    nameIn.textContent = byString(item.name);
  }

  // rarity bg/front는 데이터가 바뀌는 경우만 갱신
  const rarityKey = byString(item.rarity || '').toUpperCase() || 'N';
  const bgBackUrl = `${ASSET_BASE}/ui/characterlist/CharacterList_bg_rarity_${rarityKey}.png`;
  const bgMaskUrl = `${ASSET_BASE}/ui/characterlist/CharacterList_bg_rarity_${rarityKey}_mask.png`;

  const bgBack = a.querySelector('img.char-bg-rarity-back');
  if (bgBack && bgBack.getAttribute('src') !== bgBackUrl) {
    bgBack.setAttribute('src', bgBackUrl);
  }

  const bgFront = a.querySelector('img.char-bg-rarity-front');
  if (bgFront && bgFront.getAttribute('src') !== bgMaskUrl) {
    bgFront.setAttribute('src', bgMaskUrl);
  }

  // 소속(진영) 아이콘 갱신
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
  if (!root) return;

  const frag = document.createDocumentFragment();
  for (const item of list) {
    frag.appendChild(getOrCreateCard(item));
  }

  root.replaceChildren(frag);
  setCount(list.length);
}

function buildFilterOptions(list) {
  const rarity = buildRarityOptions(list);
  const gender = uniqSorted(list.map(x => x.gender).filter(v => !isInvalidGroupValue(v)));
  const position = uniqSorted(list.map(x => x.position).filter(v => !isInvalidGroupValue(v)));
  const faction = uniqSorted(list.map(x => x.faction).filter(v => !isInvalidGroupValue(v)));
  const lifeSkill = uniqSorted(list.map(x => x.lifeSkill).filter(v => !isInvalidGroupValue(v)));

  return { rarity, gender, position, faction, lifeSkill };
}

// -----------------------------------------------------------------------------
// Load
// -----------------------------------------------------------------------------

async function loadUnitAndView() {
  const unitJson = await fetchJson(DATA_URL_UNIT, CACHE_BUST);
  const viewJson = await fetchJson(DATA_URL_VIEW, CACHE_BUST);

  const units = normalizeRootJson(unitJson);
  const views = normalizeRootJson(viewJson);

  // viewId → view 1:1 맵
  const viewById = new Map();
  for (const v of views) {
    const id = safeNumber(v?.id);
    if (id !== null && !viewById.has(id)) {
      viewById.set(id, v);
    }
  }

  const out = [];

  for (const u of units) {
    const unitId = safeNumber(u?.id);
    if (unitId === null) {
      continue;
    }

    // 1️⃣ 에너미 제외
    if (u.enemyType !== null && u.enemyType !== undefined) {
      continue;
    }

    // 2️⃣ sideId -1 제외 (시스템/NPC/오브젝트)
    if (Number(u.sideId) === -1) {
      continue;
    }

    if (!hasNonEmptyList(u?.careerList)) {
      continue;
    }

    // 3️⃣ viewId 필수
    const viewId = safeNumber(u?.viewId);
    if (viewId === null) {
      continue;
    }

    const viewRec = viewById.get(viewId);
    if (!viewRec) {
      continue;
    }

    // 4️⃣ Half 이미지 없는 캐릭터 제외
    if (!viewRec.roleListResUrl) {
      continue;
    }

    const vm = mapUnitToViewModel(u, viewRec);

    if (isInvalidGroupValue(vm.name)) {
      continue;
    }

    // portraitUrl 없으면 리스트에 안 넣음
    if (!vm.portraitUrl) {
      continue;
    }

    out.push(vm);
  }

  return out;
}


async function loadFallbackHomeCharacter() {
  const json = await fetchJson(DATA_URL_FALLBACK, CACHE_BUST);
  const rawList = normalizeRootJson(json);

  // 기존 fallback은 “한 레코드만” 기반이라 최소한만 유지
  const out = rawList
    .map(rec => {
      const id = safeNumber(rec?.id) ?? byString(rec?.idCN) ?? byString(rec?.name) ?? byString(rec?.SkinName);
      const name = byString(rec?.name || rec?.SkinName || rec?.State2Name || rec?.character || rec?.idCN || '');
      const rarity = mapQualityToRarity(rec?.quality);

      const gender = byString(rec?.gender ?? rec?.sex ?? '');
      const position = byString(rec?.position ?? rec?.line ?? '');
      const faction = byString(rec?.sideId ?? rec?.camp ?? rec?.faction ?? '');

      const portraitUrl =
        buildAssetUrlFromPath(rec?.roleListResUrl) ||
        buildAssetUrlFromPath(rec?.iconPath) ||
        buildAssetUrlFromPath(rec?.tipsPath) ||
        '';

      return {
        id: byString(id),
        name: byString(name),
        rarity: byString(rarity),
        gender: byString(gender),
        position: byString(position),
        faction: byString(faction),
        lifeSkill: '',
        portraitUrl: byString(portraitUrl),
      };
    })
    .filter(x => !isInvalidGroupValue(x.name));

  return out;
}

async function load() {
  setStatus('데이터 로딩 중...', false);

  try {
    let viewAll = [];
    
    try {
      viewAll = await loadUnitAndView();
    } catch (e) {
      viewAll = await loadFallbackHomeCharacter();
    }

     try {
      await loadSideTags();

      console.log('[sideTagById.size]', sideTagById.size);
      console.log('[test]', pickSideIconUrlFromTag(12600023), pickSideIconUrlFromTag(12601524));

    } catch (e) {
      // TagFactory 못 불러와도 리스트는 정상 동작(아이콘만 없음)
    }

    const statusEl = document.getElementById('status');
    if (statusEl) {
      statusEl.remove();
    }

    const filterState = createFilterState();
    const options = buildFilterOptions(viewAll);

    const input = document.getElementById('searchInput');
    const clearBtn = document.getElementById('clearFilters');

    function onChange() {
      renderFilters(options, filterState, onChange);

      const q = input ? input.value : '';
      const filtered = applyFilters(viewAll, q, filterState);
      renderGrid(filtered);
    }

    renderFilters(options, filterState, onChange);
    renderGrid(viewAll);

    if (input) {
      input.addEventListener('input', () => {
        onChange();
      });
    }

    if (clearBtn) {
      clearBtn.addEventListener('click', () => {
        filterState.rarity.clear();
        filterState.gender.clear();
        filterState.position.clear();
        filterState.faction.clear();
        filterState.lifeSkill.clear();

        if (input) input.value = '';
        onChange();
      });
    }

  } catch (err) {
    setStatus(`로딩 실패\n${String(err && err.message ? err.message : err)}`, true);
  }
}

load();
