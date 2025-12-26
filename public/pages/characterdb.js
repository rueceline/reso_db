import { dataPath, assetPath, pagePath, buildAssetImageUrl } from '../utils/path.js';
import { fetchJson } from '../utils/utils.js';
import { qs, setText, clearChildren } from '../utils/dom.js';
import { DEFAULT_LANG } from '../utils/config.js';

// =========================================================
// Character DB Page Script
// - 실행 흐름: main() → loadData() → applyDom()
// =========================================================

// -------------------------
// URLs
// -------------------------
const UNIT_VM_URL = dataPath(DEFAULT_LANG, 'UnitVM.json');

// -------------------------
// local helpers
// -------------------------
function byString(v) {
  return v === null || v === undefined ? '' : String(v);
}

function applyImageFallback(imgEl, text) {
  imgEl.addEventListener('error', () => {
    imgEl.style.display = 'none';

    const fallback = document.createElement('div');
    fallback.className = 'img-fallback-text';
    fallback.textContent = text || '이미지 없음';

    imgEl.parentElement.appendChild(fallback);
  });
}

function buildFactionIconUrl(iconRel) {
  const rel = String(iconRel || '').trim();
  if (!rel) {
    return '';
  }

  // 원래 URL(대소문자 포함) 유지: ext는 그대로 붙여서 assetPath로 생성
  return assetPath(`${rel}.png`);
}

function buildPosIconUrl(line) {
  const n = Number(line);
  if (!Number.isFinite(n) || n <= 0) {
    return '';
  }

  // line → Row 이미지 매핑 규칙
  // 1 = Front  (UI/Common/row/RowFront.png)
  // 2 = Middle (UI/Common/row/RowMiddle.png)
  // 3 = Back   (UI/Common/row/RowBack.png)
  if (n === 1) return buildAssetImageUrl('UI/Common/row/RowFront');
  if (n === 2) return buildAssetImageUrl('UI/Common/row/RowMiddle');
  if (n === 3) return buildAssetImageUrl('UI/Common/row/RowBack');

  return '';
}

function genderLabel(v) {
  const s = byString(v).trim();
  if (!s) return '';

  const key = s.toLowerCase();

  if (key === 'm' || key === 'male' || key === 'man') return '남성';
  if (key === 'f' || key === 'female' || key === 'woman') return '여성';

  if (s === '남' || s === '남성' || s === '男') return '남성';
  if (s === '여' || s === '여성' || s === '女') return '여성';

  if (s === '女（？）') return '여성(?)';
  if (s === '不详') return '불명';
  if (s === '无') return '기계';

  return s;
}

