import { 
  dataPath, 
  pagePath,  
  buildAssetImageUrl
} from '../utils/path.js';

import { 
  formatColorTagsToHtml 
} from '../utils/utils.js';

import { DEFAULT_LANG } from '../utils/config.js';

// =========================================================
// Equipment DB Page Script
// - 실행 흐름: main() → loadEquipmentDbData() → applyEquipmentToDom()
// =========================================================

// -------------------------
// URLs
// -------------------------
const EQUIP_VM_URL = dataPath(DEFAULT_LANG, 'EquipmentVM.json');
const SKILL_VM_URL = dataPath(DEFAULT_LANG, 'EquipmentSkillVM.json');

// -------------------------
// helpers
// -------------------------

function formatNumber(v) {
  const n = Number(v);
  if (!Number.isFinite(n)) { 
    return ''; 
  }

  return n.toLocaleString();
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

  el.textContent = `총 ${n}개`;
}

function isInvalidGroupValue(v) {
  const s = String(v || '').trim();
  if (!s) { 
    return true; 
  }

  if (s === '-') { 
    return true; 
  }

  if (s.startsWith('00')) { 
    return true; 
  }

  return false;
}

// -------------------------
// row cache / render
// -------------------------
const rowCache = new Map();

function getRowKey(item) {
  return String(item?.id ?? item?.name ?? item?.imageUrl ?? '');
}

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

