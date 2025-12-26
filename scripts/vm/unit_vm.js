// scripts/vm/unit_vm.js
// Build UnitVM.json (KR output) from CN factories + KR ConfigLanguage mapping.
//
// Output: { [unitId:number]: UnitVM }
//
// UnitVM fields:
// - id, name, rarity
// - factionName, factionIconName
// - line
// - portraitRel, avatarRel
// - birthday, gender, height
// - skillIds: number[]
//
// Translation rule:
// - strings are translated by ConfigLanguage (factory/field), missing => keep CN
//
// Folder structure expectation (from scripts.zip build flow):
// - inputs: public/data/CN/*.json
// - cfg:    public/data/KR/ConfigLanguage.json
// - output: public/data/KR/UnitVM.json

// -------------------------
// minimal shared helpers (self-contained)
// -------------------------
function normalizePathSlash(p) {
  return String(p || '').replace(/\\/g, '/');
}

function safeNumber(v) {
  const n = Number(v);
  return Number.isFinite(n) ? n : 0;
}

function normalizeRootJson(raw) {
  if (Array.isArray(raw)) return raw;
  if (raw && typeof raw === 'object') {
    if (Array.isArray(raw.list)) return raw.list;
  }
  return [];
}

function normText(s) {
  return String(s || '')
    .replace(/\r\n/g, '\n')
    .replace(/\r/g, '\n')
    .trim();
}

// cfg structure: { [factoryName]: { [fieldName]: { [cnText]: koText } } }
function tr(cfg, factoryName, fieldName, textCN) {
  if (textCN === null || textCN === undefined) return textCN;

  const src = String(textCN);
  if (!src) return src;

  const facObj = cfg?.[factoryName];
  const mapping = facObj?.[fieldName];
  if (!mapping || typeof mapping !== 'object') return src;

  if (Object.prototype.hasOwnProperty.call(mapping, src)) return mapping[src];

  const n = normText(src);
  if (Object.prototype.hasOwnProperty.call(mapping, n)) return mapping[n];

  return src;
}

function stripLeadingSlashes(p) {
  return String(p || '')
    .replace(/\\/g, '/')
    .replace(/^\/+/g, '');
}

function toRelNoExt(pathLike) {
  const raw = String(pathLike || '').trim();
  if (!raw) return '';
  const norm = stripLeadingSlashes(normalizePathSlash(raw));
  return norm.replace(/\.(png|webp|jpg|jpeg)$/i, '');
}

function mapQualityToRarity(q) {
  const k = String(q || '')
    .trim()
    .toLowerCase();
  if (k === 'fivestar' || k === 'fiveStar'.toLowerCase()) return 'SSR';
  if (k === 'fourstar') return 'SR';
  if (k === 'threestar') return 'R';
  if (k === 'twostar' || k === 'onestar') return 'N';
  // fallback
  return 'N';
}

function buildIdMap(list) {
  const m = new Map();
  for (const r of Array.isArray(list) ? list : []) {
    const id = safeNumber(r?.id);
    if (id) m.set(id, r);
  }
  return m;
}

function pickFirstString(obj, keys) {
  for (const k of keys) {
    const v = obj?.[k];
    if (v === null || v === undefined) continue;
    const s = String(v).trim();
    if (s) return s;
  }
  return '';
}

