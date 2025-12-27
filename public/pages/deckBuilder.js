// public/pages/deckBuilder.js
// DeckBuilder (vanilla) - Step 1: CharacterWindow
// - /data/KR/UnitVM.json + UnitViewVM.json + TagVM.json 로드
// - 캐릭터 선택 모달: 검색/선택 → 슬롯 배치

import { buildAssetImageUrl } from '../utils/path.js';

function qs(sel, root = document) {
  return root.querySelector(sel);
}
function qsa(sel, root = document) {
  return Array.from(root.querySelectorAll(sel));
}
function show(el) {
  if (el) el.hidden = false;
}
function hide(el) {
  if (el) el.hidden = true;
}
function byString(v) {
  return v === null || v === undefined ? '' : String(v);
}

const DATA_LANG = 'KR';
const UNIT_VM_URL = `/data/${DATA_LANG}/UnitVM.json`;
const UNIT_VIEW_VM_URL = `/data/${DATA_LANG}/UnitViewVM.json`;
const TAG_VM_URL = `/data/${DATA_LANG}/TagVM.json`;

const CARD_VM_URL = `/data/${DATA_LANG}/CardVM.json`;
const SKILL_VM_URL = `/data/${DATA_LANG}/SkillVM.json`;

const state = {
  activeSlot: 0,
  slotCharacters: [null, null, null, null, null],
  allCharacters: [],
  filtered: [],

  // VM caches (join용)
  unitVm: null,
  cardVm: null,
  skillVm: null,

  // Available Cards === Deck
  deckCards: [], // 실제 덱(순서 포함)
  filteredCards: [] // 검색 결과(표시용)
};

function setStatus(text, isError = false) {
  const el = qs('#character-status');
  if (!el) return;
  el.textContent = text;
  el.classList.toggle('is-error', !!isError);
}

function setActiveSlot(i) {
  const n = Number(i);
  state.activeSlot = Number.isFinite(n) ? Math.max(0, Math.min(4, Math.trunc(n))) : 0;
  const slotsRoot = qs('#character-slots');
  if (slotsRoot) slotsRoot.setAttribute('data-active-slot', String(state.activeSlot));
}

function stripExt(relOrUrl) {
  return byString(relOrUrl)
    .trim()
    .replace(/\\/g, '/')
    .replace(/^\/+/g, '')
    .replace(/\.(png|webp|jpg|jpeg)$/i, '');
}

function buildPortraitUrlFromView(viewRec) {
  if (!viewRec) return '';

  const a = byString(viewRec?.roleListResUrl).trim();
  const b = byString(viewRec?.squadsHalf1).trim();
  const c = byString(viewRec?.squadsHalf2).trim();
  const d = byString(viewRec?.bookHalf).trim();

  const src = a || b || c || d;
  const rel = stripExt(src);
  return rel ? buildAssetImageUrl(rel) : '';
}