function updateEquipmentRow(tr, item) {
  const detailHref = `${pagePath('/equipment_detail')}?id=${encodeURIComponent(String(item.id))}`;

  const aImg = tr.children[0]?.querySelector('a');
  if (aImg) { 
    aImg.href = detailHref; 
  }

  const img = tr.children[0]?.querySelector('img');
  if (img) {
    const src = item.imageUrl || '';
    const cur = img.getAttribute('src') || '';
    if (cur !== src) { 
      img.setAttribute('src', src); 
    }

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

  if (tr.children[3]) { tr.children[3].textContent = item.category || ''; }
  if (tr.children[4]) { tr.children[4].textContent = item.faction || ''; }
  if (tr.children[5]) { tr.children[5].textContent = item.statType || ''; }

  if (tr.children[6]) { tr.children[6].textContent = formatNumber(item.minValue) || '-'; }
  if (tr.children[7]) { tr.children[7].textContent = formatNumber(item.maxValue) || '-'; }

  if (tr.children[8]) {
    tr.children[8].innerHTML = formatColorTagsToHtml(item.mainOption || '');
  }
}

function getOrCreateRow(item) {
  const key = getRowKey(item);
  let tr = rowCache.get(key);

  if (!tr) {
    tr = buildEquipmentRow(item);
    rowCache.set(key, tr);
    return tr;
  }

  updateEquipmentRow(tr, item);
  return tr;
}

function renderTable(list) {
  const tbody = document.getElementById('equipmentList');
  if (!tbody) { 
    return; 
  }

  const frag = document.createDocumentFragment();
  for (const item of list) {
    frag.appendChild(getOrCreateRow(item));
  }

  tbody.replaceChildren(frag);
  setCount(list.length);
}

// -------------------------
// filter/sort
// -------------------------
function uniqSorted(list) {
  const arr = Array.from(new Set(list.filter(Boolean).map((v) => String(v).trim()).filter(Boolean)));
  arr.sort((a, b) => a.localeCompare(b, 'ko'));
  return arr;
}

function buildRarityOptions(list) {
  const order = ['UR', 'SSR', 'SR', 'R', 'N'];

  const present = new Set(list.map((x) => String(x.rarity || '').trim()).filter(Boolean));
  const out = [];

  for (const r of order) {
    if (present.has(r)) { 
      out.push(r); 
    }
  }

  const extras = Array.from(present).filter((r) => !order.includes(r));
  extras.sort((a, b) => a.localeCompare(b, 'ko'));

  return out.concat(extras);
}

function rarityRank(r) {
  const s = String(r || '').trim();
  if (s === 'UR') { return 0; }
  if (s === 'SSR') { return 1; }
  if (s === 'SR') { return 2; }
  if (s === 'R') { return 3; }
  if (s === 'N') { return 4; }
  return 9;
}

function compareMaybeNumber(a, b) {
  const na = Number(a);
  const nb = Number(b);
  const aOk = Number.isFinite(na);
  const bOk = Number.isFinite(nb);

  if (aOk && bOk) { return na - nb; }
  if (aOk && !bOk) { return -1; }
  if (!aOk && bOk) { return 1; }

  return String(a ?? '').localeCompare(String(b ?? ''), 'ko');
}

function sortList(list, sortState) {
  const dirMul = (sortState?.dir === 'desc') ? -1 : 1;
  const key = sortState?.key || 'default';

  const arr = Array.from(list);

  arr.sort((x, y) => {
    if (key === 'default' || key === 'rarity') {
      const r = rarityRank(x.rarity) - rarityRank(y.rarity);
      if (r !== 0) { return r * dirMul; }

      const c = String(x.category || '').localeCompare(String(y.category || ''), 'ko');
      if (c !== 0) { return c * dirMul; }

      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'name') {
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'category') {
      const c = String(x.category || '').localeCompare(String(y.category || ''), 'ko');
      if (c !== 0) { return c * dirMul; }
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'statType') {
      const s = String(x.statType || '').localeCompare(String(y.statType || ''), 'ko');
      if (s !== 0) { return s * dirMul; }
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'faction') {
      const f = String(x.faction || '').localeCompare(String(y.faction || ''), 'ko');
      if (f !== 0) { return f * dirMul; }
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'minValue') {
      const v = compareMaybeNumber(x.minValue, y.minValue);
      if (v !== 0) { return v * dirMul; }
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    if (key === 'maxValue') {
      const v = compareMaybeNumber(x.maxValue, y.maxValue);
      if (v !== 0) { return v * dirMul; }
      return String(x.name || '').localeCompare(String(y.name || ''), 'ko') * dirMul;
    }

    return 0;
  });

  return arr;
}

function buildFilterOptions(list) {
  const rarity = buildRarityOptions(list);
  const category = uniqSorted(list.map((x) => x.category).filter((v) => !isInvalidGroupValue(v)));
  const faction = uniqSorted(list.map((x) => x.faction).filter((v) => !isInvalidGroupValue(v)));

  return { rarity, category, faction };
}

function createFilterState() {
  return {
    rarity: new Set(),
    category: new Set(),
    faction: new Set()
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
    const rowWrap = document.createElement('div');
    rowWrap.className = 'filter-row';

    const label = document.createElement('div');
    label.className = 'filter-label';
    label.textContent = labelText;

    const buttons = document.createElement('div');
    buttons.className = 'filter-buttons';

    for (const v of values || []) {
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

  root.appendChild(row('희귀도', options.rarity, state.rarity));
  root.appendChild(row('분류', options.category, state.category));
  root.appendChild(row('소속', options.faction, state.faction));
}

function applyFilters(list, query, state) {
  const q = String(query || '').trim().toLowerCase();

  return list.filter((item) => {
    if (q) {
      const name = String(item.name || '').toLowerCase();
      if (!name.includes(q)) { 
        return false; 
      }
    }

    if (state.rarity.size > 0 && !state.rarity.has(item.rarity)) { return false; }
    if (state.category.size > 0 && !state.category.has(item.category)) { return false; }
    if (state.faction.size > 0 && !state.faction.has(item.faction)) { return false; }

    return true;
  });
}

// -------------------------
// main flow
// -------------------------
async function loadEquipmentDbData() {
  const [equipRes, skillRes] = await Promise.all([
    fetch(EQUIP_VM_URL, { cache: 'no-store' }),
    fetch(SKILL_VM_URL, { cache: 'no-store' })
  ]);

  if (!equipRes.ok) {
    throw new Error(`EquipmentVM fetch failed: ${equipRes.status} ${equipRes.statusText}`);
  }
  if (!skillRes.ok) {
    throw new Error(`EquipmentSkillVM fetch failed: ${skillRes.status} ${skillRes.statusText}`);
  }

  const equipVm = await equipRes.json();
  const skillVm = await skillRes.json();

  // skillId -> description
  const skillDescById = new Map();
  if (skillVm && typeof skillVm === 'object') {
    const factionObj = skillVm.faction && typeof skillVm.faction === 'object' ? skillVm.faction : {};
    for (const label of Object.keys(factionObj)) {
      const arr = Array.isArray(factionObj[label]) ? factionObj[label] : [];
      for (const it of arr) {
        const sid = Number(it?.id);
        if (Number.isFinite(sid) && !skillDescById.has(sid)) {
          skillDescById.set(sid, String(it?.description || ''));
        }
      }
    }

    const commonArr = Array.isArray(skillVm.common) ? skillVm.common : [];
    for (const it of commonArr) {
      const sid = Number(it?.id);
      if (Number.isFinite(sid) && !skillDescById.has(sid)) {
        skillDescById.set(sid, String(it?.description || ''));
      }
    }
  }

  const obj = (equipVm && typeof equipVm === 'object') ? equipVm : {};
  const list = Object.values(obj);

  const listAll = list.map((it) => {
    const rarity = String(it?.rarity || '-');
    const imageRel = String(it?.imageRel || '');

    const stat = it?.stat || {};
    const statType = String(stat?.label || '-');

    const fixedId = Number(it?.fixed);
    const fixedDesc = Number.isFinite(fixedId) ? (skillDescById.get(fixedId) || '') : '';

    return {
      id: it?.id,
      imageUrl: buildAssetImageUrl(imageRel),
      name: String(it?.name || '').trim(),
      rarity,
      rarityClass: `rarity-${rarity.toLowerCase()}`,
      category: String(it?.category || '-'),
      faction: String(it?.faction || '-'),
      statType,
      minValue: stat?.min ?? '-',
      maxValue: stat?.max ?? '-',

      // 목록의 “주옵션” = fixed 스킬 1개 설명으로 표시
      mainOption: String(fixedDesc || ''),

      // 확장/디버그 (필요하면 유지)
      growthId: it?.growthId ?? null,
      equipTagId: it?.equipTagId ?? null,
      campTagId: it?.campTagId ?? null
    };
  });

  return { listAll };
}

function applyEquipmentToDom(ctx) {
  const listAll = (ctx?.listAll || [])
    .filter((x) => x !== null)
    .filter((x) => !isInvalidGroupValue(x.category) && !isInvalidGroupValue(x.faction));

  const statusEl = document.getElementById('status');
  if (statusEl) {
    statusEl.remove();
  }

  const filterState = createFilterState();
  const options = buildFilterOptions(listAll);

  const input = document.getElementById('searchInput');
  const clearBtn = document.getElementById('clearFilters');

  const sortState = { key: 'rarity', dir: 'asc' };
  let sortHeadersBound = false;

  function updateSortHeaders() {
    const ths = document.querySelectorAll('thead th.sortable');
    for (const th of ths) {
      const key = th.dataset.sortKey || '';
      th.dataset.sortDir = (key === sortState.key) ? sortState.dir : '';
    }
  }

  function update() {
    const q = input ? input.value : '';
    const filtered = applyFilters(listAll, q, filterState);
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

  function bindSortHeaders() {
    if (sortHeadersBound) { 
      return; 
    }

    sortHeadersBound = true;

    const ths = document.querySelectorAll('thead th.sortable');
    for (const th of ths) {
      th.addEventListener('click', () => {
        const key = th.dataset.sortKey || '';
        if (!key) { 
          return; 
        }

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

  bindSortHeaders();
  renderFilters(options, filterState, updateWithFilters);

  if (input) {
    input.addEventListener('input', function () {
      updateOnly();
    });
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
}

async function main() {
  setStatus('데이터 로딩 중...', false);

  const ctx = await loadEquipmentDbData();
  applyEquipmentToDom(ctx);
}

main().catch((err) => {
  console.error(err);
  setStatus(`데이터를 불러오는 데 실패했습니다.\n${String(err)}`, true);
});
