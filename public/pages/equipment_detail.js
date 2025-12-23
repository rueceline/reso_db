import { 
  dataPath, 
  weaponImagePath 
} from '../utils/path.js';

import { 
  EquipmentFactory,
  SkillFactory,
  ListFactory,
  GrowthFactory,
  normalizeRootJson, 
  safeNumber, 
  mapQualityToRarity,
} from '../utils/data.js';

import { 
  fetchJson, 
  formatColorTagsToHtml, 
  getQueryParam, 
  normalizePathSlash 
} from '../utils/utils.js';

import { setText, setHtml, clearChildren } from '../utils/dom.js';

import { DEFAULT_LANG } from '../utils/config.js';

// -------------------------
// URLs
// -------------------------

const DATA_URL = dataPath(DEFAULT_LANG, 'EquipmentFactory.json');
const GROWTH_URL = dataPath(DEFAULT_LANG, 'GrowthFactory.json');
const SKILL_URL = dataPath(DEFAULT_LANG, 'SkillFactory.json');
const LIST_URL = dataPath(DEFAULT_LANG, 'ListFactory.json');

const ASSET_SMALL_BASE = weaponImagePath('');

// =========================================================
// Equipment Detail Page Script
// - 실행 흐름: main() → loadEquipmentDetailData() → applyEquipmentToDom()
// - 아래(엔트리)에서 위(헬퍼)로 역추적하기 쉽게 배치
// =========================================================

// -------------------------
// helpers
// -------------------------

// [Group] Path/Asset Helpers
// - buildWeaponImageUrl / resolveEquipmentImageUrl

function buildWeaponImageUrl(pathLike) {
  const raw = normalizePathSlash(pathLike);
  const parts = raw.split('/').filter(Boolean);

  const idx = parts.findIndex((x) => String(x).toLowerCase() === 'weapon');
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
  return `${ASSET_SMALL_BASE.replace(/\/$/, '')}/${faction}/${size}/${filename}`;
}

function resolveEquipmentImageUrl(e) {
  return buildWeaponImageUrl(e?.tipsPath) || buildWeaponImageUrl(e?.iconPath) || '';
}

// [Group] DOM Builders (Detail Only)
// - createOptionRow / createSkillCard

function createOptionRow(htmlText) {
  const row = document.createElement('div');
  row.className = 'option-row';

  const body = document.createElement('div');
  body.className = 'opt-body';
  body.innerHTML = htmlText;

  row.appendChild(body);
  return row;
}

function createSkillCard(skill, metaText, equipFactory) {
  const card = document.createElement('div');
  card.className = 'skill-card';

  const skillName = equipFactory.resolveSkillName(skill);
  if (skillName) {
    const name = document.createElement('div');
    name.className = 'skill-name';
    name.textContent = skillName;
    card.appendChild(name);
  }

  const desc = document.createElement('div');
  desc.className = 'skill-desc';

  let d = String(equipFactory.resolveSkillDesc(skill) || '');

  // 템플릿 파라미터 치환:
  // - %s%% / %d%%  -> x%
  // - %s%  / %d%   -> x%
  // - %s   / %d    -> x
  d = d
    .replace(/%\s*[sd]\s*%%/g, 'x%')
    .replace(/%\s*[sd]\s*%/g, 'x%')
    .replace(/%\s*[sd]/g, 'x');

  desc.innerHTML = formatColorTagsToHtml(d);

  card.appendChild(desc);

  if (metaText) {
    const meta = document.createElement('div');
    meta.className = 'skill-meta muted';
    meta.textContent = metaText;
    card.appendChild(meta);
  }

  return card;
}

// [Group] Media Helpers
// - setImage

function setImage(src) {
  const img = document.getElementById('equip-image');
  const fallback = document.getElementById('equip-image-fallback');
  if (!img || !fallback) {
    return;
  }

  if (src) {
    img.src = src;
    img.hidden = false;
    fallback.hidden = true;
  } else {
    img.removeAttribute('src');
    img.hidden = true;
    fallback.hidden = false;
  }
}

function setupSkillExpandToggle() {
  const block = document.getElementById('skill-block');
  const btn = document.getElementById('skill-toggle');
  const body = document.getElementById('skill-block-body');

  if (!block || !btn || !body) {
    return;
  }

  function setOpen(open) {
    if (open) {
      block.classList.add('is-open');
      block.classList.remove('is-collapsed');
      body.hidden = false;
      btn.setAttribute('aria-expanded', 'true');
    } else {
      block.classList.remove('is-open');
      block.classList.add('is-collapsed');
      body.hidden = true;
      btn.setAttribute('aria-expanded', 'false');
    }
  }

  // 기본: 접힘
  setOpen(false);

  btn.addEventListener('click', function () {
    const isOpen = block.classList.contains('is-open');
    setOpen(!isOpen);
  });
}

// [Group] Text Normalizers
// - normalizeAcquireText / formatFixedCountText

function normalizeAcquireText(e) {
  const gw = e?.Getway;
  if (Array.isArray(gw)) {
    const names = [];
    for (const it of gw) {
      const s = String(it?.DisplayName ?? '').trim();
      if (s) {
        names.push(s);
      }
    }
    return names.join(' / ');
  }

  const t = String(e?.obtain ?? e?.acquire ?? e?.getPath ?? e?.gain ?? '').trim();
  return t;
}

function formatFixedCountText(fixedMax) {
  return `옵션 수 1/${fixedMax}`;
}

// -------------------------
// main flow
// -------------------------

