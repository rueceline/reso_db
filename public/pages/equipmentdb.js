import { dataPath, pagePath, buildAssetImageUrl } from '../utils/path.js';
import { safeNumber, formatColorTagsToHtml, normalizePathSlash } from '../utils/utils.js';
import { DEFAULT_LANG, FETCH_CACHE_MODE } from '../utils/config.js';

// =========================================================
// Equipment DB Page Script
// - 실행 흐름: main() → loadData() → applyToDom()
// =========================================================

// -------------------------
// URLs
// -------------------------

const EQUIP_VM_URL = dataPath(DEFAULT_LANG, 'EquipmentVM.json');
const SKILL_VM_URL = dataPath(DEFAULT_LANG, 'SkillVM.json');
const TAG_VM_URL = dataPath(DEFAULT_LANG, 'TagVM.json');
const GROWTH_VM_URL = dataPath(DEFAULT_LANG, 'GrowthVM.json');
const LIST_VM_URL = dataPath(DEFAULT_LANG, 'ListVM.json');

// -------------------------
// helpers
// -------------------------

const RARITY_ORDER = ['UR', 'SSR', 'SR', 'R', 'N'];

function rarityIndex(r) {
  const i = RARITY_ORDER.indexOf(String(r || '').trim());
  return i === -1 ? RARITY_ORDER.length : i;
}

function mapQualityToRarity(quality) {
  const m = {
    Orange: RARITY_ORDER[0],
    Golden: RARITY_ORDER[1],
    Purple: RARITY_ORDER[2],
    Blue: RARITY_ORDER[3],
    White: RARITY_ORDER[4]
  };
  return m[String(quality)] || '-';
}

function resolveMainStat(e) {
  if ((safeNumber(e?.attack_SN) ?? 0) > 0) return { key: 'atk', label: '공격력', sn: e.attack_SN };
  if ((safeNumber(e?.healthPoint_SN) ?? 0) > 0) return { key: 'hp', label: '체력', sn: e.healthPoint_SN };
  if ((safeNumber(e?.defence_SN) ?? 0) > 0) return { key: 'def', label: '방어력', sn: e.defence_SN };
  return { key: '', label: '-', sn: 0 };
}

function calcEquipStatRange(equipSN, growthSN, maxLevel = 80) {
  const equipBase = equipSN / 10000;
  const growthInitial = growthSN / 1000;
  const perLevel = growthSN / 10000;

  const growthMax = growthInitial + perLevel * (maxLevel - 1);
  const delta = equipBase - growthInitial;

  return {
    min: Math.round(equipBase),
    max: Math.round(growthMax + delta)
  };
}

function calcMainStatWithGrowth(e, growthRec) {
  const main = resolveMainStat(e);

  if (!main.key || !growthRec) {
    return { label: main.label, min: '-', max: '-' };
  }

  let growthSN = 0;
  if (main.key === 'atk') growthSN = growthRec.gAtk_SN;
  if (main.key === 'hp') growthSN = growthRec.gHp_SN;
  if (main.key === 'def') growthSN = growthRec.gDef_SN;

  if (!growthSN) {
    const v = Math.round(main.sn / 10000);
    return { label: main.label, min: v, max: v };
  }

  const r = calcEquipStatRange(main.sn, growthSN);
  return { label: main.label, min: r.min, max: r.max };
}

function pickFirstFixedSkillId(skillList) {
  const list = Array.isArray(skillList) ? skillList : [];
  for (const it of list) {
    const sid = safeNumber(it?.skillId);
    if (sid) return sid;
  }
  return null;
}

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
    raritySpan.className = `rarity-badge rarity-${String(item.rarity || '').toLowerCase()}`.trim();
  }

  if (tr.children[3]) {
    tr.children[3].textContent = item.category || '';
  }

  if (tr.children[4]) {
    tr.children[4].textContent = item.faction || '';
  }

  if (tr.children[5]) {
    tr.children[5].textContent = item.statType || '';
  }

  if (tr.children[6]) {
    tr.children[6].textContent = formatNumber(item.minValue) || '-';
  }
  
  if (tr.children[7]) {
    tr.children[7].textContent = formatNumber(item.maxValue) || '-';
  }

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
  const out = [];

  for (const r of RARITY_ORDER) {
    if (present.has(r)) {
      out.push(r);
    }
  }

  const extras = Array.from(present).filter((r) => !RARITY_ORDER.includes(r));
  extras.sort((a, b) => a.localeCompare(b, 'ko'));

  return out.concat(extras);
}

function buildFilterOptions(list) {
  const rarity = buildRarityOptions(list);
  const category = uniqSorted(list.map((x) => x.category));
  const faction = uniqSorted(list.map((x) => x.faction));

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
    if (state.category.size > 0 && !state.category.has(item.category)) {
      return false;
    }
    if (state.faction.size > 0 && !state.faction.has(item.faction)) {
      return false;
    }

    return true;
  });
}

// -------------------------
// main flow
// -------------------------