function positionLabel(line) {
  const v = String(line ?? '').trim();
  if (v === '1') return '앞열';
  if (v === '2') return '중간열';
  if (v === '3') return '뒷열';
  return v;
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

function uniqSorted(list) {
  const arr = Array.from(new Set(list.filter(Boolean).map((v) => String(v).trim()).filter(Boolean)));
  arr.sort((a, b) => a.localeCompare(b, 'ko'));
  return arr;
}

function buildRarityOptions(list) {
  const order = ['SSR', 'SR', 'R', 'N'];

  const present = new Set(list.map((x) => String(x?.rarity || '').trim().toUpperCase()).filter(Boolean));
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

// -------------------------
// card render
// -------------------------
function buildCard(item) {
  const a = document.createElement('a');
  a.className = 'char-card';
  a.href = `${pagePath('character_detail.html')}?id=${encodeURIComponent(byString(item.id))}`;

  const thumb = document.createElement('div');
  thumb.className = 'char-thumb';

  // 카드 공통 마스크 URL을 thumb에 주입
  thumb.style.setProperty(
    '--card-mask-url',
    `url(${buildAssetImageUrl('UI/Common/characterlist/CharacterList_mask')})`
  );

  const rarityKey = byString(item.rarity || 'N').toUpperCase() || 'N';

  const bgBack = document.createElement('img');
  bgBack.className = 'char-bg-rarity-back';
  bgBack.alt = '';
  bgBack.loading = 'lazy';
  bgBack.decoding = 'async';
  bgBack.src = buildAssetImageUrl(`UI/Common/characterlist/CharacterList_bg_rarity_${rarityKey}`);

  const portrait = document.createElement('img');
  portrait.className = 'char-portrait';
  portrait.alt = '';
  portrait.loading = 'lazy';
  portrait.decoding = 'async';
  portrait.src = item.portraitUrl || '';

  applyImageFallback(portrait, item.name);

  const bgFront = document.createElement('img');
  bgFront.className = 'char-bg-rarity-front';
  bgFront.alt = '';
  bgFront.loading = 'lazy';
  bgFront.decoding = 'async';
  bgFront.src = buildAssetImageUrl(`UI/Common/characterlist/CharacterList_bg_rarity_${rarityKey}_mask`);

  const pos = document.createElement('img');
  pos.className = 'char-pos-icon';
  pos.alt = '';
  pos.loading = 'lazy';
  pos.decoding = 'async';
  pos.src = item.posIconUrl || '';
  pos.hidden = !pos.src;

  const side = document.createElement('img');
  side.className = 'char-side-icon';
  side.alt = '';
  side.loading = 'lazy';
  side.decoding = 'async';
  side.src = item.factionIconUrl || '';
  side.hidden = !side.src;

  const nameIn = document.createElement('div');
  nameIn.className = 'char-name-in';
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

function render(items) {
  const root = qs('#characterGrid');
  if (!root) {
    return;
  }

  clearChildren(root);

  for (const it of items) {
    root.appendChild(buildCard(it));
  }

  setText('countBadge', `총 ${items.length}명`);
}

// -------------------------
// filter/sort (equipmentdb.js 스타일)
// -------------------------
function buildFilterOptions(list) {
  const rarity = buildRarityOptions(list);

  const positionPresent = new Set(
    list
      .map((x) => Number(x?.line))
      .filter((n) => Number.isFinite(n) && n > 0)
      .map((n) => String(n))
  );
  const positionOrder = ['1', '2', '3'];
  const position = positionOrder.filter((v) => positionPresent.has(v));

  const gender = uniqSorted(list.map((x) => x.gender).filter((v) => !isInvalidGroupValue(v)));
  const faction = uniqSorted(list.map((x) => x.factionName).filter((v) => !isInvalidGroupValue(v)));

  return { rarity, position, gender, faction };
}

function createFilterState() {
  return {
    rarity: new Set(),
    position: new Set(),
    gender: new Set(),
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

  function row(labelText, values, setRef, labelFn) {
    const rowWrap = document.createElement('div');
    rowWrap.className = 'filter-row';

    const label = document.createElement('div');
    label.className = 'filter-label';
    label.textContent = labelText;

    const buttons = document.createElement('div');
    buttons.className = 'filter-buttons';

    for (const v of values || []) {
      const show = labelFn ? labelFn(v) : v;

      const btn = makeToggle(show, setRef.has(v), () => {
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
  root.appendChild(row('위치', options.position, state.position, (v) => positionLabel(v)));
  root.appendChild(row('성별', options.gender, state.gender, (v) => genderLabel(v)));
  root.appendChild(row('세력', options.faction, state.faction));
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

    const rarity = String(item.rarity || '').trim().toUpperCase();
    const position = String(item.line ?? '').trim();
    const gender = String(item.gender || '').trim();
    const faction = String(item.factionName || '').trim();

    if (state.rarity.size > 0 && !state.rarity.has(rarity)) return false;
    if (state.position.size > 0 && !state.position.has(position)) return false;
    if (state.gender.size > 0 && !state.gender.has(gender)) return false;
    if (state.faction.size > 0 && !state.faction.has(faction)) return false;

    return true;
  });
}

// -------------------------
// main flow
// -------------------------
async function loadData() {
  const vm = await fetchJson(UNIT_VM_URL);

  // UnitVM은 { [id]: rec } 형태
  const rawItems = Object.values(vm || {});

  const items = rawItems.map((it) => {
    const portraitRel = byString(it?.portraitRel);
    const factionIconName = byString(it?.factionIconName);

    return {
      ...it,

      portraitUrl: buildAssetImageUrl(portraitRel),
      factionIconUrl: buildFactionIconUrl(factionIconName),
      posIconUrl: buildPosIconUrl(it?.line),

      rarity: String(it?.rarity || '').trim().toUpperCase(),
      name: String(it?.name || '').trim(),
      gender: byString(it?.gender).trim(),
      factionName: byString(it?.factionName).trim()
    };
  });
  
  // odder rarity -> id 
  items.sort((a, b) => {
    const order = { SSR: 0, SR: 1, R: 2, N: 3 };
    const ra = String(a?.rarity || '');
    const rb = String(b?.rarity || '');
    if (ra !== rb) {
      return (order[ra] ?? 9) - (order[rb] ?? 9);
    }
    return String(a?.id || '').localeCompare(String(b?.id || ''), 'ko');
  });

  return items;
}

function applyDom(listAll) {
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
    render(filtered);
  }

  function updateWithFilters() {
    update();
    renderFilters(options, filterState, updateWithFilters);
  }

  renderFilters(options, filterState, updateWithFilters);

  if (input) {
    input.addEventListener('input', function () {
      update();
    });
  }

  if (clearBtn) {
    clearBtn.addEventListener('click', () => {
      filterState.rarity.clear();
      filterState.position.clear();
      filterState.gender.clear();
      filterState.faction.clear();

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
  setText('status', '불러오는 중...', false);

  const listAll = await loadData();
  applyDom(listAll);
}

main().catch((err) => {
  console.error(err);
  setText('status', `데이터를 불러오는 데 실패했습니다.\n${String(err)}`, true);
});