async function loadCharacterData() {
  setStatus('Loading...');

  const [unitRes, viewRes, tagRes] = await Promise.all([fetch(UNIT_VM_URL, { cache: 'force-cache' }), fetch(UNIT_VIEW_VM_URL, { cache: 'force-cache' }), fetch(TAG_VM_URL, { cache: 'force-cache' })]);

  if (!unitRes.ok) throw new Error(`UnitVM fetch failed: ${unitRes.status} ${unitRes.statusText}`);
  if (!viewRes.ok) throw new Error(`UnitViewVM fetch failed: ${viewRes.status} ${viewRes.statusText}`);
  if (!tagRes.ok) throw new Error(`TagVM fetch failed: ${tagRes.status} ${tagRes.statusText}`);

  const unitVm = await unitRes.json();
  const viewVm = await viewRes.json();
  const tagVm = await tagRes.json();

  state.unitVm = unitVm;

  // tagById (현재 step에서는 sideName만 필요할 수 있어 보관만)
  const tagById = new Map();
  if (tagVm && typeof tagVm === 'object') {
    for (const k of Object.keys(tagVm)) {
      const rec = tagVm[k];
      const id = Number(rec?.id ?? k);
      if (Number.isFinite(id)) tagById.set(id, rec);
    }
  }

  // characterId -> "기본" viewRec
  const basicViewByCharId = {};
  if (viewVm && typeof viewVm === 'object') {
    for (const k of Object.keys(viewVm)) {
      const v = viewVm[k];
      if (!v) continue;
      if (byString(v.SkinName).trim() !== '기본') continue;

      const cid = Number(v.character);
      if (!Number.isFinite(cid)) continue;
      if (basicViewByCharId[cid] === undefined) basicViewByCharId[cid] = v;
    }
  }

  const rawItems = Object.values(unitVm || {});
  const list = rawItems.map((u) => {
    const id = byString(u?.id).trim();
    const name = byString(u?.name).trim();

    const viewId = Number(u?.viewId);
    let viewRec = Number.isFinite(viewId) && viewVm ? viewVm[String(viewId)] || viewVm[viewId] || null : null;

    if (!viewRec || byString(viewRec.SkinName).trim() !== '기본') {
      const cid = Number(u?.id);
      viewRec = Number.isFinite(cid) && basicViewByCharId[cid] ? basicViewByCharId[cid] : viewRec;
    }

    const portraitUrl = buildPortraitUrlFromView(viewRec);

    // sideName(필요 시)
    const sideId = Number(u?.sideId);
    const tagRec = Number.isFinite(sideId) ? tagById.get(sideId) || null : null;
    const factionName = byString(tagRec?.sideName).trim();

    return { id, name, portraitUrl, factionName };
  });

  // 기본 정렬: name, id (원본 기준은 미확정 -> 최소한 안정 정렬)
  list.sort((a, b) => {
    const an = a.name || '';
    const bn = b.name || '';
    const c = an.localeCompare(bn, 'ko');
    if (c !== 0) return c;
    return (a.id || '').localeCompare(b.id || '', 'ko');
  });

  state.allCharacters = list;
  state.filtered = list;
  setStatus(`Loaded: ${list.length}`);
}

function renderCharacterSlots() {
  const slotsRoot = qs('#character-slots');
  if (!slotsRoot) return;

  qsa('.db-char-slot', slotsRoot).forEach((btn) => {
    const idx = Number(btn.getAttribute('data-slot'));
    if (!Number.isFinite(idx)) return;

    const ch = state.slotCharacters[idx];
    btn.replaceChildren();
    btn.classList.remove('is-filled');

    if (!ch) {
      const plus = document.createElement('div');
      plus.className = 'db-slot-empty';
      plus.textContent = '+';
      btn.appendChild(plus);
      return;
    }

    btn.classList.add('is-filled');

    const thumb = document.createElement('div');
    thumb.className = 'db-slot-thumb';
    if (ch.portraitUrl) {
      const img = document.createElement('img');
      img.alt = '';
      img.loading = 'lazy';
      img.decoding = 'async';
      img.src = ch.portraitUrl;
      thumb.appendChild(img);
    } else {
      const ph = document.createElement('div');
      ph.className = 'db-slot-thumb-placeholder';
      ph.textContent = 'IMG';
      thumb.appendChild(ph);
    }

    const name = document.createElement('div');
    name.className = 'db-slot-name';
    name.textContent = ch.name || ch.id || 'Character';

    btn.appendChild(thumb);
    btn.appendChild(name);
  });
}

