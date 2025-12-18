// equipmentdb.js
// 목적
// - 번역 적용된 EquipmentFactory.json을 그대로 사용한다.
// - 화면에 필요한 값(분류/소속/속성/입수/최대값/주옵션)을 파생해서 표시한다.
//
// 변경(이번 반영)
// - 데이터 경로 고정: ../../public/data/KR/*.json
// - 소속(팩션) 번역: ConfigLanguage.json 검색 없이 factionMap 하드코딩
// - 최대값: GrowthFactory.json(gAtk_SN/gHp_SN/gDef_SN) 참조
// - 주옵션: EquipmentFactory.skillList[*].skillId -> SkillFactory.json.description (randomSkillList 제외)
// - 주옵션 텍스트: <color=#RRGGBB>...</color> 태그를 실제 색상 HTML로 렌더링 + 개행(<br>) 처리

const DATA_URL = '../../public/data/KR/EquipmentFactory.json';
const GROWTH_URL = '../../public/data/KR/GrowthFactory.json';
const SKILL_URL = '../../public/data/KR/SkillFactory.json';

const ASSET_SMALL_BASE = '../../public/assets/item/weapon';

function rarityToLabel(quality) {
  const q = String(quality || '').trim();

  if (q === 'Orange') return { label: 'UR', cls: 'rarity-ur' };
  if (q === 'Golden') return { label: 'SSR', cls: 'rarity-ssr' };
  if (q === 'Purple') return { label: 'SR', cls: 'rarity-sr' };
  if (q === 'Blue') return { label: 'R', cls: 'rarity-r' };
  if (q === 'White') return { label: 'N', cls: 'rarity-n' };

  return { label: q || '', cls: 'rarity-n' };
}

function isInvalidGroupValue(v) {
  const s = String(v || '').trim();
  if (!s) return true;
  if (s.startsWith('00')) return true;
  if (s.includes('测试') || s.includes('亂斗') || s.includes('乱斗')) return true;
  return false;
}

function byString(v) {
  if (v === null || v === undefined) return '';
  return String(v);
}

function safeNumber(v) {
  if (v === null || v === undefined) return '';
  if (typeof v === 'number') return v;

  const n = Number(v);
  if (Number.isFinite(n)) return n;
  return '';
}

function normalizePathSlash(s) {
  return String(s || '').replaceAll('\\', '/');
}