async function loadData() {
  const [equipRes, tagRes, growthRes, listRes, skillRes] = await 
  Promise.all([
    fetch(EQUIP_VM_URL, { cache: FETCH_CACHE_MODE }), 
    fetch(TAG_VM_URL, { cache: FETCH_CACHE_MODE }), 
    fetch(GROWTH_VM_URL, { cache: FETCH_CACHE_MODE }), 
    fetch(LIST_VM_URL, { cache: FETCH_CACHE_MODE }), 
    fetch(SKILL_VM_URL, { cache: FETCH_CACHE_MODE })
  ]);

  if (!equipRes.ok) {
    throw new Error(`EquipmentVM fetch failed: ${equipRes.status} ${equipRes.statusText}`);
  }

  if (!tagRes.ok) {
    throw new Error(`TagVM fetch failed: ${tagRes.status} ${tagRes.statusText}`);
  }

  if (!growthRes.ok) {
    throw new Error(`GrowthVM fetch failed: ${growthRes.status} ${growthRes.statusText}`);
  }

  if (!listRes.ok) {
    throw new Error(`ListVM fetch failed: ${listRes.status} ${listRes.statusText}`);
  }

  if (!skillRes.ok) {
    throw new Error(`SkillVM fetch failed: ${skillRes.status} ${skillRes.statusText}`);
  }

  const equipVm = await equipRes.json();
  const tagVm = await tagRes.json();
  const growthVm = await growthRes.json();
  const listVm = await listRes.json();
  const skillVm = await skillRes.json();

  const tagById = new Map();
  if (tagVm && typeof tagVm === 'object') {
    for (const k of Object.keys(tagVm)) {
      const rec = tagVm[k];
      const id = safeNumber(rec?.id ?? k);
      if (id !== null) tagById.set(id, rec);
    }
  }

  const growthById = new Map();
  if (growthVm && typeof growthVm === 'object') {
    for (const k of Object.keys(growthVm)) {
      const rec = growthVm[k];
      const id = safeNumber(rec?.id ?? k);
      if (id !== null) growthById.set(id, rec);
    }
  }

  const listById = new Map();
  if (listVm && typeof listVm === 'object') {
    for (const k of Object.keys(listVm)) {
      const rec = listVm[k];
      const id = safeNumber(rec?.id ?? k);
      if (id !== null) listById.set(id, rec);
    }
  }

  const skillById = new Map();
  if (skillVm && typeof skillVm === 'object') {
    for (const k of Object.keys(skillVm)) {
      const rec = skillVm[k];
      const id = safeNumber(rec?.id ?? k);
      if (id !== null) skillById.set(id, rec);
    }
  }

  const obj = equipVm && typeof equipVm === 'object' ? equipVm : {};
  const list = Object.values(obj);

  const listAll = list.map((raw) => {
    const id = safeNumber(raw?.id);
    const name = String(raw?.name || '').trim();
    const rarity = mapQualityToRarity(raw?.quality);
    const equipTagId = safeNumber(raw?.equipTagId);
    const campTagId = safeNumber(raw?.campTagId);

    let category = '-';
    if (equipTagId && tagById.has(equipTagId)) {
      const t = tagById.get(equipTagId);
      category = String(t?.Name || t?.tagName || '-');
    }

    let faction = '-';
    if (campTagId && tagById.has(campTagId)) {
      const t = tagById.get(campTagId);
      faction = String(t?.sideName || '-');
    }

    const growthId = safeNumber(raw?.growthId);
    const growthRec = growthId ? growthById.get(growthId) || null : null;
    const stat = calcMainStatWithGrowth(raw, growthRec);

    const statType = String(stat?.label || '-');
    const minValue = stat?.min ?? '-';
    const maxValue = stat?.max ?? '-';

    const tipsPath = String(raw?.tipsPath || raw?.iconPath || raw?.icon || raw?.imagePath || '').trim();
    const imageRel = tipsPath ? normalizePathSlash(tipsPath) : '';

    const fixedId = pickFirstFixedSkillId(raw?.skillList);
    let fixedDesc = '';
    if (fixedId && skillById.has(fixedId)) {
      const s = skillById.get(fixedId);
      fixedDesc = String(s?.description || s?.tempdescription || '').trim();
    }
    const mainOption = String(formatColorTagsToHtml(fixedDesc) || '');

    return {
      id,
      imageUrl: buildAssetImageUrl(String(imageRel || '').toLowerCase()),
      name,
      rarity,
      category,
      faction,
      statType,
      minValue,
      maxValue,
      mainOption
    };
  });

  return { listAll };
}

function applyToDom(ctx) {
  // rarity -> category -> faction
  const listAll = (ctx?.listAll || [])
    .filter((x) => x !== null)    
    .sort((a, b) => {
      // 1) rarity
      const r = rarityIndex(a.rarity) - rarityIndex(b.rarity);
      if (r !== 0) return r;

      // 2) category
      const c = String(a.category || '').localeCompare(String(b.category || ''), 'ko');
      if (c !== 0) return c;

      // 3) faction
      return String(a.faction || '').localeCompare(String(b.faction || ''), 'ko');
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
    renderTable(filtered);
  }

  function updateOnly() {
    update();
  }

  function updateWithFilters() {
    updateOnly();
    renderFilters(options, filterState, updateWithFilters);
  }

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

  const ctx = await loadData();
  applyToDom(ctx);
}

main().catch((err) => {
  console.error(err);
  setStatus(`데이터를 불러오는 데 실패했습니다.\n${String(err)}`, true);
});
