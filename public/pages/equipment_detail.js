import { dataPath, buildAssetImageUrl } from '../utils/path.js';
import { getQueryParam, formatTextWithParamsToHtml } from '../utils/utils.js';
import { setText, setHtml, clearChildren } from '../utils/dom.js';
import { safeNumber } from '../utils/data.js';

import { DEFAULT_LANG } from '../utils/config.js';

const EQUIP_VM_URL = dataPath(DEFAULT_LANG, 'EquipmentVM.json');
const SKILL_VM_URL = dataPath(DEFAULT_LANG, 'EquipmentSkillVM.json');

// =========================================================
// Equipment Detail Page Script
// - 실행 흐름: main() → loadEquipmentDetailData() → applyEquipmentToDom()
// =========================================================

// -------------------------
// helpers
// -------------------------

function createOptionRow(htmlText) {
  const row = document.createElement('div');
  row.className = 'option-row';

  const body = document.createElement('div');
  body.className = 'opt-body';
  body.innerHTML = htmlText;

  row.appendChild(body);
  return row;
}

function createSkillTableRow(htmlText) {
  const row = document.createElement('div');
  row.className = 'opt-table-row';

  const body = document.createElement('div');
  body.className = 'opt-body';
  body.innerHTML = htmlText;

  row.appendChild(body);
  return row;
}

function setImageRel(src) {
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

  setOpen(false);

  btn.addEventListener('click', function () {
    const isOpen = block.classList.contains('is-open');
    setOpen(!isOpen);
  });
}

function formatFixedCountText(fixedMax) {
  return `옵션 수 1/${fixedMax}`;
}

function getFixedOptionMax(category) {
  if (category === '장신구') {
    return 6;
  }

  return 4;
}

// -------------------------
// main flow
// -------------------------

async function loadEquipmentDetailData(id) {
  const [equipRes, skillRes] = await Promise.all([fetch(EQUIP_VM_URL, { cache: 'force-cache' }), fetch(SKILL_VM_URL, { cache: 'force-cache' })]);

  if (!equipRes.ok) {
    throw new Error(`EquipmentVM fetch failed: ${equipRes.status} ${equipRes.statusText}`);
  }
  if (!skillRes.ok) {
    throw new Error(`EquipmentSkillVM fetch failed: ${skillRes.status} ${skillRes.statusText}`);
  }

  const equipVm = await equipRes.json();
  const skillVm = await skillRes.json();

  const rec = equipVm ? equipVm[String(id)] : null;
  if (!rec) {
    throw new Error(`EquipmentVM record missing: id=${id}`);
  }

  return { vm: rec, skillVm };
}