// -------------------------
// main
// -------------------------
export function buildUnitVM(ctx) {
  const cfg = ctx?.cfg || {};
  const factories = ctx?.factories || {};

  // factories expected keys (from scripts/build_vm.js flow):
  // - unitList, unitViewList
  // - tagById (Map) or tag list
  // - photoById (Map) or photo list
  const unitList = normalizeRootJson(factories.unitList || []);
  const unitViewList = normalizeRootJson(factories.unitViewList || []);
  const tagById = factories.tagById instanceof Map ? factories.tagById : buildIdMap(normalizeRootJson(factories.tagById || factories.tagList || []));
  const photoById = factories.photoById instanceof Map ? factories.photoById : buildIdMap(normalizeRootJson(factories.photoById || factories.profilePhotoList || []));
  const talentById = factories.talentById instanceof Map ? factories.talentById : buildIdMap(normalizeRootJson(factories.talentById || factories.talentList || []));
  const listById = factories.listById instanceof Map ? factories.listById : buildIdMap(normalizeRootJson(factories.listById || factories.ListFactory || []));
  const breakthroughById = factories.breakthroughById instanceof Map ? factories.breakthroughById : buildIdMap(normalizeRootJson(factories.breakthroughById || []));
  const homeSkillById = factories.homeSkillById instanceof Map ? factories.homeSkillById : buildIdMap(normalizeRootJson(factories.homeSkillById || []));
  const unitViewById = buildIdMap(unitViewList);

  const outById = {};

  // 도감/획득/편성 가능(=플레이어블) 후보 카운트
  let totalUnits = 0;
  let playableCandidates = 0;

  for (const unitRec of unitList) {
    totalUnits += 1;

    // UnitFactory 기준: 플레이어 캐릭터 묶음만 대상으로 함
    if (unitRec?.mod !== '玩家角色') continue;

    const idcn = String(unitRec?.idCN || '');

    // 제외 조건: 미출시/스토리NPC/열차장
    if (idcn.includes('50未上线')) continue;
    if (idcn.includes('剧情NPC')) continue;
    if (idcn.includes('01列车长')) continue;

    // 포함 조건: 02/03/04/05五星
    if (!idcn.includes('05五星') && !idcn.includes('04四星') && !idcn.includes('03三星') && !idcn.includes('02二星')) continue;

    // 추가 제외 조건:
    // - gender가 빈 값인 레코드는 제외 (예: 10000117)
    const gender = String(unitRec?.gender ?? '').trim();
    if (gender === '') continue;

    playableCandidates += 1;

    const id = safeNumber(unitRec?.id);
    if (!id) continue;

    const nameCN = String(unitRec?.name || '');
    const name = tr(cfg, 'UnitFactory', 'name', nameCN);

    const rarity = mapQualityToRarity(unitRec?.quality);

    // faction (sideId -> TagFactory.sideName/icon)
    const sideId = safeNumber(unitRec?.sideId);
    const tagRec = sideId ? tagById.get(sideId) : null;

    const factionNameCN = String(tagRec?.sideName || '');
    const factionName = factionNameCN ? tr(cfg, 'TagFactory', 'sideName', factionNameCN) : '';

    const factionIconName = pickFirstString(tagRec, ['icon', 'Icon']);

    // line
    const line = safeNumber(unitRec?.line);

    // view join
    const viewId = safeNumber(unitRec?.viewId);
    const viewRec = viewId ? unitViewById.get(viewId) : null;

    // portraitRel: prefer UnitViewFactory.roleListResUrl, fallback squadsHalf1/2/bookHalf
    const portraitRel = toRelNoExt(pickFirstString(viewRec, ['roleListResUrl', 'squadsHalf1', 'squadsHalf2', 'bookHalf']));

    // avatarRel: UnitVM.json(업로드본)에서는 전부 "" 이므로 그대로 유지
    const avatarRel = '';

    // profile fields
    const birthday = tr(cfg, 'UnitFactory', 'birthday', unitRec?.birthday ?? '');
    //const gender = tr(cfg, 'UnitFactory', 'gender', unitRec?.gender ?? '');
    const height = tr(cfg, 'UnitFactory', 'height', unitRec?.height ?? '');

    const birthplace = tr(cfg, 'UnitFactory', 'birthplace', unitRec?.birthplace ?? '');
    const ability = tr(cfg, 'UnitFactory', 'ability', unitRec?.ability ?? '');
    const identity = tr(cfg, 'UnitFactory', 'identity', unitRec?.identity ?? '');

    const resumeListRaw = Array.isArray(unitRec?.ResumeList) ? unitRec.ResumeList : [];
    const resumeList = resumeListRaw
      .map((r) => ({
        des: tr(cfg, 'UnitFactory', 'des', r?.des ?? '')
      }))
      .filter((r) => r.des);

    const getCharacter = tr(cfg, 'UnitFactory', 'getCharacter', unitRec?.getCharacter ?? '');

    // skins: UnitFactory.skinList.unitViewId -> UnitViewFactory.id, UnitViewFactory.resUrl -> SkinName 목록
    const skinListRaw = Array.isArray(unitRec?.skinList) ? unitRec.skinList : [];
    const SkinName = [];

    for (const sk of skinListRaw) {
      const unitViewId = safeNumber(sk?.unitViewId);
      if (!unitViewId) continue;

      const viewRec2 = unitViewById.get(unitViewId);

      // skin name: skinList에 이름이 없을 수 있어(view 출력처럼) UnitViewFactory에서 폴백
      const skinNameCN = pickFirstString(sk, ['SkinName', 'skinName']) || pickFirstString(viewRec2, ['SkinName', 'skinName']);

      if (!skinNameCN) continue;

      const resUrl = String(viewRec2?.resUrl ?? '').trim();
      if (!resUrl) continue;

      const skinNameKO = tr(cfg, 'UnitViewFactory', 'SkinName', skinNameCN);

      SkinName.push({
        [skinNameKO]: resUrl
      });

      // SkinName === "默认" → 공명(State2Res) 추가 저장
      if (skinNameCN === '默认') {
        const state2Res = String(viewRec2?.State2Res ?? '').trim();
        if (state2Res) {
          SkinName.push({
            ['공명']: state2Res
          });
        }
      }
    }

    // skills
    const skillIds = [];
    const rawSkillList = Array.isArray(unitRec?.skillList) ? unitRec.skillList : [];
    for (const s of rawSkillList) {
      const sid = safeNumber(s?.skillId);
      const num = safeNumber(s?.num);
      if (sid) {
        skillIds.push({
          skillId: sid,
          num: num || undefined
        });
      }
    }

    // optional: collect used skill ids (if ctx.usedUnitSkillIds is provided)
    if (ctx?.usedUnitSkillIds && typeof ctx.usedUnitSkillIds.add === 'function') {
      for (const s of skillIds) {
        const sid = safeNumber(s?.skillId);
        if (sid) ctx.usedUnitSkillIds.add(sid);
      }
    }

    const talentIds = [];
    const rawTalentList = Array.isArray(unitRec?.talentList) ? unitRec.talentList : [];
    for (const t of rawTalentList) {
      const tid = safeNumber(t?.talentId);
      if (!tid) continue;

      const trec = talentById.get(tid);
      if (!trec) continue;

      const nameCN = pickFirstString(trec, ['name', 'Name']);
      const descCN = pickFirstString(trec, ['desc', 'Desc', 'description', 'Description']);
      const pathCN = pickFirstString(trec, ['path', 'Path']);
      const skillIntensify = safeNumber(trec?.skillIntensify);

      talentIds.push({
        name: nameCN ? tr(cfg, 'TalentFactory', 'name', nameCN) : '',
        desc: descCN ? tr(cfg, 'TalentFactory', 'desc', descCN) : '',
        path: pathCN ? toRelNoExt(pathCN) : '',
        skillIntensify: skillIntensify || undefined
      });
    }

    // profile photo paths (UnitFactory.ProfilePhotoList[].id -> ProfilePhotoFactory.imagePath)
    const profilePhotoPath = [];

    if (Array.isArray(unitRec?.ProfilePhotoList)) {
      for (const p of unitRec.ProfilePhotoList) {
        const pid = safeNumber(p?.id);
        if (!pid) continue;

        const photoRec = photoById.get(pid);
        if (!photoRec) continue;

        const imgPath = pickFirstString(photoRec, ['imagePath', 'ImagePath']);
        if (!imgPath) continue;

        profilePhotoPath.push(toRelNoExt(imgPath));
      }
    }

    // story list (UnitFactory.file -> ListFactory.id -> StoryList[])
    const storyList = [];
    const fileList = Array.isArray(unitRec?.fileList) ? unitRec.fileList : [];

    const seenTitle = new Set();
    const seenFileId = new Set();

    for (const f of fileList) {
      const fileId = safeNumber(f?.file);
      if (!fileId) continue;

      // fileId 중복 skip
      if (seenFileId.has(fileId)) continue;
      seenFileId.add(fileId);

      const listRec = listById.get(fileId);
      if (!listRec) continue;

      const rawStoryList = Array.isArray(listRec?.StoryList) ? listRec.StoryList : [];

      for (const s of rawStoryList) {
        const desCN = s?.des ?? '';
        const titleCN = s?.Title ?? '';

        const des = desCN ? tr(cfg, 'ListFactory', 'des', desCN) : '';
        const Title = titleCN ? tr(cfg, 'ListFactory', 'Title', titleCN) : '';

        // Title이 이미 있으면 skip
        if (Title && seenTitle.has(Title)) continue;

        if (des || Title) {
          if (Title) seenTitle.add(Title);
          storyList.push({ des, Title });
        }
      }
    }

    // awake list (UnitFactory.breakthroughList[].breakthroughId -> BreakthroughFactory)
    const awakeList = [];

    const rawBreakList = Array.isArray(unitRec?.breakthroughList) ? unitRec.breakthroughList : [];

    for (const b of rawBreakList) {
      const bid = safeNumber(b?.breakthroughId);
      if (!bid) continue;

      const brec = breakthroughById.get(bid);
      if (!brec) continue;

      const nameCN = pickFirstString(brec, ['name', 'Name']);
      const pathCN = pickFirstString(brec, ['path', 'Path']);
      const descCN = pickFirstString(brec, ['desc', 'Desc', 'description', 'Description']);

      awakeList.push({
        name: nameCN ? tr(cfg, 'BreakthroughFactory', 'name', nameCN) : '',
        path: pathCN ? toRelNoExt(pathCN) : '',
        desc: descCN ? tr(cfg, 'BreakthroughFactory', 'desc', descCN) : ''
      });
    }    

    // 1) rawHomeSkillList 수집    
    const rawHomeSkillList = Array.isArray(unitRec?.homeSkillList) ? unitRec.homeSkillList : [];

    // index(0-based) → 누적 param (정수 스케일)
    const accParamByIndex = new Map();
    const HOME_PARAM_SCALE = 1000000;

    for (let i = 0; i < rawHomeSkillList.length; i++) {
      const hs = rawHomeSkillList[i];
      const hid = safeNumber(hs?.id);
      if (!hid) continue;

      const hrec = homeSkillById.get(hid);
      if (!hrec) continue;

      const baseParam = Number(hrec?.param);
      if (!Number.isFinite(baseParam)) continue;

      // 소수점 절삭: 스케일 정수로 저장
      const baseScaled = Math.trunc(baseParam * HOME_PARAM_SCALE);
      accParamByIndex.set(i, baseScaled);
    }

    // nextIndex 체인 누적 (nextIndex는 1-based)
    for (let i = 0; i < rawHomeSkillList.length; i++) {
      const hs = rawHomeSkillList[i];
      const nextIdx1 = safeNumber(hs?.nextIndex);
      if (!nextIdx1) continue;

      const nextIdx0 = nextIdx1 - 1;

      if (nextIdx0 >= 0 && nextIdx0 < rawHomeSkillList.length && accParamByIndex.has(nextIdx0)) {
        const prevScaled = accParamByIndex.get(i) || 0;
        accParamByIndex.set(nextIdx0, accParamByIndex.get(nextIdx0) + prevScaled);
      }
    }

    // 출력용 homeSkillList 생성 (누적 param 기준)
    const homeSkillList = [];

    for (let i = 0; i < rawHomeSkillList.length; i++) {
      const hs = rawHomeSkillList[i];
      const hid = safeNumber(hs?.id);
      if (!hid) continue;

      const hrec = homeSkillById.get(hid);
      if (!hrec) continue;

      const nameCN = pickFirstString(hrec, ['name', 'Name']);
      const name = nameCN ? tr(cfg, 'HomeSkillFactory', 'name', nameCN) : '';

      const descCN = pickFirstString(hrec, ['desc', 'Desc']);
      const resonanceLv = safeNumber(hs?.resonanceLv);

      // 번역 -> 치환
      const descTr = descCN ? tr(cfg, 'HomeSkillFactory', 'desc', descCN) : '';

      const accScaled = accParamByIndex.get(i);
      let paramText = '';

      if (Number.isFinite(accScaled)) {
        const accParam = accScaled / HOME_PARAM_SCALE;

        if (String(descTr).includes('%%')) {
          // 퍼센트: 1자리 소수까지 절삭 후 고정 표시(예: 30.0)
          const pct = accParam * 100;
          const pctTrunc = Math.trunc(pct * 10) / 10;
          paramText = pctTrunc.toFixed(1);
        } else {
          // 일반 수치: 소수 3자리까지 절삭
          const vTrunc = Math.trunc(accParam * 1000) / 1000;
          paramText = String(vTrunc);
        }
      }

      const desc = descTr ? String(descTr).replace(/%s/g, paramText) : '';

      if (name || desc || resonanceLv) {
        homeSkillList.push({ name, desc, resonanceLv });
      }
    }

    outById[String(id)] = {
      id,
      name,
      rarity,
      factionName,
      factionIconName,
      line,
      portraitRel,
      avatarRel,
      birthday,
      gender,
      height,
      skillIds,
      birthplace,
      ability,
      identity,
      getCharacter,
      resumeList,
      SkinName,
      talentIds,
      profilePhotoPath,
      storyList,
      awakeList,
      homeSkillList
    };
  }

  return outById;
}
