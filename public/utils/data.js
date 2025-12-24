/**
 * data.js
 * - 팩토리 기반 데이터 처리 모음
 *
 * 규칙
 * - DOM 조작/렌더링 함수는 포함하지 않는다.
 * - '기본 유틸'(fetchJson, normalizePathSlash 등)은 utils.js에 두고, 여기서는 import해서 사용한다.
 */

import { fetchJson, normalizePathSlash } from './utils.js';
import { assetPath } from './path.js';

// =========================
// 1) 공용: 정규화 / 안전 변환
// =========================

export function normalizeRootJson(raw) {
  // - BinaryConfig json은 대체로 "list" 루트
  // - 일부는 { list: [...] } 또는 { data: [...] } 같은 변형 가능성
  if (Array.isArray(raw)) {
    return raw;
  }

  if (raw && typeof raw === "object") {
    if (Array.isArray(raw.list)) {
      return raw.list;
    }

    if (Array.isArray(raw.data)) {
      return raw.data;
    }

    if (Array.isArray(raw.items)) {
      return raw.items;
    }
  }

  return [];
}

// 안전한 숫자 변환 (실패 시 null)
export function safeNumber(v) {
  if (v === null || v === undefined) {
    return null;
  }

  const n = Number(v);
  return Number.isFinite(n) ? n : null;
}

function buildIdMapFromRootJson(json) {
  const raw = normalizeRootJson(json);
  const map = new Map();

  for (const r of raw) {
    const id = safeNumber(r?.id);
    if (id === null) {
      continue;
    }

    if (!map.has(id)) {
      map.set(id, r);
    }
  }

  return map;
}

// =========================
// 2) 표기 변환 (UI용 최소)
// =========================

export const qualityToRarityMap = {
  Orange: 'UR',
  Golden: 'SSR',
  Purple: 'SR',
  Blue: 'R',
  White: 'N'
};

export function mapQualityToRarity(quality) {
  return qualityToRarityMap[String(quality)] || '-';
}

export function mapUnitQualityToRarity(quality) {
  const k0 = String(quality || "").trim();
  const k = k0.toLowerCase();

  // KR 데이터에서 관측: FiveStar, fourStar, threeStar, twoStar, oneStar
  if (k === "fivestar") {
    return "SSR";
  }
  if (k === "fourstar") {
    return "SR";
  }
  if (k === "threestar") {
    return "R";
  }
  if (k === "twostar" || k === "onestar") {
    return "N";
  }

  // 혹시 다른 규칙이 들어오면 최후 fallback
  return mapQualityToRarity(k0);
}

// =========================
// 3) Base: id -> record Map 로더
// =========================

class IdMapFactoryBase {
  constructor(url) {
    this.url = url || null;
    this.mapById = null;
    this.loadingPromise = null;
  }

  async load() {
    if (this.mapById) {
      return this.mapById;
    }

    if (this.loadingPromise) {
      return await this.loadingPromise;
    }

    if (!this.url) {
      throw new Error('Factory: url이 설정되지 않았습니다.');
    }

    this.loadingPromise = (async () => {
      const json = await fetchJson(this.url);
      this.mapById = buildIdMapFromRootJson(json);
      return this.mapById;
    })();

    return await this.loadingPromise;
  }

  getMap() {
    return this.mapById;
  }

  getById(id) {
    if (!this.mapById) {
      return null;
    }

    const key = safeNumber(id);
    if (key === null) {
      return null;
    }

    return this.mapById.get(key) || null;
  }

  invalidate() {
    this.mapById = null;
    this.loadingPromise = null;
  }
}

// =========================
// 4) Factories (현재 UI에서 쓰는 것 위주)
// =========================

export class SkillFactory extends IdMapFactoryBase {
  constructor(opt = {}) {
    super(opt.skillUrl);
  }

  resolveSkillName(skillRec) {
    return String(skillRec?.name || '').trim();
  }

  resolveSkillDesc(skillRec) {
    return String(skillRec?.description || skillRec?.tempdescription || '').trim();
  }

  resolveSkillDetailDesc(skillRec) {
    return String(skillRec?.detailDescription || skillRec?.detailDes || skillRec?.detail || '').trim();
  }

  resolveSkillIconPath(skillRec) {
    const candidates = [skillRec?.iconPath, skillRec?.icon, skillRec?.skillIcon, skillRec?.imagePath, skillRec?.resUrl];

    for (const c of candidates) {
      const s = String(c || '').trim();
      if (s) {
        return s;
      }
    }

    return '';
  }
}

export class ListFactory extends IdMapFactoryBase {
  constructor(opt = {}) {
    super(opt.listUrl);
  }
}

export class GrowthFactory extends IdMapFactoryBase {
  constructor(opt = {}) {
    super(opt.growthUrl);
  }
}

export class TagFactory extends IdMapFactoryBase {
  constructor(opt = {}) {
    super(opt.tagUrl);
  }

