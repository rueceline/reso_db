import { dataPath, buildAssetImageUrl } from '../utils/path.js';
import { safeNumber, getQueryParam, formatTextWithParamsToHtml, normalizePathSlash } from '../utils/utils.js';
import { setText, setHtml, clearChildren } from '../utils/dom.js';
import { DEFAULT_LANG, FETCH_CACHE_MODE } from '../utils/config.js';

// =========================================================
// Equipment Detail Page Script
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

// 변경 후
// -------------------------
// helpers
// -------------------------
const RARITY_ORDER = ['UR', 'SSR', 'SR', 'R', 'N'];

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

function resolveFactionLabelFromSkillRec(skillRec, tagById) {
  const direct = String(skillRec?.sideName || '').trim();
  if (direct) return direct;

  const campList = Array.isArray(skillRec?.campList) ? skillRec.campList : [];
  for (const it of campList) {
    const tid = safeNumber(it?.tagId ?? it?.id);
    if (!tid) continue;

    const t = tagById.get(tid) || null;
    const side = String(t?.sideName || '').trim();
    if (side) return side;
  }

  const spList = Array.isArray(skillRec?.specialTagList) ? skillRec.specialTagList : [];
  for (const it of spList) {
    const tid = safeNumber(it?.tagId ?? it?.id);
    if (!tid) continue;

    const t = tagById.get(tid) || null;
    const side = String(t?.sideName || '').trim();
    if (side) return side;
  }

  return '';
}


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

// 변경 후
async function loadData(id) {
  const [equipRes, tagRes, growthRes, listRes, skillRes] = await Promise.all([fetch(EQUIP_VM_URL, { cache: FETCH_CACHE_MODE }), fetch(TAG_VM_URL, { cache: FETCH_CACHE_MODE }), fetch(GROWTH_VM_URL, { cache: FETCH_CACHE_MODE }), fetch(LIST_VM_URL, { cache: FETCH_CACHE_MODE }), fetch(SKILL_VM_URL, { cache: FETCH_CACHE_MODE })]);

  if (!equipRes.ok) throw new Error(`EquipmentVM fetch failed: ${equipRes.status} ${equipRes.statusText}`);
  if (!tagRes.ok) throw new Error(`TagVM fetch failed: ${tagRes.status} ${tagRes.statusText}`);
  if (!growthRes.ok) throw new Error(`GrowthVM fetch failed: ${growthRes.status} ${growthRes.statusText}`);
  if (!listRes.ok) throw new Error(`ListVM fetch failed: ${listRes.status} ${listRes.statusText}`);
  if (!skillRes.ok) throw new Error(`SkillVM fetch failed: ${skillRes.status} ${skillRes.statusText}`);

  const equipVm = await equipRes.json();
  const tagVm = await tagRes.json();
  const growthVm = await growthRes.json();
  const listVm = await listRes.json(); // (조인 방식 통일용: 현재 detail에서는 random list 조인에 사용하지 않음)
  const skillVm = await skillRes.json();

  const raw = equipVm ? equipVm[String(id)] : null;
  if (!raw) {
    throw new Error(`EquipmentVM record missing: id=${id}`);
  }

  const tagById = new Map();
  if (tagVm && typeof tagVm === 'object') {
    for (const k of Object.keys(tagVm)) {
      const rec = tagVm[k];
      const tid = safeNumber(rec?.id ?? k);
      if (tid !== null) tagById.set(tid, rec);
    }
  }

  const growthById = new Map();
  if (growthVm && typeof growthVm === 'object') {
    for (const k of Object.keys(growthVm)) {
      const rec = growthVm[k];
      const gid = safeNumber(rec?.id ?? k);
      if (gid !== null) growthById.set(gid, rec);
    }
  }

  const listById = new Map();
  if (listVm && typeof listVm === 'object') {
    for (const k of Object.keys(listVm)) {
      const rec = listVm[k];
      const lid = safeNumber(rec?.id ?? k);
      if (lid !== null) listById.set(lid, rec);
    }
  }

  const skillById = new Map();
  if (skillVm && typeof skillVm === 'object') {
    for (const k of Object.keys(skillVm)) {
      const rec = skillVm[k];
      const sid = safeNumber(rec?.id ?? k);
      if (sid !== null) skillById.set(sid, rec);
    }
  }

  // ----- equipmentdb.js 방식으로 필드 조인/계산 -----
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
  const stat = raw?.stat ? raw.stat : calcMainStatWithGrowth(raw, growthRec);

  const tipsPath = String(raw?.tipsPath || raw?.iconPath || raw?.icon || raw?.imagePath || raw?.imageRel || '').trim();
  const imageRel = tipsPath ? normalizePathSlash(tipsPath) : '';

  // 변경 후
  const fixed = safeNumber(raw?.fixed) ?? pickFirstFixedSkillId(raw?.skillList) ?? null;

  // randomSkillList(ListId 목록) -> ListVM -> (EquipmentEntryList[].id = skillId)
  const random = [];
  const randomSkillList = Array.isArray(raw?.randomSkillList) ? raw.randomSkillList : [];

  for (const it of randomSkillList) {
    const listId = safeNumber(it?.skillId);
    if (!listId) continue;

    const listRec = listById.get(listId) || null;
    const entries = Array.isArray(listRec?.EquipmentEntryList) ? listRec.EquipmentEntryList : [];

    for (const ent of entries) {
      const sid = safeNumber(ent?.id);
      if (sid) random.push(sid);
    }
  }

  const getway = Array.isArray(raw?.Getway) ? raw.Getway : [];
  const acquire = getway
    .map((x) => String(x?.DisplayName || '').trim())
    .filter(Boolean)
    .join('\n');

  // 중복 제거
  const uniqRandom = Array.from(new Set(random));

  // detail UI가 기대하는 vm 형태로 변환
  const vm = {
    id: safeNumber(raw?.id),
    name: String(raw?.name || '').trim() || '-',
    rarity,
    category,
    faction,
    imageRel,
    stat: {
      label: stat?.label ?? '-',
      min: stat?.min ?? '-',
      max: stat?.max ?? '-'
    },
    description: String(raw?.description || raw?.des || '').trim(),
    acquire,
    fixed,
    random: uniqRandom
  };

  return { vm, skillById, tagById };
}


function applyToDom(id, ctx) {
  const vm = ctx?.vm;
  if (!vm) {
    setText('equip-name', `장비를 찾을 수 없습니다. id=${id}`);
    return;
  }

  // 변경 후 (applyToDom 초반부)
  const skillById = ctx?.skillById || new Map();
  const tagById = ctx?.tagById || new Map();

  const equipFaction = String(vm?.faction || '').trim();

  const descById = new Map();
  for (const [sid, s] of skillById.entries()) {
    descById.set(sid, String(s?.description || s?.tempdescription || '').trim());
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

  // 변경 후 (random 분류: SkillVM(+TagVM)로 소속 판정)
  for (const sid of randomIds) {
    const s = skillById.get(sid) || null;
    
    console.log(sid, s?.campList, s?.campList.length)

    // campList가 1개면 소속 처리
    const campList = Array.isArray(s?.campList) ? s.campList : [];
    if (campList.length === 1) {
      factionIds.push(sid);
    } else {
      commonIds.push(sid);
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

  const ctx = await loadData(id);
  applyToDom(id, ctx);
  setupSkillExpandToggle();
}

main().catch((err) => {
  console.error(err);
  setText('equip-name', '로딩 실패');
});
