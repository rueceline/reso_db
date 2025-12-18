// equipmentdb.js
// 목적
// - 번역 적용된 EquipmentFactory.json을 그대로 DB로 사용한다.
// - 이 페이지는 "EquipmentFactory.json의 실제 필드명"(idCN, name, quality, *_SN, des, Getway...)을 기준으로
//   화면에 필요한 값(분류/소속/속성/입수 등)을 *파생*해서 표시한다.
//
// 핵심 개념
// - DB 레코드(원본) -> ViewModel(화면표시용) 변환 레이어(mapEquipmentToViewModel)
// - 다른 파일 참조(세트/스킬/성장 등) / 이미지(asset)는 아직 비워둠
//
// 주의
// - GitHub Pages에서는 fetch 경로가 "레포 루트 기준"으로 잡히는 경우가 많음
//   그래서 DATA_URL_CANDIDATES를 여러 개 두고, 먼저 성공하는 것을 사용함.

const DATA_URL_CANDIDATES = [
  // GitHub Pages에서 보통 index.html 기준으로 public 폴더가 루트가 됨
  // (프로젝트 구조에 따라 달라질 수 있으니 후보를 여러 개 둔다)
  './data/KR/EquipmentFactory.json',
  '../data/KR/EquipmentFactory.json',
  '../../data/KR/EquipmentFactory.json',

  './public/data/KR/EquipmentFactory.json',
  '../public/data/KR/EquipmentFactory.json',
  '../../public/data/KR/EquipmentFactory.json',
];

const ASSET_SMALL_BASE = '../../assets/item/weapon';

function rarityToLabel(quality) {
  const q = String(quality || '').trim();

  if (q === 'Orange') {
    return { label: 'UR', cls: 'rarity-ur' };
  }

  if (q === 'Golden') {
    return { label: 'SSR', cls: 'rarity-ssr' };
  }

  if (q === 'Purple') {
    return { label: 'SR', cls: 'rarity-sr' };
  }

  if (q === 'Blue') {
    return { label: 'R', cls: 'rarity-r' };
  }

  if (q === 'White') {
    return { label: 'N', cls: 'rarity-n' };
  }

  return { label: q || '', cls: 'rarity-n' };
}

function isInvalidGroupValue(v) {
  const s = String(v || '').trim();
  if (!s) {
    return true;
  }

  if (s.startsWith('00')) {
    return true;
  }

  if (s.includes('测试') || s.includes('亂斗') || s.includes('乱斗')) {
    return true;
  }

  return false;
}

// ------------------------------------------------------------
// EquipmentFactory.json 기준 "확정 필드명"
// ------------------------------------------------------------
// 샘플:
// - id / idCN / mod / isInformalData
// - name / quality / des
// - attack_SN / healthPoint_SN / defence_SN
// - iconPath / tipsPath
// - Getway: [{ DisplayName, ... }, ...]
//
// 분류/소속은 idCN 경로에서 파생한다.
//   예) "混沌海装备/金/武器/抗拒从严" -> 소속="混沌海", 분류="무기"
//
// 속성/초기값은 *_SN 중 값이 있는 항목에서 파생한다.
//   예) attack_SN > 0 -> 속성="공격", 초기값=attack_SN

function byString(v) {
  if (v === null || v === undefined) {
    return '';
  }

  return String(v);
}

function safeNumber(v) {
  if (v === null || v === undefined) {
    return '';
  }

  if (typeof v === 'number') {
    return v;
  }

  const n = Number(v);
  if (Number.isFinite(n)) {
    return n;
  }

  return '';
}

function getFirstField(obj, candidates) {
  if (!obj || !candidates) {
    return undefined;
  }

  for (const key of candidates) {
    if (Object.prototype.hasOwnProperty.call(obj, key)) {
      const v = obj[key];
      if (v !== null && v !== undefined && byString(v) !== '') {
        return v;
      }
    }
  }

  return undefined;
}

function normalizePathSlash(s) {
  return String(s || '').replaceAll('\\', '/');
}

function buildWeaponImageUrl(pathLike) {
  // 예: Item\\weapon\\Tiemeng\\Small\\01
  const raw = normalizePathSlash(pathLike);
  const parts = raw.split('/').filter(Boolean);

  const idx = parts.findIndex(x => String(x).toLowerCase() === 'weapon');
  if (idx < 0 || parts.length < idx + 3) {
    return '';
  }

  const faction = String(parts[idx + 1] || '').toLowerCase();
  const size = String(parts[idx + 2] || '').toLowerCase();
  const file = parts.length >= idx + 4 ? parts[idx + 3] : '';

  if (!faction || !size || !file) {
    return '';
  }

  const filename = file.toLowerCase().endsWith('.png') ? file : `${file}.png`;
  return `${ASSET_SMALL_BASE}/${faction}/${size}/${filename}`;
}

