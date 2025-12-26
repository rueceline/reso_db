import { dataPath, assetPath, pagePath, buildAssetImageUrl } from '../utils/path.js';
import { fetchJson, getQueryParam, formatTextWithParamsToHtml } from '../utils/utils.js';
import { qs, setText, clearChildren } from '../utils/dom.js';
import { DEFAULT_LANG } from '../utils/config.js';

// =========================================================
// Character Detail Page Script
// - 실행 흐름: main() → loadDetail() → applyDom()
// - 데이터: UnitVM.json + UnitSkillVM.json 조인
// =========================================================

// -------------------------
// URLs
// -------------------------
const UNIT_VM_URL = dataPath(DEFAULT_LANG, 'UnitVM.json');
const UNIT_SKILL_VM_URL = dataPath(DEFAULT_LANG, 'UnitSkillVM.json');

// -------------------------
// local helpers (characterdb.js 기준)
// -------------------------
function byString(v) {
  return v === null || v === undefined ? '' : String(v);
}

function applyImageFallback(imgEl, text) {
  if (!imgEl) return;

  imgEl.addEventListener('error', () => {
    imgEl.style.display = 'none';

    const fallback = document.createElement('div');
    fallback.className = 'img-fallback-text';
    fallback.textContent = text || '이미지 없음';

    imgEl.parentElement && imgEl.parentElement.appendChild(fallback);
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

function showError(msg) {
  const el = qs('#char-error');
  if (!el) return;

  el.hidden = false;
  el.textContent = String(msg || '오류가 발생했습니다.');
}

function hideError() {
  const el = qs('#char-error');
  if (!el) return;

  el.hidden = true;
  el.textContent = '';
}

function setImg(idSelector, url, pathIdSelector) {
  const img = qs(idSelector);
  if (!img) return;

  const u = String(url || '').trim();
  img.src = u;
  img.hidden = !u;

  if (pathIdSelector) {
    const pathEl = qs(pathIdSelector);
    if (pathEl) {
      pathEl.textContent = u || '';
    }
  }
}

function buildKvRow(label, value) {
  const row = document.createElement('div');
  row.className = 'kv-row';

  const dt = document.createElement('dt');
  dt.textContent = label;

  const dd = document.createElement('dd');
  dd.textContent = value;

  row.appendChild(dt);
  row.appendChild(dd);
  return row;
}

function renderKvGrid(rootId, pairs) {
  const root = qs(rootId);
  if (!root) return;

  clearChildren(root);

  const dl = document.createElement('dl');
  dl.className = 'char-kv';

  for (const p of pairs || []) {
    dl.appendChild(buildKvRow(p.label, p.value));
  }

  root.appendChild(dl);
}

function buildSkillRow(skill, depth = 0) {
  const card = document.createElement('div');
  card.className = 'skill-card';

  const row = document.createElement('div');
  row.className = 'skill-row';

  const body = document.createElement('div');
  body.className = 'skill-body';

  // -------- left --------
  const left = document.createElement('div');
  left.className = 'skill-left';

  const icon = document.createElement('img');
  icon.className = 'skill-icon';
  icon.alt = '';
  icon.loading = 'lazy';
  icon.decoding = 'async';
  icon.src = skill.iconUrl || '';
  icon.hidden = !icon.src;

  const meta = document.createElement('div');
  meta.className = 'skill-meta';

  const num = Number(skill?.num);
  const cost = Number(skill?.cost);

  if (Number.isFinite(num)) {
    const a = document.createElement('div');
    a.className = 'skill-meta-item';
    a.textContent = `수량 ${num}`;
    meta.appendChild(a);
  }

  if (Number.isFinite(cost)) {
    const b = document.createElement('div');
    b.className = 'skill-meta-item is-cost';
    b.textContent = `Cost ${cost}`;
    meta.appendChild(b);
  }

  left.appendChild(icon);
  left.appendChild(meta);

  // -------- right --------
  const right = document.createElement('div');
  right.className = 'skill-right';

  const title = document.createElement('div');
  title.className = 'skill-title';
  title.textContent = skill.name || '(이름 없음)';

  const detail = document.createElement('div');
  detail.className = 'skill-detail muted';

  if (skill.description) {
    const d1 = document.createElement('div');
    d1.className = 'skill-desc';
    d1.innerHTML = formatTextWithParamsToHtml(skill.description);
    detail.appendChild(d1);
  }

  if (skill.detailDescription) {
    const d2 = document.createElement('div');
    d2.className = 'skill-detail-text';
    d2.textContent = skill.detailDescription;
    detail.appendChild(d2);
  }

  right.appendChild(title);
  right.appendChild(detail);

  // main row (left + right)
  const main = document.createElement('div');
  main.className = 'skill-main';

  main.appendChild(left);
  main.appendChild(right);
  body.appendChild(main);

  // sublist는 항상 하단
  if (depth === 0 && Array.isArray(skill.exSkills) && skill.exSkills.length > 0) {
    const sub = document.createElement('div');
    sub.className = 'skill-sublist';

    for (const exSkill of skill.exSkills) {
      sub.appendChild(buildSkillRow(exSkill, depth + 1));
    }

    body.appendChild(sub);
  }

  row.appendChild(body);
  card.appendChild(row);
  return card;
}

// 상세 탭 전환
function bindDetailTabs() {
  const tabs = document.querySelectorAll('.char-tab');
  const panels = document.querySelectorAll('.char-tabpanel');

  if (tabs.length === 0 || panels.length === 0) return;

  tabs.forEach((tab) => {
    tab.addEventListener('click', () => {
      const key = tab.dataset.tab;

      tabs.forEach((t) => t.classList.remove('active'));
      panels.forEach((p) => p.classList.remove('active'));

      tab.classList.add('active');
      document.querySelector(`.char-tabpanel[data-panel="${key}"]`)?.classList.add('active');
    });
  });
}

// -------------------------
// data
// -------------------------
async function loadDetail(unitId) {
  const [unitVm, unitSkillVm] = await Promise.all([fetchJson(UNIT_VM_URL), fetchJson(UNIT_SKILL_VM_URL)]);

  const unitRec = unitVm?.[unitId];
  if (!unitRec) {
    throw new Error(`UnitVM에서 id=${unitId} 레코드를 찾지 못했습니다.`);
  }

  // UnitVM에서 확인 가능한 필드만 사용
  const id = unitRec?.id;
  const name = String(unitRec?.name || '').trim();
  const rarity = String(unitRec?.rarity || '').trim();

  const factionName = String(unitRec?.factionName || '').trim();
  const factionIconName = String(unitRec?.factionIconName || '').trim();

  const line = unitRec?.line;

  const birthday = String(unitRec?.birthday || '').trim();
  const genderRaw = String(unitRec?.gender || '').trim();
  const height = String(unitRec?.height || '').trim();

  const portraitRel = String(unitRec?.portraitRel || '').trim();
  const avatarRel = String(unitRec?.avatarRel || '').trim();

  // 이미지 URL
  const illustrationUrl = portraitRel ? buildAssetImageUrl(portraitRel) : '';
  const sideIconUrl = factionIconName ? buildFactionIconUrl(factionIconName) : '';
  const posIconUrl = buildPosIconUrl(line);

  // 스킬 조인 (UnitVM.skillIds → UnitSkillVM[id])
  const skillIds = Array.isArray(unitRec?.skillIds) ? unitRec.skillIds : [];
  const skills = [];

  for (const it of skillIds) {
    const sid = Number(it?.skillId);
    const num = Number(it?.num);

    if (!Number.isFinite(sid)) continue;

    const s = unitSkillVm?.[String(sid)];
    if (!s) continue;

    const iconRel = String(s?.iconRel || '').trim();
    const exSkillIds = Array.isArray(s?.ExSkillList) ? s.ExSkillList : [];

    const exSkills = [];
    for (const exId of exSkillIds) {
      const exRec = unitSkillVm?.[String(exId)];
      if (!exRec) continue;

      const exIconRel = String(exRec?.iconRel || '').trim();

      exSkills.push({
        id: exRec?.id,
        name: String(exRec?.name || '').trim(),
        iconUrl: exIconRel ? buildAssetImageUrl(exIconRel) : '',
        description: String(exRec?.description || '').trim(),
        detailDescription: String(exRec?.detailDescription || '').trim(),
        cost: exRec?.cost,
        num: undefined, // ExSkillList에는 num 출처 없음
        exSkills: []
      });
    }

    skills.push({
      id: s?.id,
      name: String(s?.name || '').trim(),
      iconUrl: iconRel ? buildAssetImageUrl(iconRel) : '',
      description: String(s?.description || '').trim(),
      detailDescription: String(s?.detailDescription || '').trim(),
      cost: s?.cost,
      num: Number.isFinite(num) ? num : undefined,
      exSkills
    });
  }

  // 변경 후 (return 직전에 talents 생성 + return에 talents 추가)
  const talents = [];
  const rawTalents = Array.isArray(unitRec?.talentIds) ? unitRec.talentIds : [];

  for (const t of rawTalents) {
    const tPathRel = String(t?.path || '').trim();
    const tIconUrl = tPathRel ? buildAssetImageUrl(tPathRel) : '';

    const skillIntensify = Number(t?.skillIntensify);
    const intensifyRec = Number.isFinite(skillIntensify) && skillIntensify > 0 ? unitSkillVm?.[String(skillIntensify)] : null;

    let intensifySkill = null;
    if (intensifyRec) {
      const ir = String(intensifyRec?.iconRel || '').trim();
      intensifySkill = {
        id: intensifyRec?.id,
        name: String(intensifyRec?.name || '').trim(),
        iconUrl: ir ? buildAssetImageUrl(ir) : '',
        description: String(intensifyRec?.description || '').trim(),
        detailDescription: String(intensifyRec?.detailDescription || '').trim(),
        exSkills: [] // 공명 탭 하위항목에서는 추가 전개 없음
      };
    }

    talents.push({
      name: String(t?.name || '').trim(),
      desc: String(t?.desc || '').trim(),
      iconUrl: tIconUrl,
      skillIntensify: Number.isFinite(skillIntensify) ? skillIntensify : undefined,
      intensifySkill
    });
  }

  const awakeListRaw = Array.isArray(unitRec?.awakeList) ? unitRec.awakeList : [];
  const awakeList = [];

  for (const a of awakeListRaw) {
    const name = String(a?.name || a?.title || '').trim();
    const desc = String(a?.desc || a?.des || a?.description || '').trim();
    const detailDescription = String(a?.detailDescription || a?.detail || '').trim();

    const iconRel = String(a?.path || a?.iconRel || a?.icon || '').trim();
    const iconUrl = iconRel ? buildAssetImageUrl(iconRel) : '';

    awakeList.push({
      name,
      desc,
      detailDescription,
      iconUrl
    });
  }

  const homeSkillList = Array.isArray(unitRec?.homeSkillList) ? unitRec.homeSkillList : [];
  const profilePhotoPath = Array.isArray(unitRec?.profilePhotoPath) ? unitRec.profilePhotoPath : [];
  const storyList = Array.isArray(unitRec?.storyList) ? unitRec.storyList : [];

  return {
    id,
    name,
    rarity,
    factionName,
    factionIconName,
    line,
    birthday,
    genderRaw,
    height,

    // 추가
    birthplace: String(unitRec?.birthplace || '').trim(),
    ability: String(unitRec?.ability || '').trim(),
    identity: String(unitRec?.identity || '').trim(),
    resumeList: Array.isArray(unitRec?.resumeList) ? unitRec.resumeList : [],

    portraitRel,
    avatarRel,
    skillIds,

    SkinName: Array.isArray(unitRec?.SkinName) ? unitRec.SkinName : [],
    awakeList,
    illustrationUrl,
    sideIconUrl,
    posIconUrl,
    genderLabel: genderLabel(genderRaw),
    positionLabel: positionLabel(line),

    homeSkillList,
    skills,
    talents,
    profilePhotoPath,
    storyList
  };
}

// -------------------------
// dom apply
// -------------------------
function applyDom(detail) {
  hideError();

  // 기본 텍스트
  setText('char-name', detail.name || '');
  setText('char-name-en', ''); // UnitVM/UnitSkillVM으로 확인 불가

  const rarityEl = qs('#char-rarity');
  if (rarityEl) {
    clearChildren(rarityEl);

    const r = String(detail.rarity || '').trim();
    if (r) {
      const img = document.createElement('img');
      img.alt = r;
      img.src = assetPath(`UI/Common/${r}.png`);
      img.className = 'char-rarity-img';
      rarityEl.appendChild(img);
    }
  }

  // 기본 정보(상단)
  setText('char-birthday', detail.birthday || '미상');
  setText('char-gender', detail.genderLabel || detail.genderRaw || '미상');
  setText('char-height', detail.height || '미상');

  // char-basic2 추가 필드
  setText('char-birthplace', detail.birthplace || '미확정');
  setText('char-ability', detail.ability || '미확정');
  setText('char-identity', detail.identity || '미확정');

  // 경력(resumeList)
  const resumeRoot = qs('#char-resume-list');
  if (resumeRoot) {
    clearChildren(resumeRoot);

    if (!detail.resumeList || detail.resumeList.length === 0) {
      resumeRoot.textContent = '미확정';
    } else {
      for (const r of detail.resumeList) {
        const p = document.createElement('p');
        p.className = 'record-line';
        p.textContent = r.des || '';
        resumeRoot.appendChild(p);
      }
    }
  }

  // 아이콘/이미지 + 경로 표시
  setImg('#char-illustration', detail.illustrationUrl, '#char-illustration-path');
  setImg('#char-side-icon', detail.sideIconUrl, '#char-side-icon-path');
  setImg('#char-pos-icon', detail.posIconUrl, '#char-pos-icon-path');

  // 스킨 카드 생성 (카드 형태, 이미지 교체 없음)
  const skinCardRoot = qs('#char-skin-cards');

  // 모달
  const skinModal = qs('#skin-modal');
  const skinModalImg = qs('#skin-modal-img');
  const skinModalTitle = qs('#skin-modal-title');

  function openSkinModal(title, imgUrl) {
    if (!skinModal || !skinModalImg) return;
    skinModalImg.src = imgUrl || '';
    skinModalImg.alt = title || '';
    if (skinModalTitle) skinModalTitle.textContent = title || '';
    skinModal.hidden = false;
  }

  function closeSkinModal() {
    if (!skinModal) return;
    skinModal.hidden = true;
    if (skinModalImg) skinModalImg.src = '';
    if (skinModalTitle) skinModalTitle.textContent = '';
  }

  if (skinModal) {
    skinModal.querySelectorAll('[data-close="1"]').forEach((el) => {
      el.addEventListener('click', () => closeSkinModal());
    });
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') closeSkinModal();
    });
  }

  if (skinCardRoot) {
    clearChildren(skinCardRoot);

    const cards = [];
    const usedNames = new Set();

    // 스킨 (파일명 유지)
    for (const rec of detail.SkinName || []) {
      const [name, path] = Object.entries(rec)[0] || [];
      if (!name || !path) continue;
      cards.push({ name, path });
    }

    // 중복 name 제거 + 카드 생성
    for (const skin of cards) {
      if (usedNames.has(skin.name)) continue;
      usedNames.add(skin.name);

      const card = document.createElement('button');
      card.type = 'button';
      card.className = 'skin-card';
      card.setAttribute('aria-label', `${skin.name} 이미지 보기`);

      const media = document.createElement('div');
      media.className = 'skin-card-media';

      const imgUrl = buildAssetImageUrl(skin.path);

      const img = document.createElement('img');
      img.src = imgUrl;
      img.alt = skin.name;
      img.loading = 'lazy';

      const cap = document.createElement('div');
      cap.className = 'skin-card-title';
      cap.textContent = skin.name;

      media.appendChild(img);
      card.appendChild(media);
      card.appendChild(cap);

      card.addEventListener('click', () => {
        openSkinModal(skin.name, imgUrl);
      });

      skinCardRoot.appendChild(card);
    }
  }

  // 이미지 fallback
  applyImageFallback(qs('#char-illustration'), detail.name);

  const propRoot = qs('#char-property');
  if (propRoot) {
    clearChildren(propRoot);

    const card = document.createElement('div');
    card.className = 'property-card';

    const title = document.createElement('div');
    title.className = 'property-sub-title';
    title.textContent = '속성(growthId 미적용)';

    const levelRow = document.createElement('div');
    levelRow.className = 'level-row';

    const levelLabel = document.createElement('div');
    levelLabel.textContent = 'Lv. 1';

    const slider = document.createElement('input');
    slider.type = 'range';
    slider.min = '1';
    slider.max = '80';
    slider.value = '1';

    const statBox = document.createElement('div');
    statBox.className = 'stat-box stat-big';

    const hpCard = document.createElement('div');
    hpCard.className = 'stat-card';

    const atkCard = document.createElement('div');
    atkCard.className = 'stat-card';

    const defCard = document.createElement('div');
    defCard.className = 'stat-card';

    const hpLabel = document.createElement('div');
    hpLabel.className = 'stat-label';
    hpLabel.textContent = '체력';

    const atkLabel = document.createElement('div');
    atkLabel.className = 'stat-label';
    atkLabel.textContent = '공격력';

    const defLabel = document.createElement('div');
    defLabel.className = 'stat-label';
    defLabel.textContent = '방어력';

    const hpVal = document.createElement('div');
    hpVal.className = 'stat-value';

    const atkVal = document.createElement('div');
    atkVal.className = 'stat-value';

    const defVal = document.createElement('div');
    defVal.className = 'stat-value';

    hpCard.appendChild(hpLabel);
    hpCard.appendChild(hpVal);

    atkCard.appendChild(atkLabel);
    atkCard.appendChild(atkVal);

    defCard.appendChild(defLabel);
    defCard.appendChild(defVal);

    function updateStat(lv) {
      levelLabel.textContent = `Lv. ${lv}`;
      hpVal.textContent = String(100 + lv * 20);
      atkVal.textContent = String(10 + lv * 5);
      defVal.textContent = String(8 + lv * 4);
    }

    slider.addEventListener('input', () => updateStat(Number(slider.value)));

    updateStat(1);

    levelRow.appendChild(levelLabel);
    levelRow.appendChild(slider);

    statBox.appendChild(hpCard);
    statBox.appendChild(atkCard);
    statBox.appendChild(defCard);

    card.appendChild(title);
    card.appendChild(levelRow);
    card.appendChild(statBox);

    propRoot.appendChild(card);
  }

  // photo
  const photoRoot = qs('#char-photo-grid');
  if (photoRoot) {
    clearChildren(photoRoot);

    // title + grid wrapper 추가 (2x2 grid 깨짐 방지)
    const wrap = document.createElement('div');
    wrap.className = 'photo-card';

    const h = document.createElement('div');
    h.className = 'property-sub-title';
    h.textContent = 'Photo Sticker';

    const grid = document.createElement('div');
    grid.className = 'photo-grid-inner';

    const list = Array.isArray(detail.profilePhotoPath) ? detail.profilePhotoPath : [];

    for (const rel of list.slice(0, 4)) {
      const img = document.createElement('img');
      img.loading = 'lazy';
      img.decoding = 'async';
      img.alt = '';
      img.src = buildAssetImageUrl(rel);
      grid.appendChild(img);
    }

    if (list.length === 0) {
      const empty = document.createElement('div');
      empty.className = 'muted';
      empty.textContent = '표시할 photo가 없습니다.';
      grid.appendChild(empty);
    }

    wrap.appendChild(h);
    wrap.appendChild(grid);
    photoRoot.appendChild(wrap);
  }

  // record (storyList)
  const recordRoot = qs('#char-record');
  if (recordRoot) {
    clearChildren(recordRoot);

    const wrap = document.createElement('div');
    wrap.className = 'record-card';

    const h = document.createElement('div');
    h.className = 'property-sub-title';
    h.textContent = '기록';

    const body = document.createElement('div');
    body.className = 'record-card-body';

    const list = Array.isArray(detail.storyList) ? detail.storyList : [];

    if (list.length === 0) {
      const empty = document.createElement('div');
      empty.className = 'muted';
      empty.textContent = '미확정';
      body.appendChild(empty);
    } else {
      for (const s of list) {
        const item = document.createElement('div');
        item.className = 'record-item is-collapsed'; // 기본 접기

        const title = document.createElement('div');
        title.className = 'record-title';
        if (s?.Title) {
          title.textContent = s.Title;
          title.classList.add('record-title-normal');
        } else {
          title.textContent = '기록';
          title.classList.add('record-title-default');
        }

        const bodyWrap = document.createElement('div');
        bodyWrap.className = 'record-body';

        if (s?.des) {
          const desc = document.createElement('div');
          desc.className = 'record-line';
          desc.innerHTML = formatTextWithParamsToHtml(s.des);
          bodyWrap.appendChild(desc);
        }

        title.addEventListener('click', () => {
          const open = item.classList.toggle('is-open');
          item.classList.toggle('is-collapsed', !open);
        });

        item.appendChild(title);
        item.appendChild(bodyWrap);
        body.appendChild(item);
      }
    }

    wrap.appendChild(h);
    wrap.appendChild(body);
    recordRoot.appendChild(wrap);
  }

  // bento (temporary)
  const bentoRoot = qs('#char-bento');
  if (bentoRoot) {
    clearChildren(bentoRoot);

    const card = document.createElement('div');
    card.className = 'bento-card';

    const txt = document.createElement('div');
    txt.className = 'muted';
    txt.textContent = 'bento image';

    card.appendChild(txt);
    bentoRoot.appendChild(card);
  }

  // 技能 (Skill)
  const skillRoot = qs('#char-skill-list');
  if (skillRoot) {
    clearChildren(skillRoot);

    if (!detail.skills || detail.skills.length === 0) {
      const empty = document.createElement('div');
      empty.className = 'muted';
      empty.textContent = '표시할 스킬이 없습니다.';
      skillRoot.appendChild(empty);
    } else {
      for (const s of detail.skills) {
        skillRoot.appendChild(buildSkillRow(s));
      }
    }
  }  
  
  // 공명 (Resonance)
  const resRoot = qs('#char-resonance');
  if (resRoot) {
    clearChildren(resRoot);

    const list = Array.isArray(detail.talents) ? detail.talents : [];
    if (list.length === 0) {
      const empty = document.createElement('div');
      empty.className = 'muted';
      empty.textContent = '표시할 공명이 없습니다.';
      resRoot.appendChild(empty);
    } else {
      const wrap = document.createElement('div');
      wrap.className = 'resonance-list';

      for (const [idx, t] of list.entries()) {
        const card = document.createElement('div');
        card.className = 'skill-card resonance-card';

        const row = document.createElement('div');
        row.className = 'skill-row';

        const body = document.createElement('div');
        body.className = 'skill-body';

        // main = (left + right)  ← skill 탭과 동일
        const main = document.createElement('div');
        main.className = 'skill-main';

        // -------- left --------
        const left = document.createElement('div');
        left.className = 'skill-left';

        const icon = document.createElement('img');
        icon.className = 'skill-icon';
        icon.alt = '';
        icon.loading = 'lazy';
        icon.decoding = 'async';
        icon.src = t.iconUrl || '';
        icon.hidden = !icon.src;

        left.appendChild(icon);

        // -------- right --------
        const right = document.createElement('div');
        right.className = 'skill-right';

        const title = document.createElement('div');
        title.className = 'skill-title';
        title.textContent = t.name || '(이름 없음)';

        const detailBox = document.createElement('div');
        detailBox.className = 'skill-detail muted';
        
        // Resonance index(t) === homeSkillList.resonanceLv - 1 인 경우 desc 추가
        if (t.desc) {
          const d1 = document.createElement('div');
          d1.className = 'skill-desc';
          d1.innerHTML = formatTextWithParamsToHtml(t.desc);
          detailBox.appendChild(d1);
        }

        // ⬇ homeSkillList 연동
        const hsList = Array.isArray(detail.homeSkillList) ? detail.homeSkillList : [];
        const skillIndex = idx; // for (const [idx, t] of list.entries())

        for (const hs of hsList) {
          const lv = Number(hs?.resonanceLv);
          if (Number.isFinite(lv) && lv - 1 === skillIndex && hs?.desc) {
            // [변경 후] (name + desc 출력, name은 굵게)
            const hsd = document.createElement('div');
            hsd.className = 'skill-desc home-skill-desc';

            // name: 굵게, desc: 일반
            const nameEl = document.createElement('span');
            nameEl.className = 'home-skill-name';
            nameEl.textContent = hs.name || '';

            const descEl = document.createElement('span');
            descEl.className = 'home-skill-text';
            descEl.innerHTML = hs.desc ? `: ${formatTextWithParamsToHtml(hs.desc)}` : '';

            hsd.appendChild(nameEl);
            hsd.appendChild(descEl);
            detailBox.appendChild(hsd);
          }
        }

        right.appendChild(title);
        right.appendChild(detailBox);

        main.appendChild(left);
        main.appendChild(right);
        body.appendChild(main);

        // skillIntensify: 하위항목은 skill 탭과 동일하게 "main 아래" 배치
        if (t.intensifySkill) {
          const sub = document.createElement('div');
          sub.className = 'skill-sublist';
          sub.appendChild(buildSkillRow(t.intensifySkill, 1)); // depth=1 => 하위 스킬 전개 없음
          body.appendChild(sub);
        }

        row.appendChild(body);
        card.appendChild(row);
        wrap.appendChild(card);
      }

      resRoot.appendChild(wrap);
    }
  }

  // 각성 (Awake) - skill/resonance와 동일한 카드 구조 사용
  const awakeRoot = qs('#char-awake');
  if (awakeRoot) {
    clearChildren(awakeRoot);
    awakeRoot.classList.remove('muted');

    const list = Array.isArray(detail.awakeList) ? detail.awakeList : [];
    if (list.length === 0) {
      const empty = document.createElement('div');
      empty.className = 'muted';
      empty.textContent = '표시할 각성이 없습니다.';
      awakeRoot.appendChild(empty);
    } else {
      const wrap = document.createElement('div');
      wrap.className = 'resonance-list';

      for (const a of list) {
        // 비어있는 각성 데이터 skip
        if (!a || (!a.name && !a.desc && !a.detailDescription && !a.iconUrl)) {
          continue;
        }

        const card = document.createElement('div');
        card.className = 'skill-card';

        const row = document.createElement('div');
        row.className = 'skill-row';

        const body = document.createElement('div');
        body.className = 'skill-body';

        const main = document.createElement('div');
        main.className = 'skill-main';

        // left
        const left = document.createElement('div');
        left.className = 'skill-left';

        // [변경 후]
        const maskUrl = buildAssetImageUrl('UI/Common/Mask');

        // mask 배경 + 아이콘 합성 컨테이너
        const iconWrap = document.createElement('div');
        iconWrap.style.width = '128px';
        iconWrap.style.height = '128px';
        iconWrap.style.borderRadius = '12px';
        iconWrap.style.position = 'relative';
        iconWrap.style.overflow = 'hidden';
        iconWrap.style.backgroundImage = `url(${maskUrl})`;
        iconWrap.style.backgroundRepeat = 'no-repeat';
        iconWrap.style.backgroundPosition = 'center';
        iconWrap.style.backgroundSize = 'contain';

        const icon = document.createElement('img');
        icon.className = 'skill-icon';
        icon.alt = '';
        icon.loading = 'lazy';
        icon.decoding = 'async';
        icon.src = a.iconUrl || '';
        icon.hidden = !icon.src;

        // .skill-icon의 기본 크기(128x128)를 “오버레이 용도”로 강제
        icon.style.position = 'absolute';
        icon.style.inset = '0';
        icon.style.width = '100%';
        icon.style.height = '100%';
        icon.style.objectFit = 'contain';

        iconWrap.appendChild(icon);
        left.appendChild(iconWrap);

        // right
        const right = document.createElement('div');
        right.className = 'skill-right';

        const title = document.createElement('div');
        title.className = 'skill-title';
        title.textContent = a.name || '(이름 없음)';

        const detailBox = document.createElement('div');
        detailBox.className = 'skill-detail muted';

        if (a.desc) {
          const d1 = document.createElement('div');
          d1.className = 'skill-desc';
          d1.innerHTML = formatTextWithParamsToHtml(a.desc);
          detailBox.appendChild(d1);
        }

        if (a.detailDescription) {
          const d2 = document.createElement('div');
          d2.className = 'skill-detail-text';
          d2.textContent = a.detailDescription;
          detailBox.appendChild(d2);
        }

        right.appendChild(title);
        right.appendChild(detailBox);

        main.appendChild(left);
        main.appendChild(right);
        body.appendChild(main);

        row.appendChild(body);
        card.appendChild(row);
        wrap.appendChild(card);
      }

      awakeRoot.appendChild(wrap);
    }
  }
}

// -------------------------
// main
// -------------------------
async function main() {
  try {
    const unitIdRaw = getQueryParam('id');
    const unitId = Number(unitIdRaw);

    if (!Number.isFinite(unitId)) {
      throw new Error(`쿼리스트링 id가 없습니다. 예: ${pagePath('character_detail.html')}?id=10000004`);
    }

    const detail = await loadDetail(unitId);
    applyDom(detail);
  } catch (e) {
    console.error(e);
    showError(String(e?.message || e));
  }
}

document.addEventListener('DOMContentLoaded', () => {
  main();
  bindDetailTabs();
});
