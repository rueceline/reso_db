import { 
  dataPath, 
  assetPath, 
  uiSideIconPath, 
  uiCommonPath 
} from '../utils/path.js';

import {  
  UnitFactory,
  SkillFactory,
  TagFactory,
  TalentFactory,
  ProfilePhotoFactory,
  AwakeFactory,
  safeNumber,
} from '../utils/data.js';

import { 
  getQueryParam, 
  normalizePathSlash 
} from '../utils/utils.js';

import { qs, setText, clearChildren } from '../utils/dom.js';

import { DEFAULT_LANG } from '../utils/config.js';

// -----------------------------
// Asset helpers (경로는 화면에 그대로도 표시, URL은 "시도"만)
// -----------------------------
function ensureImageExt(pathLike) {
  const raw = normalizePathSlash(pathLike);
  if (!raw) {
    return '';
  }

  const low = raw.toLowerCase();
  if (low.endsWith('.png') || low.endsWith('.jpg') || low.endsWith('.jpeg') || low.endsWith('.webp')) {
    return raw;
  }

  return `${raw}.png`;
}

function tryAssetUrl(factoryPathLike) {
  const raw = normalizePathSlash(factoryPathLike);
  if (!raw) {
    return '';
  }

  if (raw.startsWith('http://') || raw.startsWith('https://') || raw.startsWith('/')) {
    return raw;
  }

  return assetPath(ensureImageExt(raw));
}

function trySideIconUrl(tagRec) {
  const raw = normalizePathSlash(tagRec?.iconPath || tagRec?.icon || '');
  if (!raw) {
    return '';
  }

  const base = raw.split('/').pop() || '';
  if (!base) {
    return '';
  }

  if (base.startsWith('camp_')) {
    return uiSideIconPath(`${base}.png`);
  }

  return uiCommonPath(`${base}.png`);
}

function tryCommonIconUrl(tagRec) {
  const raw = normalizePathSlash(tagRec?.icon || tagRec?.iconPath || '');
  if (!raw) {
    return '';
  }

  const base = raw.split('/').pop() || '';
  if (!base) {
    return '';
  }

  return uiCommonPath(`${base}.png`);
}

// -----------------------------
// Small parsers
// -----------------------------
function extractRarityFromIdCN(idCN) {
  const s = String(idCN || '');
  const parts = s.split('/');
  const token = parts.find((p) => /星/.test(p)) || '';
  const m = token.match(/(\d+)\s*星/);
  const n = m ? Number(m[1]) : null;

  if (!n || Number.isNaN(n)) {
    return '';
  }

  return `${n}성`;
}

function pickGenderFromTags(unitRec, tagF) {
  const list = Array.isArray(unitRec?.tagList) ? unitRec.tagList : [];
  for (const it of list) {
    const tid = safeNumber(it?.tagId);
    if (tid === null) {
      continue;
    }

    const t = tagF.getById(tid);
    const idCN = String(t?.idCN || '');
    if (idCN.endsWith('/女性')) {
      return '여성';
    }
    if (idCN.endsWith('/男性')) {
      return '남성';
    }
  }

  return '';
}

function pickCareerTag(unitRec, tagF) {
  const list = Array.isArray(unitRec?.careerList) ? unitRec.careerList : [];
  for (const it of list) {
    const tid = safeNumber(it?.des);
    if (tid === null) {
      continue;
    }

    const t = tagF.getById(tid);
    if (t) {
      return t;
    }
  }

  return null;
}

// -----------------------------
// DOM helpers
// -----------------------------
function setImg(id, url) {
  const el = qs(`#${id}`);
  if (!el) {
    return;
  }

  if (url) {
    el.src = url;
    el.hidden = false;
  } else {
    el.removeAttribute('src');
    el.hidden = true;
  }
}

function setTextIf(id, v) {
  const el = qs(`#${id}`);
  if (!el) {
    return;
  }

  setText(el, v);
}