function parseIdCn(idCN) {
  const raw = normalizePathSlash(idCN);
  const parts = raw.split('/').filter(Boolean);
  // 기대 형태: [소속+"装备", 희귀도(금/橙/紫...), 분류(武器/护甲/挂件...), 이름...]
  const factionRaw = parts.length >= 1 ? parts[0] : '';
  const categoryRaw = parts.length >= 3 ? parts[2] : '';

  const faction = factionRaw.replace(/装备$/u, '');

  const categoryMap = {
    '武器': '무기',
    '护甲': '방어구',
    '挂件': '장신구',
  };

  const category = categoryMap[categoryRaw] || categoryRaw || '';

  return { faction, category };
}

function deriveStatAndValue(e) {
  const a = Number(e?.attack_SN || 0);
  const h = Number(e?.healthPoint_SN || 0);
  const d = Number(e?.defence_SN || 0);

  if (Number.isFinite(a) && a > 0) {
    return { statType: '공격', minValue: a };
  }

  if (Number.isFinite(h) && h > 0) {
    return { statType: '체력', minValue: h };
  }

  if (Number.isFinite(d) && d > 0) {
    return { statType: '방어', minValue: d };
  }

  return { statType: '', minValue: '' };
}

function joinGetwayDisplayName(getway) {
  if (!Array.isArray(getway)) {
    return '';
  }

  const names = [];
  for (const it of getway) {
    const n = it?.DisplayName;
    if (n && String(n).trim()) {
      names.push(String(n).trim());
    }
  }

  // 중복 제거
  const uniq = Array.from(new Set(names));
  return uniq.join('\n');
}

function normalizeRootJson(json) {
  // 파일에 따라 배열/객체일 수 있어서 방어
  if (Array.isArray(json)) {
    return json;
  }

  if (json && Array.isArray(json.data)) {
    return json.data;
  }

  if (json && Array.isArray(json.list)) {
    return json.list;
  }

  return [];
}

