import {
  parseIdCN,
  mapQualityToRarity,
  calcMainStatWithGrowth,
} from './utils/utils.js';

const BASE = (window.getAppBase && window.getAppBase()) || '/';

// 캐시 무효화용 쿼리 스트링
const CACHE_BUST = "2025-12-18_03";

// 장비 / 성장 / 스킬 데이터 경로
const DATA_URL = `${BASE}public/data/KR/EquipmentFactory.json`;
const GROWTH_URL = `${BASE}public/data/KR/GrowthFactory.json`;
const SKILL_URL = `${BASE}public/data/KR/SkillFactory.json`;

// 무기 이미지 에셋 베이스 경로
const ASSET_SMALL_BASE = `${BASE}public/assets/item/weapon`;

// 테스트/더미 그룹 값 필터링
// - 00*
// - 测试 / 乱斗 계열
function isInvalidGroupValue(v) {
  const s = String(v || '').trim();
  if (!s) return true;
  if (s.startsWith('00')) return true;
  if (s.includes('测试') || s.includes('亂斗') || s.includes('乱斗')) return true;
  return false;
}

// tipsPath / iconPath 를 실제 이미지 URL로 변환
// 예: Item\\weapon\\Tiemeng\\Small\\01
//  → /public/assets/item/weapon/tiemeng/small/01.png
function buildWeaponImageUrl(pathLike) {
  const raw = normalizePathSlash(pathLike);
  const parts = raw.split('/').filter(Boolean);

  const idx = parts.findIndex(x => String(x).toLowerCase() === 'weapon');
  if (idx < 0 || parts.length < idx + 4) return '';

  const faction = String(parts[idx + 1] || '').toLowerCase();
  const size = String(parts[idx + 2] || '').toLowerCase();
  const file = String(parts[idx + 3] || '');

  if (!faction || !size || !file) return '';

  const filename = file.toLowerCase().endsWith('.png') ? file : `${file}.png`;
  return `${ASSET_SMALL_BASE}/${faction}/${size}/${filename}`;
}

// 장비의 대표 스킬(첫 skillList) → 주옵션 텍스트
function deriveMainOption(e, skillById) {
  if (!skillById) return '';

  const list = e?.skillList;
  if (!Array.isArray(list) || list.length === 0) return '';

  const sid = Number(list[0]?.skillId || 0);
  if (!sid) return '';

  const skill = skillById.get(sid);
  if (!skill) return `#${sid}`;

  // SkillFactory.json: description 필드 확정
  return String(skill.description || '').trim();
}

// 주옵션 텍스트 전용 렌더러
// - <color=#RRGGBB>...</color> 만 허용해서 span으로 변환
// - 나머지 문자는 전부 escape 처리
// - \n 개행은 <br> 로 변환
function renderMainOptionHtml(raw) {
  const s0 = String(raw || '');
  if (!s0) return '';

  // 개행 정규화
  const s = s0.replaceAll('\r\n', '\n');

  const openRe = /<color=\s*#([0-9a-fA-F]{6})\s*>/g;
  const closeRe = /<\/color\s*>/g;

  // 먼저 open/close를 모두 토큰으로 분리
  const tokens = [];
  let i = 0;

  while (i < s.length) {
    openRe.lastIndex = i;
    closeRe.lastIndex = i;

    const mOpen = openRe.exec(s);
    const mClose = closeRe.exec(s);

    const nextOpen = mOpen ? mOpen.index : Number.POSITIVE_INFINITY;
    const nextClose = mClose ? mClose.index : Number.POSITIVE_INFINITY;

    const next = Math.min(nextOpen, nextClose);

    if (!Number.isFinite(next) || next === Number.POSITIVE_INFINITY) {
      tokens.push({ type: 'text', value: s.slice(i) });
      break;
    }

    if (next > i) {
      tokens.push({ type: 'text', value: s.slice(i, next) });
      i = next;
      continue;
    }

    if (next === nextOpen) {
      tokens.push({ type: 'open', value: mOpen[1] });
      i = nextOpen + mOpen[0].length;
      continue;
    }

    tokens.push({ type: 'close' });
    i = nextClose + mClose[0].length;
  }

  // 토큰을 HTML로 변환 (스택 기반)
  let html = '';
  const stack = [];

  function pushSpan(colorHex) {
    const c = `#${colorHex}`;
    html += `<span class="mo-color" style="color:${c}">`;
    stack.push('span');
  }

  function popSpan() {
    if (stack.length > 0) {
      stack.pop();
      html += `</span>`;
    }
  }

  for (const t of tokens) {
    if (t.type === 'text') {
      const escaped = escapeHtml(t.value).replaceAll('\n', '<br>');
      html += escaped;
      continue;
    }

    if (t.type === 'open') {
      pushSpan(t.value);
      continue;
    }

    if (t.type === 'close') {
      popSpan();
    }
  }

  // 닫히지 않은 span 정리
  while (stack.length > 0) {
    popSpan();
  }

  return html;
}