function renderCharacterList() {
  const root = qs('#character-list');
  if (!root) return;

  root.replaceChildren();

  for (const ch of state.filtered) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'db-card';
    btn.setAttribute('data-action', 'pick-character');
    btn.setAttribute('data-character-id', ch.id);
    btn.setAttribute('data-character-name', ch.name);
    btn.setAttribute('data-portrait-url', ch.portraitUrl || '');

    const imgWrap = document.createElement('div');
    imgWrap.className = 'db-card-media';

    if (ch.portraitUrl) {
      const img = document.createElement('img');
      img.alt = '';
      img.loading = 'lazy';
      img.decoding = 'async';
      img.src = ch.portraitUrl;
      imgWrap.appendChild(img);
    } else {
      const ph = document.createElement('div');
      ph.className = 'db-card-media-placeholder';
      ph.textContent = 'IMG';
      imgWrap.appendChild(ph);
    }

    const title = document.createElement('div');
    title.className = 'db-card-title';
    title.textContent = ch.name || ch.id;

    const sub = document.createElement('div');
    sub.className = 'db-card-sub';
    sub.textContent = ch.factionName || '';

    btn.appendChild(imgWrap);
    btn.appendChild(title);
    btn.appendChild(sub);

    root.appendChild(btn);
  }
}

function applySearch() {
  const input = qs('#character-search');
  const q = byString(input ? input.value : '')
    .trim()
    .toLowerCase();

  if (!q) {
    state.filtered = state.allCharacters;
  } else {
    state.filtered = state.allCharacters.filter((c) => byString(c.name).toLowerCase().includes(q));
  }

  renderCharacterList();
}

function bindUI() {
  // slot click -> open modal
  const slotsRoot = qs('#character-slots');
  if (slotsRoot) {
    slotsRoot.addEventListener('click', (e) => {
      const btn = e.target && e.target.closest('.db-char-slot');
      if (!btn) return;

      const idx = Number(btn.getAttribute('data-slot'));
      if (!Number.isFinite(idx)) return;

      setActiveSlot(idx);
      show(qs('#character-selector-modal'));
    });
  }

  // search
  // search (character)
  const search = qs('#character-search');
  if (search) {
    search.addEventListener('input', () => applySearch());
  }

  // search (skill/cards)
  const skillSearch = qs('#skill-search');
  if (skillSearch) {
    skillSearch.addEventListener('input', () => applySkillSearch());
  }

  // global actions
  document.addEventListener('click', (e) => {
    const t = e.target;
    if (!t) return;

    const actEl = t.closest('[data-action]');
    if (!actEl) return;

    const action = byString(actEl.getAttribute('data-action')).trim();

    if (action === 'close-character-selector') {
      hide(qs('#character-selector-modal'));
      return;
    }

    if (action === 'pick-character') {
      const id = byString(actEl.getAttribute('data-character-id')).trim();
      const name = byString(actEl.getAttribute('data-character-name')).trim();
      const portraitUrl = byString(actEl.getAttribute('data-portrait-url')).trim();
      if (id) {
        state.slotCharacters[state.activeSlot] = { id, name, portraitUrl };
        renderCharacterSlots();
        hide(qs('#character-selector-modal'));

        applySkillSearch(); // ✅ 캐릭터 선택 즉시 덱(=Available) 재생성
      }
      return;
    }

    if (action === 'clear-deck') {
      // Available=Deck이므로 “비우기”가 아니라 “기본 순서로 재생성”
      const input = qs('#skill-search');
      if (input) input.value = '';
      applySkillSearch();
      return;
    }
  });

  // ESC -> close modal
  document.addEventListener('keydown', (e) => {
    if (e.key !== 'Escape') return;
    const modal = qs('#character-selector-modal');
    if (modal && modal.hidden === false) hide(modal);
  });

  // Available Cards에서 드래그 정렬 = 덱 순서 변경
  const availRoot = qs('#available-card-list');
  if (availRoot) {
    let dragKey = '';

    availRoot.addEventListener('dragstart', (e) => {
      const el = e.target && e.target.closest('.db-card');
      if (!el) return;
      dragKey = byString(el.getAttribute('data-deck-key')).trim();
      try {
        e.dataTransfer.setData('text/plain', dragKey);
      } catch {}
    });

    availRoot.addEventListener('dragover', (e) => {
      e.preventDefault();
    });

    availRoot.addEventListener('drop', (e) => {
      e.preventDefault();
      const target = e.target && e.target.closest('.db-card');
      if (!target) return;

      const toKey = byString(target.getAttribute('data-deck-key')).trim();
      if (!dragKey || !toKey || dragKey === toKey) return;

      const fromIdx = state.deckCards.findIndex((x) => x.key === dragKey);
      const toIdx = state.deckCards.findIndex((x) => x.key === toKey);
      if (fromIdx < 0 || toIdx < 0) return;

      const next = state.deckCards.slice();
      const [picked] = next.splice(fromIdx, 1);
      next.splice(toIdx, 0, picked);
      state.deckCards = next;

      // 검색 상태 유지: 표시만 다시 계산
      const input = qs('#skill-search');
      const q = byString(input ? input.value : '')
        .trim()
        .toLowerCase();
      state.filteredCards = q ? state.deckCards.filter((c) => byString(c.name).toLowerCase().includes(q)) : state.deckCards;

      renderAvailableCards();
      renderDeck();

      dragKey = '';
    });

    availRoot.addEventListener('dragend', () => {
      dragKey = '';
    });
  }
}