  // TagFactory는 케이스가 많아서 안전한 우선순위만 고정
  resolveCategoryName(tagRec) {
    const v = String(tagRec?.Name || tagRec?.tagName || '').trim();
    return v || '';
  }

  resolveFactionName(tagRec) {
    const v = String(tagRec?.sideName || "").trim();
    return v || "";
  }

  // TagFactory 내부
  resolveSideIconName(tagRec) {
    // icon / iconPath / IconPath 등 혼재 대응
    const raw =
      tagRec?.icon ||
      tagRec?.iconPath ||
      tagRec?.Icon ||
      tagRec?.IconPath ||
      "";

    const norm = normalizePathSlash(String(raw));
    const base = norm.split("/").pop() || "";
    return base; // 확장자 없는 이름만
  }
}

// =========================
// 5) EquipmentFactory
// - equipTagId/campTagId -> TagFactory로 해석
// - randomSkillList.skillId = ListFactory.id
// - 랜덤 풀 분류: SkillRec.campList/specialTagList -> TagFactory.sideName 존재 여부만 사용
// - randomPools는 lazy(getRandomPools)로만 계산
// =========================



// --- data.js: UnitViewFactory 교체/확장 ---
// (기존 resolveImageUrlFromViewPath / pickPortraitUrls / pickIconUrls는 유지하고,
//  아래 메서드들만 추가)

export class UnitViewFactory extends IdMapFactoryBase {
  constructor(opt = {}) {
    super(opt.unitViewUrl);
  }

  resolveImageUrlFromViewPath(viewPath) {
    const raw = String(viewPath || "").trim();
    if (!raw) {
      return "";
    }

    const norm = normalizePathSlash(raw).replace(/^\/+/g, "");
    return assetPath(`${norm}.png`);
  }

  pickPortraitUrls(viewRec) {
    const half = this.resolveImageUrlFromViewPath(viewRec?.roleListResUrl);
    const squadsHalf1 = this.resolveImageUrlFromViewPath(viewRec?.squadsHalf1);
    const squadsHalf2 = this.resolveImageUrlFromViewPath(viewRec?.squadsHalf2);

    return {
      half,
      squadsHalf1,
      squadsHalf2,
    };
  }

  pickIconUrls(viewRec) {
    const small = this.resolveImageUrlFromViewPath(viewRec?.iconPath);
    const big = this.resolveImageUrlFromViewPath(viewRec?.tipsPath);

    return {
      small,
      big,
    };
  }

  // -------------------------
  // 플레이어블 판정(전면 수정 핵심)
  // - UnitViewFactory.character로 먼저 후보를 만들고
  // - UnitFactory(mod)로 "玩家角色"만 통과
  // - 리스트는 기본 스킨(대부분 SkinName="기본")만 선택
  // -------------------------

  // UnitViewFactory
  isPlayableView(viewRec, unitFactory) {
    const charId = safeNumber(viewRec?.character);
    if (!charId || charId <= 0) {
      return false;
    }

    const unitRec = unitFactory?.getById(charId) || null;
    if (!unitRec) {
      return false;
    }

    // Unit 기준 판정은 UnitFactory로
    if (!unitFactory.isPlayableUnit(unitRec)) {
      return false;
    }

    // 기본 스킨만(默认/기본/빈문자 허용)
    const skinName = String(viewRec?.SkinName || "").trim();
    if (skinName && skinName !== "기본" && skinName !== "默认") {
      return false;
    }

    return true;
  }

  scorePrimaryView(viewRec, unitRec) {
    // 높은 점수 = 더 “대표 스킨”
    let score = 0;

    const skinName = String(viewRec?.SkinName || "").trim();
    if (skinName === "기본") {
      score += 1000;
    } else if (skinName === "") {
      score += 800;
    }

    // UnitFactory.viewId(기본 view)와 일치하면 가산
    const unitViewId = safeNumber(unitRec?.viewId);
    const viewId = safeNumber(viewRec?.id);
    if (unitViewId && viewId && unitViewId === viewId) {
      score += 200;
    }

    // idCN이 "我方/"로 시작하면 가산(있을 때만)
    const idCN = String(viewRec?.idCN || "").trim();
    if (idCN.startsWith("我方/")) {
      score += 50;
    }

    // 동점 방지용: id가 작을수록 약간 가산
    if (viewId) {
      score += Math.max(0, 10 - (viewId % 10));
    }

    return score;
  }

  getPrimaryPlayableViews(unitFactory) {
    const viewMap = this.getMap();
    if (!viewMap) {
      return [];
    }

    // characterId -> best viewRec
    const bestByChar = new Map();

    for (const viewRec of viewMap.values()) {
      if (!this.isPlayableView(viewRec, unitFactory)) {
        continue;
      }

      const charId = safeNumber(viewRec?.character);
      const unitRec = unitFactory.getById(charId);
      if (!unitRec) {
        continue;
      }

      const prev = bestByChar.get(charId) || null;
      if (!prev) {
        bestByChar.set(charId, viewRec);
        continue;
      }

      const sPrev = this.scorePrimaryView(prev, unitRec);
      const sNow = this.scorePrimaryView(viewRec, unitRec);

      if (sNow > sPrev) {
        bestByChar.set(charId, viewRec);
      }
    }

    return Array.from(bestByChar.values());
  }
}