// EquipmentFactory 원본 → 테이블 표시용 ViewModel
function mapEquipmentToViewModel(e, growthById, skillById) {
  const id = e?.id;
  const name = e?.name;
  const quality = e?.quality;
  const idCN = e?.idCN;

  const { faction, category } = parseIdCN(idCN);
  const rarity = mapQualityToRarity(quality);

  const stat = calcMainStatWithGrowth(e, growthById.get(e?.growthId));

  const mainOption = deriveMainOption(e, skillById);

  const imageUrl =
    buildWeaponImageUrl(e?.tipsPath) ||
    buildWeaponImageUrl(e?.iconPath);

  return {
    id: safeNumber(id) || byString(id),
    imageUrl: byString(imageUrl),

    name: byString(name),

    rarity,
    rarityClass: `rarity-${rarity.toLowerCase()}`,

    category: byString(category),
    faction: byString(faction),

    statType: byString(stat.label),
    minValue: stat.min,
    maxValue: stat.max,

    mainOption: byString(mainOption),
  };
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

  el.textContent = `총 ${n}개`;
}

// 행 캐시: 정렬/필터 시 DOM을 재사용해서 이미지/레이아웃 재처리를 최소화
const rowCache = new Map();

function getRowKey(item) {
  return String(item?.id ?? item?.idCN ?? item?.name ?? item?.imageUrl ?? '');
}

// tr DOM 생성 (HTML 문자열 없이)
function buildEquipmentRow(item) {
  const tr = document.createElement('tr');

  const tdImg = document.createElement('td');
  tdImg.className = 'cell-center';

  const aImg = document.createElement('a');
  aImg.setAttribute('aria-label', '상세 보기');

  const img = document.createElement('img');
  img.className = 'eq-thumb';
  img.loading = 'lazy';
  img.decoding = 'async';
  img.width = 60;
  img.height = 60;
  img.alt = '';

  img.addEventListener('error', () => {
    img.replaceWith(document.createTextNode('-'));
  });

  aImg.appendChild(img);
  tdImg.appendChild(aImg);

  const tdName = document.createElement('td');
  tdName.className = 'cell-center cell-name';

  const aName = document.createElement('a');
  aName.className = 'eq-name-link';
  tdName.appendChild(aName);

  const tdRarity = document.createElement('td');
  tdRarity.className = 'cell-center';

  const raritySpan = document.createElement('span');
  raritySpan.className = 'rarity-badge';
  tdRarity.appendChild(raritySpan);

  const tdCategory = document.createElement('td');
  tdCategory.className = 'cell-center';

  const tdFaction = document.createElement('td');
  tdFaction.className = 'cell-center';

  const tdStatType = document.createElement('td');
  tdStatType.className = 'cell-center';

  const tdMin = document.createElement('td');
  tdMin.className = 'cell-center';

  const tdMax = document.createElement('td');
  tdMax.className = 'cell-center';

  const tdMain = document.createElement('td');
  tdMain.className = 'cell-center main-option';

  tr.append(tdImg, tdName, tdRarity, tdCategory, tdFaction, tdStatType, tdMin, tdMax, tdMain);

  updateEquipmentRow(tr, item);
  return tr;
}

// 기존 tr에 데이터만 갱신
function updateEquipmentRow(tr, item) {
  const detailHref = `equipment_detail.html?id=${encodeURIComponent(byString(item.id))}`;

  const aImg = tr.children[0]?.querySelector('a');
  if (aImg) aImg.href = detailHref;

  const img = tr.children[0]?.querySelector('img');
  if (img) {
    const src = item.imageUrl || '';
    const cur = img.getAttribute('src') || '';
    if (cur !== src) img.setAttribute('src', src);
    img.alt = item.name || '';
  }

  const aName = tr.children[1]?.querySelector('a');
  if (aName) {
    aName.href = detailHref;
    aName.textContent = item.name || '';
  }

  const raritySpan = tr.children[2]?.querySelector('span');
  if (raritySpan) {
    raritySpan.textContent = item.rarity || '';
    raritySpan.className = `rarity-badge ${item.rarityClass || ''}`.trim();
  }

  if (tr.children[3]) tr.children[3].textContent = item.category || '';
  if (tr.children[4]) tr.children[4].textContent = item.faction || '';
  if (tr.children[5]) tr.children[5].textContent = item.statType || '';
  if (tr.children[6]) tr.children[6].textContent = formatNumber(item.minValue);
  if (tr.children[7]) tr.children[7].textContent = formatNumber(item.maxValue);

  if (tr.children[8]) tr.children[8].innerHTML = renderMainOptionHtml(item.mainOption);
}

