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
  const name = e?.name;
  const rarity = e?.quality;
  const effect = e?.des;

  const idCN = e?.idCN;
  const parsed = parseIdCn(idCN);
  const derived = deriveStatAndValue(e);
  const obtain = joinGetwayDisplayName(e?.Getway);

  // 아이콘 경로(추후 이미지 연결 시 사용)
  const iconPath = e?.iconPath;

  return {
    // UI 컬럼: 이미지 (아직 asset 없음)
    imageUrl: '',

    // 추후 이미지 연결 시 참고
    iconPath: byString(iconPath),

    // UI 컬럼: 이름
    name: byString(name),

    // UI 컬럼: 희귀도(EquipmentFactory: quality)
    rarity: byString(rarity),

    // UI 컬럼: 분류/소속(idCN에서 파생)
    category: byString(parsed.category),
    faction: byString(parsed.faction),

    // UI 컬럼: 속성/초기값(attack_SN / healthPoint_SN / defence_SN에서 파생)
    statType: byString(derived.statType),
    minValue: safeNumber(derived.minValue),

    // 성장/강화 최대값은 다른 파일(성장 테이블)과 연동 필요 -> 비워둠
    maxValue: '',

    // UI 컬럼: 옵션
    effect: byString(effect),

    // UI 컬럼: 입수 방법
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

    // 이미지: asset이 아직 없으니, 우선 테스트 이미지(있으면 표시)로 둔다.
    // - 프로젝트에 실제 이미지가 들어오면 여기만 교체하면 됨.
    const testImgCandidates = [
      // reso_db 기본 구조(예상)
      '../../img/test_item.png',
      '../../img/test.png',
      '../../assets/test_item.png',
      '../../assets/test.png',
      // 같은 폴더에 있을 수도
      './test_item.png',
      './test.png',
    ];

    const imgSrc = testImgCandidates[0];
    const imgCell = `
      <td class="small">
        <img
          src="${imgSrc}"
          alt=""
          style="width:48px;height:48px;object-fit:cover;border-radius:10px;border:1px solid rgba(255,255,255,0.12);"
          onerror="this.outerHTML='-'"
        />
      </td>
    `;

    tr.innerHTML = `
      ${imgCell}
      <td>${escapeHtml(item.name)}</td>
      <td class="small">${escapeHtml(item.rarity)}</td>
      <td class="small">${escapeHtml(item.category)}</td>
      <td class="small">${escapeHtml(item.faction)}</td>
      <td class="small">${escapeHtml(item.statType)}</td>
      <td class="small">${escapeHtml(formatNumber(item.minValue))}</td>
      <td class="small">${escapeHtml(item.maxValue)}</td>
      <td class="effect">${escapeHtmlMultiline(item.effect)}</td>
      <td>${escapeHtmlMultiline(item.obtain)}</td>
    `;

    tbody.appendChild(tr);
  }

  setCount(list.length);
}

function filterList(list, query) {
  const q = String(query || '').trim().toLowerCase();
  if (!q) {
    return list;
  }

  return list.filter(x => {
    const hay = [
      x.name,
      x.rarity,
      x.category,
      x.faction,
      x.statType,
      x.effect,
      x.obtain,
      x.iconPath,
    ].map(v => byString(v).toLowerCase()).join(' | ');

    return hay.includes(q);
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
    const viewList = rawList.map(mapEquipmentToViewModel);

    const statusEl = document.getElementById('status');
    if (statusEl) {
      statusEl.remove();
    }

    renderTable(viewList);

    // 검색
    const input = document.getElementById('searchInput');
    if (input) {
      input.addEventListener('input', () => {
        const filtered = filterList(viewList, input.value);
        renderTable(filtered);
      });
    }

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