// --- data.js: UnitFactory 수정 ---
// (기존 isPlayableUnit / getPlayableUnits 삭제하고, viewFactory 기반으로만 제공)

export class UnitFactory extends IdMapFactoryBase {
  constructor(opt = {}) {
    super(opt.unitUrl);

    this.unitViewUrl = opt.unitViewUrl || null;
    this.viewFactory = new UnitViewFactory({ unitViewUrl: this.unitViewUrl });
    this.listRaw = null;
  }

  async load() {
    await Promise.all([super.load(), this.viewFactory.load()]);

    if (!this.listRaw) {
      const raw = await fetchJson(this.url);
      this.listRaw = normalizeRootJson(raw);
    }

    return {
      unitMap: this.getMap(),
      viewMap: this.viewFactory.getMap()
    };
  }

  getUnitById(id) {
    return this.getById(id);
  }

  getViewById(id) {
    return this.viewFactory.getById(id);
  }

  getViewForUnit(unitRec) {
    const viewId = safeNumber(unitRec?.viewId);
    if (viewId === null) {
      return null;
    }
    return this.getViewById(viewId);
  }

  getViewForUnitId(unitId) {
    const u = this.getUnitById(unitId);
    if (!u) {
      return null;
    }
    return this.getViewForUnit(u);
  }

  getAllUnits() {
    if (this.listRaw) {
      return this.listRaw;
    }
    return Array.from(this.getMap().values());
  }

  // UnitFactory
  isPlayableUnit(unitRec) {
    if (!unitRec) {
      return false;
    }

    const mod = String(unitRec.mod || "").trim();
    if (mod !== "玩家角色") {
      return false;
    }

    const idCN = String(unitRec.idCN || "");
    if (idCN.includes("未上线") || idCN.includes("50未上线")) {
      return false;
    }

    // const unitIdCN = String(unitRec?.idCN || "").trim();
    // if (unitIdCN.includes("剧情")) {
    //   return false;
    // }

    return true;
  }

  resolveFaction(unitRec, tagF) {
    // 반환: { name, iconName, tagId }
    // - iconName: "camp_1" 처럼 확장자 없는 베이스 이름(없으면 "")
    // - URL은 UI 레이어(characterdb.js)에서 uiSideIconPath로 만든다.

    // 1) sideId 우선
    const sideId = safeNumber(unitRec?.sideId);
    if (sideId !== null && sideId > 0) {
      const t = tagF.getById(sideId);
      const name = tagF.resolveFactionName(t);
      const iconName = tagF.resolveSideIconName(t);

      if (name || iconName) {
        return { name: name || '', iconName: iconName || '', tagId: sideId };
      }
    }

    // 2) tagList에서 sideName 있는 태그 탐색
    const list = Array.isArray(unitRec?.tagList) ? unitRec.tagList : [];
    for (const it of list) {
      const tid = safeNumber(it?.tagId);
      if (tid === null) {
        continue;
      }

      const t = tagF.getById(tid);
      const name = tagF.resolveFactionName(t);
      if (!name) {
        continue;
      }

      const iconName = tagF.resolveSideIconName(t);
      return { name: name || '', iconName: iconName || '', tagId: tid };
    }

    return { name: '', iconName: '', tagId: null };
  }

  invalidate() {
    super.invalidate();
    this.listRaw = null;
    this.viewFactory.invalidate();
  }
}

// =========================
// 6) (캐릭터 상세에서 쓰는) ProfilePhoto / Talent / Awake Factory
// =========================

export class ProfilePhotoFactory extends IdMapFactoryBase {
  constructor(opt = {}) {
    super(opt.profilePhotoUrl);
  }

  resolvePhotoUrl(photoRec) {
    const raw = String(photoRec?.imagePath || photoRec?.tipsPath || "").trim();
    if (!raw) {
      return "";
    }

    const norm = normalizePathSlash(raw).replace(/^\/+/g, "");
    return assetPath(`${norm}.png`);
  }

  hasCharacterListPortrait(viewRec) {
    const p = String(viewRec?.roleListResUrl || "").trim();
    const h1 = String(viewRec?.squadsHalf1 || "").trim();
    const h2 = String(viewRec?.squadsHalf2 || "").trim();
    return Boolean(p || h1 || h2);
  }
}

export class TalentFactory extends IdMapFactoryBase {
  constructor(opt = {}) {
    super(opt.talentUrl);
  }
}

export class AwakeFactory extends IdMapFactoryBase {
  constructor(opt = {}) {
    super(opt.awakeUrl);
  }
}