async function init() {
  const app = qs('#deck-builder');
  if (!app) return;

  setActiveSlot(0);
  renderCharacterSlots();
  bindUI();

  try {
    await loadCharacterData();
    applySearch(); // initial render
  } catch (err) {
    setStatus(byString(err?.message || err), true);
  }

  try {
    await loadCardData();
    applySkillSearch(); // ✅ VM 캐시가 준비되면 현재 선택 캐릭터 기준 덱 생성
  } catch (err) {
    console.error(err);
  }
}

init();

function safeNumber(v) {
  const n = Number(v);
  return Number.isFinite(n) ? n : null;
}

function pickFirstString(...vals) {
  for (const v of vals) {
    const s = byString(v).trim();
    if (s) return s;
  }
  return '';
}

function normalizeIconUrl(rec) {
  // 스키마 미확정 → 후보 키들 중 먼저 잡히는 것 사용
  const raw = pickFirstString(rec?.iconUrl, rec?.IconUrl, rec?.cardIconUrl, rec?.CardIconUrl, rec?.resUrl, rec?.ResUrl);
  const rel = stripExt(raw);
  return rel ? buildAssetImageUrl(rel) : '';
}

async function loadCardData() {
  const [cardRes, skillRes] = await Promise.all([fetch(CARD_VM_URL, { cache: 'force-cache' }), fetch(SKILL_VM_URL, { cache: 'force-cache' })]);

  if (!cardRes.ok) throw new Error(`CardVM fetch failed: ${cardRes.status} ${cardRes.statusText}`);
  if (!skillRes.ok) throw new Error(`SkillVM fetch failed: ${skillRes.status} ${skillRes.statusText}`);

  const cardVm = await cardRes.json();
  const skillVm = await skillRes.json();

  state.cardVm = cardVm;
  state.skillVm = skillVm;
}

function renderAvailableCards() {
  const root = qs('#available-card-list');
  if (!root) return;

  root.replaceChildren();

  if (!state.filteredCards || state.filteredCards.length === 0) {
    const empty = document.createElement('div');
    empty.className = 'muted';
    empty.textContent = '표시할 카드가 없습니다.';
    root.appendChild(empty);
    return;
  }

  for (const c of state.filteredCards) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'db-card';
    btn.draggable = true;

    btn.setAttribute('data-action', 'deck-drag'); // 클릭 동작 없음(정렬용)
    btn.setAttribute('data-deck-key', c.key);

    const media = document.createElement('div');
    media.className = 'db-card-media';

    if (c.iconUrl) {
      const img = document.createElement('img');
      img.alt = '';
      img.loading = 'lazy';
      img.decoding = 'async';
      img.src = c.iconUrl;
      media.appendChild(img);
    }

    const title = document.createElement('div');
    title.className = 'db-card-title';
    title.textContent = c.name || c.id || '(이름 없음)';

    const sub = document.createElement('div');
    sub.className = 'db-card-sub';
    const meta = [];
    if (c.num !== null) meta.push(`수량 ${c.num}`);
    if (c.cost !== null) meta.push(`Cost ${c.cost}`);
    sub.textContent = meta.join(' · ');

    btn.appendChild(media);
    btn.appendChild(title);
    btn.appendChild(sub);

    root.appendChild(btn);
  }
}