function renderKeyValue(containerId, rows) {
  const root = qs(`#${containerId}`);
  if (!root) {
    return;
  }

  clearChildren(root);

  for (const r of rows) {
    const wrap = document.createElement('div');
    wrap.className = 'kv-row';

    const k = document.createElement('div');
    k.className = 'kv-k';
    k.textContent = String(r.key || '');

    const v = document.createElement('div');
    v.className = 'kv-v';
    v.textContent = String(r.value ?? '');

    wrap.appendChild(k);
    wrap.appendChild(v);
    root.appendChild(wrap);
  }
}

function renderTextBlock(containerId, text) {
  const root = qs(`#${containerId}`);
  if (!root) {
    return;
  }

  root.textContent = String(text || '');
}

// -----------------------------
// Sections
// -----------------------------
function renderProperty(unitRec) {
  renderKeyValue('char-property', [
    { key: 'hp_SN', value: String(unitRec?.hp_SN ?? '') },
    { key: 'atk_SN', value: String(unitRec?.atk_SN ?? '') },
    { key: 'def_SN', value: String(unitRec?.def_SN ?? '') },
    { key: 'atkSpeed_SN', value: String(unitRec?.atkSpeed_SN ?? '') },
    { key: 'luck_SN', value: String(unitRec?.luck_SN ?? '') }
  ]);
}

function renderSkillList(unitRec, skillF) {
  const root = qs('#char-skill-list');
  if (!root) {
    return;
  }

  clearChildren(root);

  const list = Array.isArray(unitRec?.skillList) ? unitRec.skillList : [];
  if (list.length === 0) {
    const p = document.createElement('div');
    p.className = 'muted';
    p.textContent = '스킬 정보 없음';
    root.appendChild(p);
    return;
  }

  for (const it of list) {
    const sid = safeNumber(it?.skillId);
    if (sid === null) {
      continue;
    }

    const s = skillF.getById(sid) || {};
    const name = String(s?.name || `Skill ${sid}`).trim();

    const iconPath = String(s?.iconPath || '').trim();
    const desc = String(s?.description || '').trim();
    const detailDesc = String(s?.detailDescription || '').trim();

    const card = document.createElement('section');
    card.className = 'skill-card';

    const row = document.createElement('div');
    row.className = 'skill-row';

    const iconWrap = document.createElement('div');
    iconWrap.className = 'skill-icon-wrap';

    const icon = document.createElement('img');
    icon.className = 'skill-icon';
    icon.alt = '';
    icon.loading = 'lazy';
    icon.decoding = 'async';

    const iconUrl = tryAssetUrl(iconPath);
    if (iconUrl) {
      icon.src = iconUrl;
      icon.hidden = false;
    } else {
      icon.hidden = true;
    }

    iconWrap.appendChild(icon);

    const main = document.createElement('div');
    main.className = 'skill-main';

    const hd = document.createElement('div');
    hd.className = 'skill-hd';
    hd.textContent = name;

    const meta = document.createElement('div');
    meta.className = 'skill-meta';
    meta.textContent = `skillId=${sid}`;

    const pathLine = document.createElement('div');
    pathLine.className = 'path-line';
    pathLine.textContent = iconPath ? `iconPath: ${iconPath}` : 'iconPath: (empty)';

    main.appendChild(hd);
    main.appendChild(meta);
    main.appendChild(pathLine);

    if (desc) {
      const bd = document.createElement('div');
      bd.className = 'skill-bd';
      bd.textContent = desc;
      main.appendChild(bd);
    }

    if (detailDesc) {
      const bd2 = document.createElement('div');
      bd2.className = 'skill-bd-detail';
      bd2.textContent = detailDesc;
      main.appendChild(bd2);
    }

    row.appendChild(iconWrap);
    row.appendChild(main);

    card.appendChild(row);
    root.appendChild(card);
  }
}

function renderReplenish(unitRec, viewRec) {
  renderKeyValue('char-replenish', [
    { key: 'UnitFactory.id', value: String(unitRec?.id ?? '') },
    { key: 'UnitFactory.idCN', value: String(unitRec?.idCN ?? '') },
    { key: 'UnitFactory.viewId', value: String(unitRec?.viewId ?? '') },
    { key: 'UnitViewFactory.id', value: String(viewRec?.id ?? '') },
    { key: 'UnitFactory.controllerId', value: String(unitRec?.controllerId ?? '') }
  ]);
}