// --------------------------------------------
// 핵심: DB 1레코드 -> 화면 표시용 ViewModel
// --------------------------------------------
function mapEquipmentToViewModel(e) {
  const id = e?.id;
  const name = e?.name;
  const quality = e?.quality;
  const effect = e?.des;

  const idCN = e?.idCN;
  const parsed = parseIdCn(idCN);
  const derived = deriveStatAndValue(e);
  const obtain = joinGetwayDisplayName(e?.Getway);

  // 아이콘 경로
  const iconPath = e?.iconPath;
  const tipsPath = e?.tipsPath;

  const rarity = rarityToLabel(quality);
  const imageUrl = buildWeaponImageUrl(iconPath) || buildWeaponImageUrl(tipsPath);

  return {
    id: safeNumber(id) || byString(id),
    // UI 컬럼: 이미지 (아직 asset 없음)
    imageUrl: byString(imageUrl),

    // 추후 이미지 연결 시 참고
    iconPath: byString(iconPath),

    // UI 컬럼: 이름
    name: byString(name),

    // UI 컬럼: 희귀도(EquipmentFactory: quality)
    rarity: byString(rarity.label),
    rarityClass: byString(rarity.cls),

    // UI 컬럼: 분류/소속(idCN에서 파생)
    category: byString(parsed.category),
    faction: byString(parsed.faction),

    // UI 컬럼: 속성/초기값(attack_SN / healthPoint_SN / defence_SN에서 파생)
    statType: byString(derived.statType),
    minValue: safeNumber(derived.minValue),

    // 성장/강화 최대값은 다른 파일(성장 테이블)과 연동 필요 -> 비워둠
    maxValue: '',

    // 상세 페이지에서 사용
    effect: byString(effect),
    obtain: byString(obtain),
  };
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

function escapeHtml(v) {
  const s = byString(v);

  return s
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;');
}

function escapeHtmlMultiline(v) {
  const s = escapeHtml(v);
  return s.replaceAll('\n', '<br>');
}

function formatNumber(v) {
  if (v === null || v === undefined || v === '') {
    return '';
  }

  const n = Number(v);
  if (!Number.isFinite(n)) {
    return byString(v);
  }

  return n.toLocaleString('en-US');
}

function renderTable(list) {
  const tbody = document.getElementById('equipmentList');
  if (!tbody) {
    return;
  }

  tbody.innerHTML = '';

  for (const item of list) {
    const tr = document.createElement('tr');

    const detailHref = `equipment_detail.html?id=${encodeURIComponent(byString(item.id))}`;

    const imgSrc = item.imageUrl || '';
    const imgCell = `
      <td class="small">
        <a href="${detailHref}" aria-label="상세 보기">
          <img
            src="${escapeHtml(imgSrc)}"
            alt=""
            style="width:48px;height:48px;object-fit:cover;border-radius:12px;border:1px solid rgba(255,255,255,0.12);"
            onerror="this.outerHTML='-'"
          />
        </a>
      </td>
    `;

    tr.innerHTML = `
      ${imgCell}
      <td>
        <a class="eq-name-link" href="${detailHref}">${escapeHtml(item.name)}</a>
      </td>
      <td class="small"><span class="rarity-badge ${escapeHtml(item.rarityClass)}">${escapeHtml(item.rarity)}</span></td>
      <td class="small">${escapeHtml(item.category)}</td>
      <td class="small">${escapeHtml(item.faction)}</td>
      <td class="small">${escapeHtml(item.statType)}</td>
      <td class="small">${escapeHtml(formatNumber(item.minValue))}</td>
      <td class="small">${escapeHtml(item.maxValue)}</td>
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

function renderFilterGroup(container, label, values, selectedSet, onToggle, getButtonClass) {
  const row = document.createElement('div');
  row.className = 'filter-row';

  const title = document.createElement('div');
  title.className = 'filter-label';
  title.textContent = label;
  row.appendChild(title);

  for (const v of values) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'toggle' + (getButtonClass ? ` ${getButtonClass(v)}` : '');
    btn.dataset.value = v;
    btn.dataset.selected = selectedSet.has(v) ? '1' : '0';
    btn.textContent = v;
    btn.addEventListener('click', () => onToggle(v));
    row.appendChild(btn);
  }

  container.appendChild(row);
}

function renderFilters(options, state, onChange) {
  const el = document.getElementById('filters');
  if (!el) {
    return;
  }

  el.innerHTML = '';

  renderFilterGroup(
    el,
    '희귀도',
    options.rarity,
    state.rarity,
    (v) => {
      if (state.rarity.has(v)) {
        state.rarity.delete(v);
      } else {
        state.rarity.add(v);
      }
      onChange();
    },
    (v) => {
      // UR/SSR/SR/R/N -> badge 클래스 재사용
      const upper = String(v).toUpperCase();
      if (upper === 'UR') return 'rarity-ur';
      if (upper === 'SSR') return 'rarity-ssr';
      if (upper === 'SR') return 'rarity-sr';
      if (upper === 'R') return 'rarity-r';
      return 'rarity-n';
    }
  );

  renderFilterGroup(el, '분류', options.category, state.category, (v) => {
    if (state.category.has(v)) {
      state.category.delete(v);
    } else {
      state.category.add(v);
    }
    onChange();
  });

  renderFilterGroup(el, '소속', options.faction, state.faction, (v) => {
    if (state.faction.has(v)) {
      state.faction.delete(v);
    } else {
      state.faction.add(v);
    }
    onChange();
  });

  renderFilterGroup(el, '속성', options.statType, state.statType, (v) => {
    if (state.statType.has(v)) {
      state.statType.delete(v);
    } else {
      state.statType.add(v);
    }
    onChange();
  });
}

function applyFilters(list, query, state) {
  const q = String(query || '').trim().toLowerCase();

  return list.filter(x => {
    if (q && !byString(x.name).toLowerCase().includes(q)) {
      return false;
    }

    if (state.rarity.size && !state.rarity.has(x.rarity)) {
      return false;
    }

    if (state.category.size && !state.category.has(x.category)) {
      return false;
    }

    if (state.faction.size && !state.faction.has(x.faction)) {
      return false;
    }

    if (state.statType.size && !state.statType.has(x.statType)) {
      return false;
    }

    return true;
  });
}

async function fetchFirstOk(urls) {
  for (const url of urls) {
    try {
      const res = await fetch(url, { cache: 'no-store' });
      if (!res.ok) {
        continue;
      }

      const json = await res.json();
      return { url, json };
    } catch (e) {
      // next
    }
  }

  throw new Error('All DATA_URL_CANDIDATES failed');
}

async function load() {
  setStatus('데이터 로딩 중...', false);

  try {
    const { url, json } = await fetchFirstOk(DATA_URL_CANDIDATES);

    const rawList = normalizeRootJson(json);
    const viewListAll = rawList
      .map(mapEquipmentToViewModel)
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

    // 디버깅용: 실제 로드된 경로를 title에 잠깐 표시
    document.title = `장비 DB (${url.split('/').slice(-1)[0]})`;

  } catch (e) {
    console.error(e);
    setStatus(
      `데이터를 불러오는 데 실패했습니다.\n(후보 경로: ${DATA_URL_CANDIDATES.join(', ')})`,
      true
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  load();
});