function applySkillSearch() {
  const input = qs('#skill-search');
  const q = byString(input ? input.value : '')
    .trim()
    .toLowerCase();

  const unitVm = state.unitVm;
  const skillVm = state.skillVm;
  const cardVm = state.cardVm;

  // VM이 아직 없으면 표시만 비움
  if (!unitVm || !skillVm || !cardVm) {
    state.deckCards = [];
    state.filteredCards = [];
    renderAvailableCards();
    renderDeck();
    return;
  }

  // 1) 선택된 캐릭터들로 덱(Available=Deck) 생성
  const deck = [];
  const seenKey = new Set();

  for (let i = 0; i < state.slotCharacters.length; i++) {
    const ch = state.slotCharacters[i];
    if (!ch || !ch.id) continue;

    const unitRec = unitVm[String(ch.id)] || unitVm[ch.id];
    if (!unitRec) continue;

    const skillList = unitRec.skillList || [];
    for (const s of skillList) {
      const skillId = s?.skillId ?? s?.id ?? s?.skill ?? null;
      if (skillId === null || skillId === undefined) continue;

      const skillRec = skillVm[String(skillId)] || skillVm[skillId];
      if (!skillRec) continue;

      const cardId = skillRec?.cardID ?? skillRec?.cardId ?? skillRec?.card ?? null;
      if (cardId === null || cardId === undefined) continue;

      const cardRec = cardVm[String(cardId)] || cardVm[cardId] || null;

      // 안정 키: 캐릭터+스킬 기준(중복 방지)
      const key = `${ch.id}_${skillId}`;
      if (seenKey.has(key)) continue;
      seenKey.add(key);

      const name = pickFirstString(skillRec?.name, skillRec?.Name, cardRec?.name, cardRec?.Name) || byString(cardId);
      const iconUrl = normalizeIconUrl(skillRec) || normalizeIconUrl(cardRec);

      // 수량/코스트: 원본 키는 VM에 따라 다를 수 있어 후보만 적용(미확정은 null)
      const num = safeNumber(s?.num ?? s?.Num);
      const cost = safeNumber(cardRec?.cost_SN ?? cardRec?.cost ?? cardRec?.Cost);

      deck.push({ key, id: byString(cardId), name, iconUrl, cost, num });
    }
  }

  // 2) 덱 저장 (Available = Deck)
  state.deckCards = deck;

  // 3) 검색은 “표시만” 필터링 (덱 순서는 유지)
  if (!q) {
    state.filteredCards = state.deckCards;
  } else {
    state.filteredCards = state.deckCards.filter((c) => byString(c.name).toLowerCase().includes(q));
  }

  renderAvailableCards();
  renderDeck();
}

function addCardToDeckFromAttrs(attrs) {
  const id = byString(attrs.id).trim();
  if (!id) return;

  const key = `${Date.now()}_${Math.random().toString(16).slice(2)}`;

  state.deckCards.push({
    key,
    id,
    name: byString(attrs.name),
    cost: attrs.cost,
    num: attrs.num,
    iconUrl: byString(attrs.iconUrl)
  });

  renderDeck();
}

function renderDeck() {
  const deck = qs('#selected-deck');
  if (!deck) return;

  deck.replaceChildren();

  for (const c of state.deckCards) {
    const li = document.createElement('li');
    li.className = 'db-deck-item';

    const title = document.createElement('div');
    title.className = 'db-deck-item-title';
    title.textContent = c.name || c.id || 'Card';

    const meta = document.createElement('div');
    meta.className = 'db-deck-item-meta';
    const m = [];
    if (Number.isFinite(c.num)) m.push(`수량 ${c.num}`);
    if (Number.isFinite(c.cost)) m.push(`Cost ${c.cost}`);
    meta.textContent = m.join(' · ');

    li.appendChild(title);
    li.appendChild(meta);
    deck.appendChild(li);
  }
}