function renderRecord(unitRec) {
  const root = qs('#char-record');
  if (!root) {
    return;
  }

  clearChildren(root);

  const resume = Array.isArray(unitRec?.ResumeList) ? unitRec.ResumeList : [];
  const story = Array.isArray(unitRec?.StoryList) ? unitRec.StoryList : [];

  const blocks = [];

  if (resume.length > 0) {
    blocks.push({ title: '소개', list: resume.map((x) => String(x?.des || '')).filter((s) => s) });
  }

  if (story.length > 0) {
    blocks.push({ title: '스토리', list: story.map((x) => String(x?.des || x?.story || '')).filter((s) => s) });
  }

  if (blocks.length === 0) {
    const p = document.createElement('div');
    p.className = 'muted';
    p.textContent = '기록 정보 없음';
    root.appendChild(p);
    return;
  }

  for (const b of blocks) {
    const sec = document.createElement('section');
    sec.className = 'record-block';

    const h = document.createElement('div');
    h.className = 'record-title';
    h.textContent = b.title;

    sec.appendChild(h);

    for (const line of b.list) {
      const p = document.createElement('p');
      p.className = 'record-line';
      p.textContent = line;
      sec.appendChild(p);
    }

    root.appendChild(sec);
  }
}

function renderPhotoSticker(viewRec, photoF) {
  const root = qs('#char-photo-grid');
  if (!root) {
    return;
  }

  clearChildren(root);

  const ids = [];
  const p0 = safeNumber(viewRec?.profilePhotoID);
  const p1 = safeNumber(viewRec?.State1profilePhotoID);
  const p2 = safeNumber(viewRec?.State2profilePhotoID);

  if (p0 !== null) ids.push(p0);
  if (p1 !== null) ids.push(p1);
  if (p2 !== null) ids.push(p2);

  if (ids.length === 0) {
    const p = document.createElement('div');
    p.className = 'muted';
    p.textContent = '프로필 사진 없음';
    root.appendChild(p);
    return;
  }

  for (const id of ids) {
    const rec = photoF.getById(id) || {};
    const imgPath = String(rec?.imagePath || '').trim();
    const url = tryAssetUrl(imgPath);

    const item = document.createElement('div');
    item.className = 'photo-item';

    const img = document.createElement('img');
    img.alt = '';
    img.loading = 'lazy';
    img.decoding = 'async';

    if (url) {
      img.src = url;
      img.hidden = false;
    } else {
      img.hidden = true;
    }

    const cap = document.createElement('div');
    cap.className = 'photo-cap path-line';
    cap.textContent = imgPath ? `imagePath: ${imgPath}` : 'imagePath: (empty)';

    item.appendChild(img);
    item.appendChild(cap);
    root.appendChild(item);
  }
}

// -----------------------------
// Data load (팩토리 참조 로직 유지)
// -----------------------------
async function loadAllFactories() {
  const unitF = new UnitFactory({
    unitUrl: dataPath(DEFAULT_LANG, 'UnitFactory.json'),
    unitViewUrl: dataPath(DEFAULT_LANG, 'UnitViewFactory.json')
  });

  const skillF = new SkillFactory({
    skillUrl: dataPath(DEFAULT_LANG, 'SkillFactory.json')
  });

  const tagF = new TagFactory({
    tagUrl: dataPath(DEFAULT_LANG, 'TagFactory.json')
  });

  const talentF = new TalentFactory({
    talentUrl: dataPath(DEFAULT_LANG, 'TalentFactory.json')
  });

  const photoF = new ProfilePhotoFactory({
    photoUrl: dataPath(DEFAULT_LANG, 'ProfilePhotoFactory.json')
  });

  const awakeF = new AwakeFactory({
    awakeUrl: dataPath(DEFAULT_LANG, 'AwakeFactory.json')
  });

  await Promise.all([
    unitF.load(),
    skillF.load(),
    tagF.load(),
    talentF.load(),
    photoF.load(),
    awakeF.load()
  ]);

  return { unitF, skillF, tagF, talentF, photoF, awakeF };
}