function buildWeaponImageUrl(pathLike) {
  // 예: Item\\weapon\\Tiemeng\\Small\\01
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

function normalizeRootJson(json) {
  if (Array.isArray(json)) return json;
  if (json && Array.isArray(json.data)) return json.data;
  if (json && Array.isArray(json.list)) return json.list;
  return [];
}

function buildIdMap(list) {
  const map = new Map();
  for (const row of list || []) {
    const id = Number(row?.id || 0);
    if (id) {
      map.set(id, row);
    }
  }
  return map;
}

function parseIdCn(idCN) {
  const raw = normalizePathSlash(idCN);
  const parts = raw.split('/').filter(Boolean);

  const factionRaw = parts.length >= 1 ? parts[0] : '';
  const categoryRaw = parts.length >= 3 ? parts[2] : '';

  const factionCn = factionRaw.replace(/装备$/u, '').trim();

  // 소속(고정 단어) 하드코딩: ConfigLanguage.json 매번 검색하지 않음
  const factionMap = {
    '铁盟': '철도연맹',
    '混沌海': '혼돈해',
    '学会': '시타델',
    '黑月': '흑월',
    '帝国': '제국',
    'ANITA': '아니타',
  };

  const faction = factionMap[factionCn] || factionCn;

  const categoryMap = {
    '武器': '무기',
    '护甲': '방어구',
    '挂件': '장신구',
  };

  const category = categoryMap[categoryRaw] || categoryRaw || '';

  return { faction, category };
}

function scaleStatSn(v) {
  const n = Number(v || 0);
  if (!Number.isFinite(n)) return '';
  return n / 1000;
}

function deriveStatAndValue(e) {
  const a = Number(e?.attack_SN || 0);
  const h = Number(e?.healthPoint_SN || 0);
  const d = Number(e?.defence_SN || 0);

  if (Number.isFinite(a) && a > 0) {
    return { statType: '공격', statKey: 'atk', minValue: scaleStatSn(a) };
  }

  if (Number.isFinite(h) && h > 0) {
    return { statType: '체력', statKey: 'hp', minValue: scaleStatSn(h) };
  }

  if (Number.isFinite(d) && d > 0) {
    return { statType: '방어', statKey: 'def', minValue: scaleStatSn(d) };
  }

  return { statType: '', statKey: '', minValue: '' };
}

function calcMaxValue(e, statKey, growthById) {
  if (!growthById || !statKey) return '';

  const gid = Number(e?.growthId || 0);
  if (!gid) return '';

  const growth = growthById.get(gid);
  if (!growth) return '';

  const base = (() => {
    if (statKey === 'atk') return scaleStatSn(e?.attack_SN);
    if (statKey === 'hp') return scaleStatSn(e?.healthPoint_SN);
    if (statKey === 'def') return scaleStatSn(e?.defence_SN);
    return '';
  })();

  const grow = (() => {
    if (statKey === 'atk') return scaleStatSn(growth?.gAtk_SN);
    if (statKey === 'hp') return scaleStatSn(growth?.gHp_SN);
    if (statKey === 'def') return scaleStatSn(growth?.gDef_SN);
    return '';
  })();

  const b = Number(base);
  const g = Number(grow);

  if (!Number.isFinite(b) || !Number.isFinite(g)) return '';

  return b + g;
}

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

function joinGetwayDisplayName(getway) {
  if (!Array.isArray(getway)) return '';
  const names = [];
  for (const g of getway) {
    const s = String(g?.DisplayName || '').trim();
    if (s) names.push(s);
  }
  return names.join(', ');
}

function mapEquipmentToViewModel(e, growthById, skillById) {
  const id = e?.id;
  const name = e?.name;
  const quality = e?.quality;

  const idCN = e?.idCN;
  const parsed = parseIdCn(idCN);

  const derived = deriveStatAndValue(e);
  const maxValue = calcMaxValue(e, derived.statKey, growthById);

  const mainOption = deriveMainOption(e, skillById);

  const iconPath = e?.iconPath;
  const tipsPath = e?.tipsPath;

  const rarity = rarityToLabel(quality);
  const imageUrl = buildWeaponImageUrl(iconPath) || buildWeaponImageUrl(tipsPath);

  return {
    id: safeNumber(id) || byString(id),
    imageUrl: byString(imageUrl),

    name: byString(name),

    rarity: byString(rarity.label),
    rarityClass: byString(rarity.cls),

    category: byString(parsed.category),
    faction: byString(parsed.faction),

    statType: byString(derived.statType),
    minValue: safeNumber(derived.minValue),
    maxValue: safeNumber(maxValue),

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

function escapeHtml(v) {
  const s = byString(v);

  return s
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;');
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

function formatNumber(v) {
  if (v === null || v === undefined || v === '') return '';

  const n = Number(v);
  if (!Number.isFinite(n)) return byString(v);

  return n.toLocaleString('en-US', { maximumFractionDigits: 3 });
}

function renderTable(list) {
  const tbody = document.getElementById('equipmentList');
  if (!tbody) return;

  tbody.innerHTML = '';

  for (const item of list) {
    const tr = document.createElement('tr');

    const detailHref = `equipment_detail.html?id=${encodeURIComponent(byString(item.id))}`;

    const imgSrc = item.imageUrl || '';
    const imgCell = `
      <td class="cell-center">
        <a href="${detailHref}" aria-label="상세 보기">
          <img
            src="${escapeHtml(imgSrc)}"
            alt=""
            class="eq-thumb"
            onerror="this.outerHTML='-'"
          />
        </a>
      </td>
    `;

    tr.innerHTML = `
      ${imgCell}
      <td class="cell-center cell-name">
        <a class="eq-name-link" href="${detailHref}">${escapeHtml(item.name)}</a>
      </td>
      <td class="cell-center">
        <span class="rarity-badge ${escapeHtml(item.rarityClass)}">${escapeHtml(item.rarity)}</span>
      </td>
      <td class="cell-center">${escapeHtml(item.category)}</td>
      <td class="cell-center">${escapeHtml(item.faction)}</td>
      <td class="cell-center">${escapeHtml(item.statType)}</td>
      <td class="cell-center">${escapeHtml(formatNumber(item.minValue))}</td>
      <td class="cell-center">${escapeHtml(formatNumber(item.maxValue))}</td>
      <td class="cell-center main-option">${renderMainOptionHtml(item.mainOption)}</td>
    `;

    tbody.appendChild(tr);
  }

  setCount(list.length);
}

function uniqSorted(list) {
  const arr = Array.from(new Set(list.filter(Boolean).map(v => String(v).trim()).filter(Boolean)));
  arr.sort((a, b) => a.localeCompare(b, 'ko'));
  return arr;
}

function buildFilterOptions(list) {
  const rarity = uniqSorted(list.map(x => x.rarity));
  const category = uniqSorted(list.map(x => x.category).filter(v => !isInvalidGroupValue(v)));
  const faction = uniqSorted(list.map(x => x.faction).filter(v => !isInvalidGroupValue(v)));
  const statType = uniqSorted(list.map(x => x.statType));

  return { rarity, category, faction, statType };
}

function createFilterState() {
  return {
    rarity: new Set(),
    category: new Set(),
    faction: new Set(),
    statType: new Set(),
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

  root.innerHTML = '';

  function row(title, values, stateSet) {
    const rowEl = document.createElement('div');
    rowEl.className = 'filter-row';

    const label = document.createElement('div');
    label.className = 'filter-label';
    label.textContent = title;

    rowEl.appendChild(label);

    for (const v of values) {
      const selected = isSelected(stateSet, v);
      const btn = makeToggle(v, selected, () => {
        toggleValue(stateSet, v);
        onChange();
      });
      rowEl.appendChild(btn);
    }

    return rowEl;
  }

  root.appendChild(row('희귀도', options.rarity, state.rarity));
  root.appendChild(row('분류', options.category, state.category));
  root.appendChild(row('소속', options.faction, state.faction));
  root.appendChild(row('속성', options.statType, state.statType));
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
    if (state.statType.size > 0 && !state.statType.has(item.statType)) return false;

    return true;
  });
}

async function fetchJson(url) {
  const res = await fetch(url, { cache: 'no-store' });
  if (!res.ok) {
    throw new Error(`Fetch failed: ${url} (${res.status})`);
  }
  return res.json();
}

async function load() {
  setStatus('데이터 로딩 중...', false);

  try {
    const [eqJson, growthJson, skillJson] = await Promise.all([
      fetchJson(DATA_URL),
      fetchJson(GROWTH_URL),
      fetchJson(SKILL_URL),
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

    function update() {
      const q = input ? input.value : '';
      const filtered = applyFilters(viewListAll, q, filterState);
      renderTable(filtered);
    }

    renderFilters(options, filterState, () => {
      update();
      renderFilters(options, filterState, update);
    });

    if (input) {
      input.addEventListener('input', () => update());
    }

    if (clearBtn) {
      clearBtn.addEventListener('click', () => {
        filterState.rarity.clear();
        filterState.category.clear();
        filterState.faction.clear();
        filterState.statType.clear();

        if (input) {
          input.value = '';
        }

        renderFilters(options, filterState, update);
        update();
      });
    }

    update();
    document.title = '장비 DB';

  } catch (e) {
    console.error(e);
    setStatus(`데이터를 불러오는 데 실패했습니다.\n${String(e)}`, true);
  }
}

document.addEventListener('DOMContentLoaded', () => {
  load();
});