function applyEquipmentToDom(id, ctx) {
  const vm = ctx?.vm;
  if (!vm) {
    setText('equip-name', `장비를 찾을 수 없습니다. id=${id}`);
    return;
  }

  const skillVm = ctx?.skillVm || null;

  const equipFaction = vm?.faction;
  const factionSkillSet = new Set();
  const commonSkillSet = new Set();

  if (skillVm && typeof skillVm === 'object') {
    // 내 장비 소속 스킬
    if (equipFaction && Array.isArray(skillVm[equipFaction])) {
      const arr = skillVm[equipFaction];

      for (const it of arr) {
        const id = it?.id;
        if (id != null) {
          factionSkillSet.add(id);
        }
      }
    }

    // 공용 스킬 (flat 스키마에서 "공용" 키)
    if (Array.isArray(skillVm['공용'])) {
      const arr = skillVm['공용'];

      for (const it of arr) {
        const id = it?.id;
        if (id != null) {
          commonSkillSet.add(id);
        }
      }
    }
  }

  // skillId -> description (표시용)
  const descById = new Map();

  // description 채우기: 모든 그룹을 순회 (표시용)
  if (skillVm && typeof skillVm === 'object') {
    for (const groupName of Object.keys(skillVm)) {
      const arr = Array.isArray(skillVm[groupName]) ? skillVm[groupName] : [];
      for (const it of arr) {
        const id = it?.id;
        if (id != null && !descById.has(id)) {
          descById.set(id, String(it?.description ?? '').trim());
        }
      }
    }
  }

  setText('equip-name', String(vm.name || '').trim() || '-');

  const rarity = String(vm.rarity || '-');
  const category = String(vm.category || '-');
  const faction = String(vm.faction || '-');

  // 소속 제목: "소속 - {소속명}"
  {
    const titleEl = document.getElementById('random-skill-faction-title');
    if (titleEl) {
      const name = String(vm.faction || '').trim() || '-';
      titleEl.textContent = `소속 - ${name}`;
    }
  }

  setText('equip-rarity', rarity);

  const rarityEl = document.getElementById('equip-rarity');
  if (rarityEl) {
    rarityEl.setAttribute('data-rarity', rarity || '-');
  }

  setText('equip-meta', `분류: 장비 > ${category} · 소속: ${faction} · ID: ${id}`);

  const stat = vm.stat || {};
  setText('equip-stat-main', String(stat.label || '-') || '-');

  const minText = stat.min !== '-' && stat.min !== null && stat.min !== undefined ? Number(stat.min).toLocaleString() : '-';
  const maxText = stat.max !== '-' && stat.max !== null && stat.max !== undefined ? Number(stat.max).toLocaleString() : '-';
  setText('equip-stat-min', minText);
  setText('equip-stat-max', maxText);

  setHtml('equip-description', formatTextWithParamsToHtml(vm.description || ''));

  setImageRel(buildAssetImageUrl(vm?.imageRel.toLowerCase()));

  // Fixed (단일 skillId)
  const fixedId = safeNumber(vm?.fixed);
  // 최대 옵션 수는 카테고리 기준
  const fixedMax = getFixedOptionMax(vm?.category);
  // 표시는 항상 1 / fixedMax
  setText('fixed-skill-count', formatFixedCountText(fixedMax));

  const fixedList = document.getElementById('fixed-skill-list');
  if (fixedList) {
    clearChildren(fixedList);

    if (fixedId === null) {
      const empty = document.createElement('div');
      empty.className = 'muted';
      empty.textContent = '고정 옵션 없음';
      fixedList.appendChild(empty);
    } else {
      const html = formatTextWithParamsToHtml(descById.get(fixedId));
      fixedList.appendChild(createOptionRow(html || '-'));
    }
  }

  // Acquire
  const acquire = String(vm.acquire || '').trim();
  const acquireEl = document.getElementById('equip-acquire');
  if (acquireEl) {
    clearChildren(acquireEl);

    const t = acquire || '-';
    const parts = t
      .split(/\r?\n|\/\s*/g)
      .map((s) => String(s || '').trim())
      .filter(Boolean);

    if (!parts.length) {
      const line = document.createElement('div');
      line.className = 'acquire-item';
      line.textContent = '-';
      acquireEl.appendChild(line);
    } else {
      for (const p of parts) {
        const line = document.createElement('div');
        line.className = 'acquire-item';
        line.textContent = p;
        acquireEl.appendChild(line);
      }
    }
  }

  // Random (skillId[] 평탄화)
  const randomIds = Array.isArray(vm?.random) ? vm.random : [];

  const factionEl = document.getElementById('random-skill-faction');
  const commonEl = document.getElementById('random-skill-common');

  if (factionEl) {
    clearChildren(factionEl);
  }
  if (commonEl) {
    clearChildren(commonEl);
  }

  const factionIds = [];
  const commonIds = [];

  for (const id of randomIds) {
    if (factionSkillSet.has(id)) {
      factionIds.push(id);
    } else if (commonSkillSet.has(id)) {
      commonIds.push(id);
    } else {
      // EquipmentSkillVM에 없는 id (매칭 누락/데이터 누락)
      commonIds.push(id); // 기존 UI 유지
      // 필요하면 여기서 console.log로 누락 id를 찍어도 됨
      // console.log('unknown random skill id:', id);
    }
  }

  // 카운트 표시
  {
    const el = document.getElementById('random-skill-count');
    if (el) {
      el.textContent = `소속 ${factionIds.length} / 공용 ${commonIds.length}`;
    }
  }

    // 소속(장비 소속 1개만) - 표 형태
  if (factionEl) {
    factionEl.classList.add('is-table');

    if (factionIds.length) {
      for (const sid of factionIds) {
        const html = formatTextWithParamsToHtml(descById.get(sid));
        factionEl.appendChild(createSkillTableRow(html || `ID ${sid}`));
      }
    } else {
      const empty = document.createElement('div');
      empty.className = 'muted';
      empty.textContent = '소속 랜덤 옵션 없음';
      factionEl.appendChild(empty);
    }
  }

  // 공용(그 외 전부) - 표 형태
  if (commonEl) {
    commonEl.classList.add('is-table');

    if (commonIds.length) {
      for (const sid of commonIds) {
        const html = formatTextWithParamsToHtml(descById.get(sid));
        commonEl.appendChild(createSkillTableRow(html || `ID ${sid}`));
      }
    } else {
      const empty = document.createElement('div');
      empty.className = 'muted';
      empty.textContent = '공용 랜덤 옵션 없음';
      commonEl.appendChild(empty);
    }
  }
}

async function main() {
  const id = safeNumber(getQueryParam('id'));
  if (id === null) {
    setText('equip-name', 'id 파라미터가 없습니다.');
    return;
  }

  const ctx = await loadEquipmentDetailData(id);
  applyEquipmentToDom(id, ctx);
  setupSkillExpandToggle();
}

main().catch((err) => {
  console.error(err);
  setText('equip-name', '로딩 실패');
});