// [Group] Data Loading
async function loadEquipmentDetailData() {
  const growthFactory = new GrowthFactory({ growthUrl: GROWTH_URL });
  const skillFactory = new SkillFactory({ skillUrl: SKILL_URL });
  const listFactory = new ListFactory({ listUrl: LIST_URL });

  const equipFactory = new EquipmentFactory({ equipmentUrl: DATA_URL });

  const [equipJson] = await Promise.all([
    fetchJson(DATA_URL), 
    growthFactory.load(), 
    skillFactory.load(), 
    listFactory.load()
  ]);

  const equipList = normalizeRootJson(equipJson);

  const growthById = growthFactory.getMap();
  const skillById = skillFactory.getMap();
  const listById = listFactory.getMap();

  equipFactory.setContext({ growthById, skillById, listById });

  return { equipList, growthById, skillById, listById, equipFactory };
}

// [Group] DOM Apply
function applyEquipmentToDom(e, ctx) {
  setText('equip-name', (e?.name || '').trim() || '-');

  const equipFactory = ctx.equipFactory;

  const rarity = mapQualityToRarity(e?.quality);
  const parsed = equipFactory.parseEquipmentIdCN(e?.idCN);
  const category = parsed.category;
  const faction = parsed.faction;
  const id = safeNumber(e?.id);

  setText('equip-rarity', rarity);
  const rarityEl = document.getElementById('equip-rarity');
  if (rarityEl) {
    rarityEl.setAttribute('data-rarity', rarity || '-');
  }

  setText('equip-meta', `분류: 장비 > ${category} · 소속: ${faction} · ID: ${id ?? '-'}`);

  const growthId = safeNumber(e?.growthId);
  const growth = growthId === null ? null : ctx.growthById.get(growthId) || null;
  const stat = equipFactory.calcMainStatWithGrowth(e, growth);

  setText('equip-stat-main', stat.label);

  const minText = stat.min !== '-' ? Number(stat.min).toLocaleString() : '-';
  const maxText = stat.max !== '-' ? Number(stat.max).toLocaleString() : '-';
  setText('equip-stat-min', minText);
  setText('equip-stat-max', maxText);

  setHtml('equip-description', formatColorTagsToHtml(e?.des || e?.description || ''));

  setImage(resolveEquipmentImageUrl(e));

  const fixedSkills = equipFactory.resolveFixedSkills(e);

  const fixedMax = equipFactory.getFixedOptionMax(category);
  setText('fixed-skill-count', formatFixedCountText(fixedMax));

  const fixedList = document.getElementById('fixed-skill-list');
  if (fixedList) {
    clearChildren(fixedList);

    if (!fixedSkills.length) {
      const empty = document.createElement('div');
      empty.className = 'muted';
      empty.textContent = '고정 옵션 없음';
      fixedList.appendChild(empty);
    } else {
      for (const s of fixedSkills) {
        fixedList.appendChild(createOptionRow(formatColorTagsToHtml(equipFactory.resolveSkillDesc(s))));
      }
    }
  }

  const acquire = normalizeAcquireText(e);
  const acquireEl = document.getElementById('equip-acquire');
  if (acquireEl) {
    clearChildren(acquireEl);

    const line = document.createElement('div');
    line.className = 'acquire-item';
    line.textContent = acquire || '-';
    acquireEl.appendChild(line);
  }

  const pools = equipFactory.buildRandomOptionPools(e);

  const factionEl = document.getElementById('random-skill-faction');
  const commonEl = document.getElementById('random-skill-common');
  if (factionEl) clearChildren(factionEl);
  if (commonEl) clearChildren(commonEl);

  let factionCount = 0;
  let commonCount = 0;

  for (const p of pools) {
    for (const [label, skills] of p.faction.entries()) {
      if (!skills.length) {
        continue;
      }

      const title = document.createElement('div');
      title.className = 'random-skill-subtitle';
      title.textContent = `소속 - ${faction}`;

      factionEl.appendChild(title);

      for (const skill of skills) {
        factionEl.appendChild(createSkillCard(skill, '', equipFactory));
        factionCount += 1;
      }
    }

    for (const skill of p.common) {
      commonEl.appendChild(createSkillCard(skill, '', equipFactory));
      commonCount += 1;
    }
  }

  setText('random-skill-count', `소속 ${factionCount} / 공용 ${commonCount}`);

  if (factionEl && !factionEl.childElementCount) {
    const empty = document.createElement('div');
    empty.className = 'muted';
    empty.textContent = '소속 랜덤 옵션 없음';
    factionEl.appendChild(empty);
  }

  if (commonEl && !commonEl.childElementCount) {
    const empty = document.createElement('div');
    empty.className = 'muted';
    empty.textContent = '공용 랜덤 옵션 없음';
    commonEl.appendChild(empty);
  }
}

// [Group] Entry
async function main() {
  const id = safeNumber(getQueryParam('id'));
  if (id === null) {
    setText('equip-name', 'id 파라미터가 없습니다.');
    return;
  }

  const { equipList, growthById, skillById, listById, equipFactory } = await loadEquipmentDetailData();

  const e = equipList.find((x) => safeNumber(x?.id) === id);
  if (!e) {
    setText('equip-name', `장비를 찾을 수 없습니다. id=${id}`);
    return;
  }

  applyEquipmentToDom(e, { growthById, skillById, listById, equipFactory });
  setupSkillExpandToggle();
}

main().catch((err) => {
  console.error(err);
  setText('equip-name', '로딩 실패');
});