// 캐시에서 row를 가져오거나 생성(생성 시 DOM API만 사용)
function getOrCreateRow(item) {
  const key = getRowKey(item);
  let tr = rowCache.get(key);

  if (!tr) {
    tr = buildEquipmentRow(item);
    rowCache.set(key, tr);
    return tr;
  }

  // 캐시 재사용 시 최신 데이터 반영
  updateEquipmentRow(tr, item);
  return tr;
}

function renderTable(list) {
  const tbody = document.getElementById('equipmentList');
  if (!tbody) return;

  const frag = document.createDocumentFragment();

  for (const item of list) {
    frag.appendChild(getOrCreateRow(item));
  }

  tbody.replaceChildren(frag);
  setCount(list.length);
}

function uniqSorted(list) {
  const arr = Array.from(new Set(list.filter(Boolean).map(v => String(v).trim()).filter(Boolean)));
  arr.sort((a, b) => a.localeCompare(b, 'ko'));
  return arr;
}

function buildRarityOptions(list) {
  const order = ['UR', 'SSR', 'SR', 'R', 'N'];

  const present = new Set(list.map(x => String(x.rarity || '').trim()).filter(Boolean));
  const out = [];

  for (const r of order) {
    if (present.has(r)) out.push(r);
  }

  const extras = Array.from(present).filter(r => !order.includes(r));
  extras.sort((a, b) => a.localeCompare(b, 'ko'));

  return out.concat(extras);
}

function rarityRank(r) {
  const s = String(r || '').trim();
  if (s === 'UR') return 0;
  if (s === 'SSR') return 1;
  if (s === 'SR') return 2;
  if (s === 'R') return 3;
  if (s === 'N') return 4;
  return 9;
}

function compareMaybeNumber(a, b) {
  const na = Number(a);
  const nb = Number(b);
  const aOk = Number.isFinite(na);
  const bOk = Number.isFinite(nb);

  if (aOk && bOk) return na - nb;
  if (aOk && !bOk) return -1;
  if (!aOk && bOk) return 1;
  return String(a ?? '').localeCompare(String(b ?? ''), 'ko');
}

