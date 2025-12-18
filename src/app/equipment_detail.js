// equipment_detail.js
// - equipmentdb.html(목록)에서 id 쿼리스트링을 받아 상세를 표시한다.
// - 데이터 구조는 EquipmentFactory.json(번역 적용본) 그대로 사용한다.

const DATA_URL_CANDIDATES = [
  './public/data/KR/EquipmentFactory.json',
  '../public/data/KR/EquipmentFactory.json',
  '../../public/data/KR/EquipmentFactory.json',
];

const ASSET_SMALL_BASE = '../../assets/item/weapon';

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

function setStatus(text, isError) {
  const el = document.getElementById('status');
  if (!el) {
    return;
  }

  el.textContent = text;
  el.style.color = isError ? 'rgba(255,140,140,0.92)' : 'rgba(255,255,255,0.75)';
}

function normalizePathSlash(s) {
  return String(s || '').replaceAll('\\', '/');
}

function buildWeaponImageUrl(pathLike) {
  // 예: Item\\weapon\\Tiemeng\\Small\\01
  const raw = normalizePathSlash(pathLike);
  const parts = raw.split('/').filter(Boolean);

  const idx = parts.findIndex(x => String(x).toLowerCase() === 'weapon');
  if (idx < 0 || parts.length < idx + 4) {
    return '';
  }

  const faction = String(parts[idx + 1] || '').toLowerCase();
  const size = String(parts[idx + 2] || '').toLowerCase();
  const file = String(parts[idx + 3] || '');

  if (!faction || !size || !file) {
    return '';
  }

  const filename = file.toLowerCase().endsWith('.png') ? file : `${file}.png`;
  return `${ASSET_SMALL_BASE}/${faction}/${size}/${filename}`;
}

function parseIdCn(idCN) {
  const raw = normalizePathSlash(idCN);
  const parts = raw.split('/').filter(Boolean);

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

  const uniq = Array.from(new Set(names));
  return uniq.join('\n');
}

function normalizeRootJson(json) {
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

function getQueryParam(name) {
  const params = new URLSearchParams(location.search);
  return params.get(name);
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

function showContent() {
  const status = document.getElementById('status');
  const content = document.getElementById('content');
  if (status) {
    status.style.display = 'none';
  }
  if (content) {
    content.style.display = 'block';
  }
}

function renderDetail(vm) {
  const rarity = rarityToLabel(vm.quality);

  const image = document.getElementById('eqImage');
  const name = document.getElementById('eqName');
  const badge = document.getElementById('eqRarityBadge');
  const idText = document.getElementById('eqIdText');

  const category = document.getElementById('eqCategory');
  const faction = document.getElementById('eqFaction');
  const statType = document.getElementById('eqStatType');
  const statRange = document.getElementById('eqStatRange');

  const effect = document.getElementById('eqEffect');
  const obtain = document.getElementById('eqObtain');
  const paths = document.getElementById('eqPaths');

  if (image) {
    image.src = vm.imageUrl || '';
    image.onerror = () => {
      image.removeAttribute('src');
      image.style.display = 'none';
    };
  }

  if (name) {
    name.textContent = vm.name;
  }

  if (badge) {
    badge.className = `rarity-badge ${rarity.cls}`;
    badge.textContent = rarity.label;
  }

  if (idText) {
    idText.textContent = `id: ${byString(vm.id)}`;
  }

  if (category) {
    category.textContent = vm.category || '-';
  }

  if (faction) {
    faction.textContent = vm.faction || '-';
  }

  if (statType) {
    statType.textContent = vm.statType || '-';
  }

  if (statRange) {
    const min = formatNumber(vm.minValue);
    const max = vm.maxValue ? byString(vm.maxValue) : '';
    statRange.textContent = max ? `${min} / ${max}` : (min || '-');
  }

  if (effect) {
    effect.textContent = vm.effect || '-';
  }

  if (obtain) {
    obtain.textContent = vm.obtain || '-';
  }

  if (paths) {
    const lines = [];
    if (vm.iconPath) {
      lines.push(`iconPath: ${vm.iconPath}`);
    }
    if (vm.tipsPath) {
      lines.push(`tipsPath: ${vm.tipsPath}`);
    }
    paths.textContent = lines.length ? lines.join('\n') : '-';
  }

  document.title = `장비 상세 - ${vm.name}`;
}

function mapEquipmentToViewModel(e) {
  const id = e?.id;
  const name = e?.name;
  const quality = e?.quality;
  const effect = e?.des;

  const idCN = e?.idCN;
  const parsed = parseIdCn(idCN);
  const derived = deriveStatAndValue(e);
  const obtain = joinGetwayDisplayName(e?.Getway);

  const iconPath = e?.iconPath;
  const tipsPath = e?.tipsPath;

  const imageUrl = buildWeaponImageUrl(iconPath) || buildWeaponImageUrl(tipsPath);

  return {
    id: safeNumber(id) || byString(id),
    name: byString(name),
    quality: byString(quality),
    imageUrl: byString(imageUrl),
    iconPath: byString(iconPath),
    tipsPath: byString(tipsPath),
    category: byString(parsed.category),
    faction: byString(parsed.faction),
    statType: byString(derived.statType),
    minValue: safeNumber(derived.minValue),
    maxValue: '',
    effect: byString(effect),
    obtain: byString(obtain),
  };
}

async function load() {
  const id = getQueryParam('id');
  if (!id) {
    setStatus('id 파라미터가 없습니다.\n목록에서 다시 선택해 주세요.', true);
    return;
  }

  try {
    const { url, json } = await fetchFirstOk(DATA_URL_CANDIDATES);
    const rawList = normalizeRootJson(json);

    const found = rawList.find(x => byString(x?.id) === byString(id));
    if (!found) {
      setStatus(`해당 id를 찾지 못했습니다: ${id}`, true);
      return;
    }

    const vm = mapEquipmentToViewModel(found);
    showContent();
    renderDetail(vm);

    // 디버깅용
    document.title = `장비 상세 (${url.split('/').slice(-1)[0]}) - ${vm.name}`;

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