function findUnitById(units, id) {
  const key = safeNumber(id);
  if (key === null) {
    return null;
  }

  for (const u of units) {
    if (safeNumber(u?.id) === key) {
      return u;
    }
  }

  return null;
}

function findViewById(viewById, viewId) {
  const key = safeNumber(viewId);
  if (key === null) {
    return null;
  }

  return viewById.get(key) || null;
}

async function loadData() {
  const idRaw = getQueryParam('id');
  const id = safeNumber(idRaw);

  if (id === null) {
    throw new Error('character_detail: id 파라미터가 없습니다.');
  }

  const { unitF, skillF, tagF, talentF, photoF, awakeF } = await loadAllFactories();

  const unitLoaded = await unitF.load();
  const unitRec = findUnitById(unitLoaded.units, id);

  if (!unitRec) {
    throw new Error(`character_detail: UnitFactory에서 id=${id} 레코드를 찾지 못했습니다.`);
  }

  const viewRec = findViewById(unitLoaded.viewById, unitRec.viewId);

  return { unitRec, viewRec, skillF, tagF, talentF, photoF, awakeF };
}

// -----------------------------
// Apply
// -----------------------------
function applyCharacterToDom(ctx) {
  const { unitRec, viewRec, skillF, tagF, photoF } = ctx;

  // 헤더/기본
  setTextIf('char-name', String(unitRec?.name || ''));
  setTextIf('char-name-en', String(unitRec?.EnglishName || ''));

  const rarity = extractRarityFromIdCN(unitRec?.idCN);
  setTextIf('char-rarity', rarity || '');

  // 소속 / 포지션 아이콘 (이미지 + path 텍스트)
  const sideTag = tagF.getById(unitRec?.sideId);
  setImg('char-side-icon', trySideIconUrl(sideTag));
  setTextIf('char-side-icon-path', String(sideTag?.iconPath || sideTag?.icon || ''));

  const careerTag = pickCareerTag(unitRec, tagF);
  setImg('char-pos-icon', tryCommonIconUrl(careerTag));
  setTextIf('char-pos-icon-path', String(careerTag?.icon || careerTag?.iconPath || ''));

  // 확정: 생일/성별/신장
  const bm = String(unitRec?.birthdayMonth || '').trim();
  const bd = String(unitRec?.birthdayDay || '').trim();
  const birthday = bm && bd ? `${bm}월 ${bd}일` : '';

  const gender = pickGenderFromTags(unitRec, tagF);
  const height = String(unitRec?.height || '').trim();

  setTextIf('char-birthday', birthday || '미상');
  setTextIf('char-gender', gender || '미상');
  setTextIf('char-height', height || '미상');

  // 미확정: 출신/기본대사
  setTextIf('char-origin', '미확정');
  setTextIf('char-quote-text', '미확정');

  // 일러스트(일단 viewRec의 path 보여주기 + URL 시도)
  const illPath = String(viewRec?.roleListResUrl || viewRec?.squadsHalf1 || '').trim();
  setTextIf('char-illustration-path', illPath || '(empty)');
  setImg('char-illustration', tryAssetUrl(illPath));

  // 아래 섹션들
  renderProperty(unitRec);
  renderSkillList(unitRec, skillF);
  renderReplenish(unitRec, viewRec || {});
  renderRecord(unitRec);

  if (viewRec) {
    renderPhotoSticker(viewRec, photoF);
  } else {
    renderTextBlock('char-photo-grid', 'UnitViewFactory 레코드 없음');
  }

  // 탐색 필요 섹션은 placeholder
  renderTextBlock('char-resonance', '관련 팩토리 탐색 필요');
  renderTextBlock('char-awake', '관련 팩토리 탐색 필요');
}

async function main() {
  try {
    const ctx = await loadData();
    applyCharacterToDom(ctx);
  } catch (err) {
    console.error(err);

    const box = qs('#char-error');
    if (box) {
      box.hidden = false;
      box.textContent = String(err?.message || err);
    }
  }
}

document.addEventListener('DOMContentLoaded', main);
