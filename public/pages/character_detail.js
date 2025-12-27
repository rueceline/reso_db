import { dataPath, assetPath, pagePath, buildAssetImageUrl } from '../utils/path.js';
import { getQueryParam, formatTextWithParamsToHtml } from '../utils/utils.js';
import { qs, setText, clearChildren } from '../utils/dom.js';
import { DEFAULT_LANG, FETCH_CACHE_MODE } from '../utils/config.js';

// =========================================================
// Character Detail Page Script
// - 실행 흐름: main() → loadDetail() → applyDom()
// - 데이터: UnitVM.json + UnitSkillVM.json 조인
// =========================================================

// -------------------------
// URLs
// -------------------------
const UNIT_VM_URL = dataPath(DEFAULT_LANG, 'UnitVM.json');
const UNIT_VIEW_VM_URL = dataPath(DEFAULT_LANG, 'UnitViewVM.json');
const TAG_VM_URL = dataPath(DEFAULT_LANG, 'TagVM.json');
const SKILL_VM_URL = dataPath(DEFAULT_LANG, 'SkillVM.json');

const CARD_VM_URL = dataPath(DEFAULT_LANG, 'CardVM.json');
const TALENT_VM_URL = dataPath(DEFAULT_LANG, 'TalentVM.json');
const PROFILE_PHOTO_VM_URL = dataPath(DEFAULT_LANG, 'ProfilePhotoVM.json');
const LIST_VM_URL = dataPath(DEFAULT_LANG, 'ListVM.json');
const HOME_SKILL_VM_URL = dataPath(DEFAULT_LANG, 'HomeSkillVM.json');
const BREAKTHROUGH_VM_URL = dataPath(DEFAULT_LANG, 'BreakthroughVM.json');

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
  // 1 = Front  (UI/Common/row/RowFront)
  // 2 = Middle (UI/Common/row/RowMiddleg)
  // 3 = Back   (UI/Common/row/RowBack)
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
// [변경 후] loadDetail() 첫 부분 (character_detail.js) :contentReference[oaicite:4]{index=4}
// [변경 후] loadDetail 함수 전체 (character_detail.js)
async function loadDetail(unitId) {
  // [변경 후] (character_detail.js) loadDetail() fetch/parse 구간
  // [변경 후]
  const [unitRes, viewRes, tagRes, skillRes, cardRes, talentRes, photoRes, listRes, homeSkillRes, breakthroughRes] =
    await Promise.all([
      fetch(UNIT_VM_URL, { cache: FETCH_CACHE_MODE }),
      fetch(UNIT_VIEW_VM_URL, { cache: FETCH_CACHE_MODE }),
      fetch(TAG_VM_URL, { cache: FETCH_CACHE_MODE }),
      fetch(SKILL_VM_URL, { cache: FETCH_CACHE_MODE }),
      fetch(CARD_VM_URL, { cache: FETCH_CACHE_MODE }),
      fetch(TALENT_VM_URL, { cache: FETCH_CACHE_MODE }),
      fetch(PROFILE_PHOTO_VM_URL, { cache: FETCH_CACHE_MODE }),
      fetch(LIST_VM_URL, { cache: FETCH_CACHE_MODE }),
      fetch(HOME_SKILL_VM_URL, { cache: FETCH_CACHE_MODE }),
      fetch(BREAKTHROUGH_VM_URL, { cache: FETCH_CACHE_MODE })
    ]);

  if (!unitRes.ok) throw new Error(`UnitVM fetch failed: ${unitRes.status} ${unitRes.statusText}`);
  if (!viewRes.ok) throw new Error(`UnitViewVM fetch failed: ${viewRes.status} ${viewRes.statusText}`);
  if (!tagRes.ok) throw new Error(`TagVM fetch failed: ${tagRes.status} ${tagRes.statusText}`);
  if (!skillRes.ok) throw new Error(`SkillVM fetch failed: ${skillRes.status} ${skillRes.statusText}`);

  if (!cardRes.ok) throw new Error(`CardVM fetch failed: ${cardRes.status} ${cardRes.statusText}`);
  if (!talentRes.ok) throw new Error(`TalentVM fetch failed: ${talentRes.status} ${talentRes.statusText}`);
  if (!photoRes.ok) throw new Error(`ProfilePhotoVM fetch failed: ${photoRes.status} ${photoRes.statusText}`);
  if (!listRes.ok) throw new Error(`ListVM fetch failed: ${listRes.status} ${listRes.statusText}`);
  if (!homeSkillRes.ok) throw new Error(`HomeSkillVM fetch failed: ${homeSkillRes.status} ${homeSkillRes.statusText}`);
  if (!breakthroughRes.ok) throw new Error(`BreakthroughVM fetch failed: ${breakthroughRes.status} ${breakthroughRes.statusText}`);

  const unitVm = await unitRes.json();
  const viewVm = await viewRes.json();
  const tagVm = await tagRes.json();
  const skillVm = await skillRes.json();

  const cardVm = await cardRes.json();
  const talentVm = await talentRes.json();
  const photoVm = await photoRes.json();
  const listVm = await listRes.json();
  const homeSkillVm = await homeSkillRes.json();
  const breakthroughVm = await breakthroughRes.json();

  const unitRec = unitVm?.[unitId];
  if (!unitRec) {
    throw new Error(`UnitVM에서 id=${unitId} 레코드를 찾지 못했습니다.`);
  }

  // tagById (sideId 조인)
  // [변경 후] (character_detail.js) 조인용 *ById 맵들 생성
  const tagById = new Map();
  if (tagVm && typeof tagVm === 'object') {
    for (const key of Object.keys(tagVm)) {
      const rec = tagVm[key];
      const idNum = Number(rec?.id ?? key);
      if (Number.isFinite(idNum)) tagById.set(idNum, rec);
    }
  }

  const cardById = new Map();
  if (cardVm && typeof cardVm === 'object') {
    for (const key of Object.keys(cardVm)) {
      const rec = cardVm[key];
      const idNum = Number(rec?.id ?? key);
      if (Number.isFinite(idNum)) cardById.set(idNum, rec);
    }
  }

  const talentById = new Map();
  if (talentVm && typeof talentVm === 'object') {
    for (const key of Object.keys(talentVm)) {
      const rec = talentVm[key];
      const idNum = Number(rec?.id ?? key);
      if (Number.isFinite(idNum)) talentById.set(idNum, rec);
    }
  }

  const photoById = new Map();
  if (photoVm && typeof photoVm === 'object') {
    for (const key of Object.keys(photoVm)) {
      const rec = photoVm[key];
      const idNum = Number(rec?.id ?? key);
      if (Number.isFinite(idNum)) photoById.set(idNum, rec);
    }
  }

  const listById = new Map();
  if (listVm && typeof listVm === 'object') {
    for (const key of Object.keys(listVm)) {
      const rec = listVm[key];
      const idNum = Number(rec?.id ?? key);
      if (Number.isFinite(idNum)) listById.set(idNum, rec);
    }
  }

  // [추가] breakthroughById
  const breakthroughById = new Map();
  if (breakthroughVm && typeof breakthroughVm === 'object') {
    for (const key of Object.keys(breakthroughVm)) {
      const rec = breakthroughVm[key];
      const idNum = Number(rec?.id ?? key);
      if (Number.isFinite(idNum)) breakthroughById.set(idNum, rec);
    }
  }

  const homeSkillById = new Map();
  if (homeSkillVm && typeof homeSkillVm === 'object') {
    for (const key of Object.keys(homeSkillVm)) {
      const rec = homeSkillVm[key];
      const idNum = Number(rec?.id ?? key);
      if (Number.isFinite(idNum)) homeSkillById.set(idNum, rec);
    }
  }

  // characterId -> "기본" viewRec (unit.viewId 단일 사용 조건)
  const basicViewByCharId = {};
  if (viewVm && typeof viewVm === 'object') {
    for (const key of Object.keys(viewVm)) {
      const v = viewVm[key];
      if (!v) continue;
      if (String(v.SkinName || '').trim() !== '기본') continue;

      const cid = Number(v.character);
      if (!Number.isFinite(cid)) continue;

      if (basicViewByCharId[cid] === undefined) basicViewByCharId[cid] = v;
    }
  }

  // UnitVM에서 확인 가능한 필드만 사용
  const id = unitRec?.id;
  const name = String(unitRec?.name || '').trim();

  // rarity (UnitVM.quality -> rarity)
  const qualityRaw = String(unitRec?.quality || '').trim();
  const qualityKey = qualityRaw.toLowerCase();
  let rarity = '-';
  if (qualityKey === 'fivestar') rarity = 'SSR';
  else if (qualityKey === 'fourstar') rarity = 'SR';
  else if (qualityKey === 'threestar') rarity = 'R';
  else if (qualityKey === 'twostar' || qualityKey === 'onestar') rarity = 'N';

  // faction (sideId -> TagVM.sideName/icon)
  const sideId = Number(unitRec?.sideId);
  const tagRec = Number.isFinite(sideId) ? tagById.get(sideId) || null : null;

  const factionName = String(tagRec?.sideName || '').trim();

  let factionIconName = '';
  if (tagRec) {
    const v1 = tagRec.icon;
    const v2 = tagRec.Icon;
    const s1 = v1 === null || v1 === undefined ? '' : String(v1).trim();
    const s2 = v2 === null || v2 === undefined ? '' : String(v2).trim();
    factionIconName = s1 || s2 || '';
  }

  const line = unitRec?.line;

  const birthday = String(unitRec?.birthday || '').trim();
  const genderRaw = String(unitRec?.gender || '').trim();
  const height = String(unitRec?.height || '').trim();

  const avatarRel = String(unitRec?.avatarRel || '').trim();

  // view join: unit.viewId 단일 사용 + "기본" 우선
  const viewId = Number(unitRec?.viewId);
  let viewRec = Number.isFinite(viewId) && viewVm ? viewVm[String(viewId)] || viewVm[viewId] || null : null;

  if (!viewRec || String(viewRec.SkinName || '').trim() !== '기본') {
    const cid = Number(unitRec?.id);
    viewRec = Number.isFinite(cid) && basicViewByCharId[cid] ? basicViewByCharId[cid] : viewRec;
  }

  // portraitRel: roleListResUrl > squadsHalf1 > squadsHalf2 > bookHalf
  let portraitSrc = '';
  if (viewRec) {
    const a = String(viewRec?.roleListResUrl ?? '').trim();
    const b = String(viewRec?.squadsHalf1 ?? '').trim();
    const c = String(viewRec?.squadsHalf2 ?? '').trim();
    const d = String(viewRec?.bookHalf ?? '').trim();
    portraitSrc = a || b || c || d || '';
  }

  const portraitRel = String(portraitSrc || '')
    .trim()
    .replace(/\\/g, '/')
    .replace(/^\/+/g, '')
    .replace(/\.(png|webp|jpg|jpeg)$/i, '');

  // 이미지 URL
  const illustrationUrl = portraitRel ? buildAssetImageUrl(portraitRel) : '';
  const sideIconUrl = factionIconName ? buildFactionIconUrl(factionIconName) : '';
  const posIconUrl = buildPosIconUrl(line);

  // 스킬 조인 (UnitVM.skillList → SkillVM[id])  (unit_skill_vm.js 조인 방식 1-depth)
  // [변경 후] (character_detail.js) 스킬 조인 (unit_skill_vm.js 방식: cardID->CardVM.cost_SN, ExSkillList 1-depth)
  const skillIds = Array.isArray(unitRec?.skillList) ? unitRec.skillList : [];
  const skills = [];

  for (const it of skillIds) {
    const sid = Number(it?.skillId);
    const num = Number(it?.num);

    if (!Number.isFinite(sid)) continue;

    const s = skillVm?.[String(sid)];
    if (!s) continue;

    const iconRel = String(s?.iconRel || s?.iconPath || s?.IconPath || s?.icon || s?.Icon || '').trim();

    const cardID = Number(s?.cardID);
    const cardRec = Number.isFinite(cardID) ? cardById.get(cardID) || null : null;
    const cost = cardRec && Number.isFinite(Number(cardRec?.cost_SN)) ? Number(cardRec.cost_SN) / 10000 : undefined;

    const exListRaw = Array.isArray(s?.ExSkillList) ? s.ExSkillList : [];
    const exSkillIds = [];

    for (const ex of exListRaw) {
      const exId = typeof ex === 'number' ? Number(ex) : Number(ex?.ExSkillName ?? ex?.id ?? ex);
      if (Number.isFinite(exId)) exSkillIds.push(exId);
    }

    const exSkills = [];
    for (const exId of exSkillIds) {
      const exRec = skillVm?.[String(exId)];
      if (!exRec) continue;

      const exIconRel = String(exRec?.iconRel || exRec?.iconPath || exRec?.IconPath || exRec?.icon || exRec?.Icon || '').trim();

      const exCardID = Number(exRec?.cardID);
      const exCardRec = Number.isFinite(exCardID) ? cardById.get(exCardID) || null : null;
      const exCost = exCardRec && Number.isFinite(Number(exCardRec?.cost_SN)) ? Number(exCardRec.cost_SN) / 10000 : undefined;

      exSkills.push({
        id: exRec?.id,
        name: String(exRec?.name || exRec?.Name || '').trim(),
        iconUrl: exIconRel
          ? buildAssetImageUrl(
              exIconRel
                .replace(/\\/g, '/')
                .replace(/^\/+/g, '')
                .replace(/\.(png|webp|jpg|jpeg)$/i, '')
            )
          : '',
        description: String(exRec?.description || exRec?.Description || exRec?.des || exRec?.Des || '').trim(),
        detailDescription: String(exRec?.detailDescription || exRec?.DetailDescription || exRec?.detailDes || exRec?.DetailDes || '').trim(),
        cost: exCost,
        num: undefined,
        exSkills: []
      });
    }

    skills.push({
      id: s?.id,
      name: String(s?.name || s?.Name || '').trim(),
      iconUrl: iconRel
        ? buildAssetImageUrl(
            iconRel
              .replace(/\\/g, '/')
              .replace(/^\/+/g, '')
              .replace(/\.(png|webp|jpg|jpeg)$/i, '')
          )
        : '',
      description: String(s?.description || s?.Description || s?.des || s?.Des || '').trim(),
      detailDescription: String(s?.detailDescription || s?.DetailDescription || s?.detailDes || s?.DetailDes || '').trim(),
      cost,
      num: Number.isFinite(num) ? num : undefined,
      exSkills
    });
  }

  // talents (기존 구조 유지: unitRec.talentIds가 없으면 빈 배열)
  // [변경 후] (character_detail.js) talents: UnitVM.talentList[].talentId -> TalentVM 조인 (unit_vm.js 방식)
  const talents = [];
  const rawTalentList = Array.isArray(unitRec?.talentList) ? unitRec.talentList : [];

  for (const t of rawTalentList) {
    const tid = Number(t?.talentId);
    if (!Number.isFinite(tid) || tid <= 0) continue;

    const trec = talentById.get(tid);
    if (!trec) continue;

    const name = String(trec?.name || trec?.Name || '').trim();
    const desc = String(trec?.desc || trec?.Desc || trec?.description || trec?.Description || '').trim();

    const pathRaw = String(trec?.path || trec?.Path || '').trim();
    const pathRel = pathRaw
      ? pathRaw
          .replace(/\\/g, '/')
          .replace(/^\/+/g, '')
          .replace(/\.(png|webp|jpg|jpeg)$/i, '')
      : '';

    const tIconUrl = pathRel ? buildAssetImageUrl(pathRel) : '';

    const skillIntensify = Number(trec?.skillIntensify);
    const intensifyRec = Number.isFinite(skillIntensify) && skillIntensify > 0 ? skillVm?.[String(skillIntensify)] : null;

    let intensifySkill = null;
    if (intensifyRec) {
      const ir = String(intensifyRec?.iconRel || intensifyRec?.iconPath || intensifyRec?.IconPath || intensifyRec?.icon || intensifyRec?.Icon || '').trim();
      intensifySkill = {
        id: intensifyRec?.id,
        name: String(intensifyRec?.name || intensifyRec?.Name || '').trim(),
        iconUrl: ir
          ? buildAssetImageUrl(
              ir
                .replace(/\\/g, '/')
                .replace(/^\/+/g, '')
                .replace(/\.(png|webp|jpg|jpeg)$/i, '')
            )
          : '',
        description: String(intensifyRec?.description || intensifyRec?.Description || intensifyRec?.des || intensifyRec?.Des || '').trim(),
        detailDescription: String(intensifyRec?.detailDescription || intensifyRec?.DetailDescription || intensifyRec?.detailDes || intensifyRec?.DetailDes || '').trim(),
        exSkills: []
      };
    }

    talents.push({
      name,
      desc,
      iconUrl: tIconUrl,
      skillIntensify: Number.isFinite(skillIntensify) ? skillIntensify : undefined,
      intensifySkill
    });
  }

  // awakeList (UnitVM.breakthroughList -> BreakthroughVM 조인)
  const awakeList = [];
  const rawBreakthroughList = Array.isArray(unitRec?.breakthroughList)
    ? unitRec.breakthroughList
    : [];

  for (const b of rawBreakthroughList) {
    const bid = Number(b?.breakthroughId);
    if (!Number.isFinite(bid) || bid <= 0) continue;

    const brec = breakthroughById.get(bid);
    if (!brec) continue;

    const name = String(brec?.name || brec?.Name || '').trim();
    const desc = String(brec?.desc || brec?.Desc || '').trim();
    const detailDescription = String(
      brec?.detailDescription || brec?.DetailDescription || ''
    ).trim();

    const iconRaw = String(brec?.path).trim();

    const iconRel = iconRaw
      ? iconRaw
          .replace(/\\/g, '/')
          .replace(/^\/+/g, '')
          .replace(/\.(png|webp|jpg|jpeg)$/i, '')
      : '';

    const iconUrl = iconRel ? buildAssetImageUrl(iconRel) : '';

    if (name || desc || detailDescription || iconUrl) {
      awakeList.push({
        name,
        desc,
        detailDescription,
        iconUrl
      });
    }
  }


  // profilePhotoPath (UnitFactory.ProfilePhotoList[].id -> ProfilePhotoVM.imagePath)
  const profilePhotoPath = [];
  if (Array.isArray(unitRec?.ProfilePhotoList)) {
    for (const p of unitRec.ProfilePhotoList) {
      const pid = Number(p?.id);
      if (!Number.isFinite(pid) || pid <= 0) continue;

      const photoRec = photoById.get(pid);
      if (!photoRec) continue;

      const imgPathRaw = String(photoRec?.imagePath || photoRec?.ImagePath || '').trim();
      if (!imgPathRaw) continue;

      const rel = imgPathRaw
        .replace(/\\/g, '/')
        .replace(/^\/+/g, '')
        .replace(/\.(png|webp|jpg|jpeg)$/i, '');
      if (rel) profilePhotoPath.push(rel);
    }
  }

  // storyList (UnitFactory.fileList[].file -> ListVM.id -> StoryList[])
  const storyList = [];
  const fileList = Array.isArray(unitRec?.fileList) ? unitRec.fileList : [];
  const seenTitle = new Set();
  const seenFileId = new Set();

  for (const f of fileList) {
    const fileId = Number(f?.file);
    if (!Number.isFinite(fileId) || fileId <= 0) continue;

    if (seenFileId.has(fileId)) continue;
    seenFileId.add(fileId);

    const listRec = listById.get(fileId);
    if (!listRec) continue;

    const rawStoryList = Array.isArray(listRec?.StoryList) ? listRec.StoryList : [];
    for (const s of rawStoryList) {
      const des = String(s?.des ?? '').trim();
      const Title = String(s?.Title ?? '').trim();

      if (Title && seenTitle.has(Title)) continue;

      if (des || Title) {
        if (Title) seenTitle.add(Title);
        storyList.push({ des, Title });
      }
    }
  }

  // homeSkillList (UnitFactory.homeSkillList[].id -> HomeSkillVM, nextIndex 누적 param 치환)
  const homeSkillList = [];
  const rawHomeSkillList = Array.isArray(unitRec?.homeSkillList) ? unitRec.homeSkillList : [];

  const accParamByIndex = new Map();
  const HOME_PARAM_SCALE = 1000000;

  // base param 스케일 저장
  for (let i = 0; i < rawHomeSkillList.length; i++) {
    const hs = rawHomeSkillList[i];
    const hid = Number(hs?.id);
    if (!Number.isFinite(hid) || hid <= 0) continue;

    const hrec = homeSkillById.get(hid);
    if (!hrec) continue;

    const baseParam = Number(hrec?.param);
    if (!Number.isFinite(baseParam)) continue;

    const baseScaled = Math.trunc(baseParam * HOME_PARAM_SCALE);
    accParamByIndex.set(i, baseScaled);
  }

  // nextIndex 체인 누적 (nextIndex는 1-based)
  for (let i = 0; i < rawHomeSkillList.length; i++) {
    const hs = rawHomeSkillList[i];
    const nextIdx1 = Number(hs?.nextIndex);
    if (!Number.isFinite(nextIdx1) || nextIdx1 <= 0) continue;

    const nextIdx0 = nextIdx1 - 1;

    if (nextIdx0 >= 0 && nextIdx0 < rawHomeSkillList.length && accParamByIndex.has(nextIdx0)) {
      const prevScaled = accParamByIndex.get(i) || 0;
      accParamByIndex.set(nextIdx0, accParamByIndex.get(nextIdx0) + prevScaled);
    }
  }

  // 출력용 homeSkillList 생성
  for (let i = 0; i < rawHomeSkillList.length; i++) {
    const hs = rawHomeSkillList[i];
    const hid = Number(hs?.id);
    if (!Number.isFinite(hid) || hid <= 0) continue;

    const hrec = homeSkillById.get(hid);
    if (!hrec) continue;

    const name = String(hrec?.name || hrec?.Name || '').trim();
    const descTpl = String(hrec?.desc || hrec?.Desc || '').trim();
    const resonanceLv = Number(hs?.resonanceLv);

    const accScaled = accParamByIndex.get(i);
    let paramText = '';

    if (Number.isFinite(accScaled)) {
      const accParam = accScaled / HOME_PARAM_SCALE;

      if (descTpl.includes('%%')) {
        const pct = accParam * 100;
        const pctTrunc = Math.trunc(pct * 10) / 10;
        paramText = pctTrunc.toFixed(1);
      } else {
        const vTrunc = Math.trunc(accParam * 1000) / 1000;
        paramText = String(vTrunc);
      }
    }

    const desc = descTpl ? descTpl.replace(/%s/g, paramText) : '';

    if (name || desc || resonanceLv) {
      homeSkillList.push({ name, desc, resonanceLv: Number.isFinite(resonanceLv) ? resonanceLv : undefined });
    }
  }

  // SkinName (UnitViewVM에서 character==id인 스킨 목록 생성)
  const SkinName = [];
  if (viewVm && typeof viewVm === 'object') {
    for (const key of Object.keys(viewVm)) {
      const v = viewVm[key];
      if (!v) continue;
      if (Number(v.character) !== Number(id)) continue;

      const skinName = String(v.SkinName || '').trim();
      const resUrl = String(v.resUrl || '').trim();
      if (!skinName || !resUrl) continue;

      SkinName.push({ [skinName]: resUrl });
    }

    console.log('State2Res raw:', viewRec?.State2Res, 'typeof:', typeof viewRec?.State2Res, 'len:', String(viewRec?.State2Res ?? '').length);

    const state2Res = viewRec ? String(viewRec.State2Res ?? '').trim() : '';
    if (state2Res) {
      const rec = { ['공명']: state2Res };

      // index = 1 (두 번째)에 삽입
      if (SkinName.length >= 1) {
        SkinName.splice(1, 0, rec);
      } else {
        // 기본 스킨이 없는 예외 케이스
        SkinName.push(rec);
      }
    }
  }  

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
    ResumeList: Array.isArray(unitRec?.ResumeList) ? unitRec.ResumeList : [],

    portraitRel,
    avatarRel,
    skillIds,

    SkinName,
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
  setText('char-name-en', ''); 

  const rarityEl = qs('#char-rarity');
  if (rarityEl) {
    clearChildren(rarityEl);

    const r = String(detail.rarity || '').trim();
    if (r) {
      const img = document.createElement('img');
      img.alt = r;
      img.src = buildAssetImageUrl(`UI/Common/${r}`);
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

    if (!detail.ResumeList || detail.ResumeList.length === 0) {
      resumeRoot.textContent = '미확정';
    } else {
      for (const r of detail.ResumeList) {
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