function sortList(list, sortState) {
  const dirMul = (sortState?.dir === 'desc') ? -1 : 1;
  const key = sortState?.key || 'default';

  const arr = Array.from(list);

  arr.sort((x, y) => {
    if (key === 'default') {
      const r = rarityRank(x.rarity) - rarityRank(y.rarity);
      if (r !== 0) return r * dirMul;

      const c = String(x.category || '').localeCompare(String(y.category || ''), 'ko');
      if (c !== 0) return c * dirMul;

      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'rarity') {
      const r = rarityRank(x.rarity) - rarityRank(y.rarity);
      if (r !== 0) return r * dirMul;

      const c = String(x.category || '').localeCompare(String(y.category || ''), 'ko');
      if (c !== 0) return c * dirMul;

      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'name') {
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'category') {
      const c = String(x.category || '').localeCompare(String(y.category || ''), 'ko');
      if (c !== 0) return c * dirMul;
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'statType') {
      const s = String(x.statType || '').localeCompare(String(y.statType || ''), 'ko');
      if (s !== 0) return s * dirMul;
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'faction') {
      const f = String(x.faction || '').localeCompare(String(y.faction || ''), 'ko');
      if (f !== 0) return f * dirMul;
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'minValue') {
      const v = compareMaybeNumber(x.minValue, y.minValue);
      if (v !== 0) return v * dirMul;
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'maxValue') {
      const v = compareMaybeNumber(x.maxValue, y.maxValue);
      if (v !== 0) return v * dirMul;
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    return 0;
  });

  return arr;
}

function buildFilterOptions(list) {
  const rarity = buildRarityOptions(list);
  const category = uniqSorted(list.map(x => x.category).filter(v => !isInvalidGroupValue(v)));
  const faction = uniqSorted(list.map(x => x.faction).filter(v => !isInvalidGroupValue(v)));

  return { rarity, category, faction };
}

function createFilterState() {
  return {
    rarity: new Set(),
    category: new Set(),
    faction: new Set(),
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

// 필터 UI 렌더링 (DOM API 전용)
function renderFilters(options, state, onChange) {
  const root = document.getElementById('filters');
  if (!root) return;

  // 기존 내용을 안전하게 비움 (HTML 템플릿 문자열 사용 안 함)
  root.replaceChildren();
  root.classList.add('filter-grid');

  function row(labelText, values, setRef) {
    const rowWrap = document.createElement('div');
    rowWrap.className = 'filter-row';

    const label = document.createElement('div');
    label.className = 'filter-label';
    label.textContent = labelText;

    const buttons = document.createElement('div');
    buttons.className = 'filter-buttons';

    for (const v of values || []) {
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

  root.appendChild(row('희귀도', options.rarity, state.rarity));
  root.appendChild(row('분류', options.category, state.category));
  root.appendChild(row('소속', options.faction, state.faction));
}

function applyFilters(list, query, state) {
  const q = String(query || '').trim().toLowerCase();

  return list.filter(item => {
    if (q) {
      const name = String(item.name || '').toLowerCase();
      if (!name.includes(q)) return false;
    }

    if (state.rarity.size > 0 && !state.rarity.has(item.rarity)) return false;
    if (state.category.size > 0 && !state.category.has(item.category)) return false;
    if (state.faction.size > 0 && !state.faction.has(item.faction)) return false;

    return true;
  });
}

async function load() {
  setStatus('데이터 로딩 중...', false);

  try {
    const [eqJson, growthJson, skillJson] = await Promise.all([
      fetchJson(DATA_URL, CACHE_BUST),
      fetchJson(GROWTH_URL, CACHE_BUST),
      fetchJson(SKILL_URL, CACHE_BUST),
    ]);

    const rawList = normalizeRootJson(eqJson);
    const growthById = buildIdMap(normalizeRootJson(growthJson));
    const skillById = buildIdMap(normalizeRootJson(skillJson));

    const viewListAll = rawList
      .map(e => mapEquipmentToViewModel(e, growthById, skillById))
      .filter(x => !isInvalidGroupValue(x.category) && !isInvalidGroupValue(x.faction));

    const statusEl = document.getElementById('status');
    if (statusEl) {
      statusEl.remove();
    }

    const filterState = createFilterState();
    const options = buildFilterOptions(viewListAll);

    const input = document.getElementById('searchInput');
    const clearBtn = document.getElementById('clearFilters');
    const sortState = {
      key: 'rarity',   // 초기 정렬: 희귀도
      dir: 'asc',      // 오름차순(UR→SSR→SR→R→N)
    };

    let sortHeadersBound = false;

    function update() {
      const q = input ? input.value : '';
      const filtered = applyFilters(viewListAll, q, filterState);
      const sorted = sortList(filtered, sortState);
      renderTable(sorted);
    }

    function updateOnly() {
      update();
      updateSortHeaders();
    }

    function updateWithFilters() {
      updateOnly();
      renderFilters(options, filterState, updateWithFilters);
    }

    function updateSortHeaders() {
      const ths = document.querySelectorAll('thead th.sortable');
      for (const th of ths) {
        const key = th.dataset.sortKey || '';
        th.dataset.sortDir = (key === sortState.key) ? sortState.dir : '';
      }
    }

    function bindSortHeaders() {
      if (sortHeadersBound) return;
      sortHeadersBound = true;

      const ths = document.querySelectorAll('thead th.sortable');
      for (const th of ths) {
        th.addEventListener('click', () => {
          const key = th.dataset.sortKey || '';
          if (!key) return;

          if (sortState.key === key) {
            sortState.dir = (sortState.dir === 'asc') ? 'desc' : 'asc';
          } else {
            sortState.key = key;
            sortState.dir = 'asc';
          }

          updateOnly();
        });
      }
    }

    // 최초 1회 바인딩/렌더
    bindSortHeaders();
    renderFilters(options, filterState, updateWithFilters);

    if (input) {
      input.addEventListener('input', () => updateOnly());
    }

    if (clearBtn) {
      clearBtn.addEventListener('click', () => {
        filterState.rarity.clear();
        filterState.category.clear();
        filterState.faction.clear();

        if (input) {
          input.value = '';
        }

        updateWithFilters();
      });
    }

    updateWithFilters();
    document.title = '장비 DB';
  } catch (e) {
    console.error(e);
    setStatus(`데이터를 불러오는 데 실패했습니다.\n${String(e)}`, true);
  }
}

document.addEventListener('DOMContentLoaded', () => {
  load();
});
