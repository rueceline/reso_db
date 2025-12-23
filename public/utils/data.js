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

export class EquipmentFactory {
  constructor(opt = {}) {
    this.equipmentUrl = opt.equipmentUrl || null;

    // context maps
    this.growthById = opt.growthById || null; // Map<number, GrowthRec>
    this.skillById = opt.skillById || null; // Map<number, SkillRec>
    this.listById = opt.listById || null; // Map<number, ListRec>
    this.tagById = opt.tagById || null; // Map<number, TagRec>

    this.recMap = null; // Map<number, EquipRec>
    this.loadingPromise = null;

    // lazy cache
    this.randomPoolsByEquipId = null; // Map<number, Pool[]>
  }

  setContext(ctx = {}) {
    if (ctx.growthById) this.growthById = ctx.growthById;
    if (ctx.skillById) this.skillById = ctx.skillById;
    if (ctx.listById) this.listById = ctx.listById;
    if (ctx.tagById) this.tagById = ctx.tagById;
  }

  invalidate() {
    this.recMap = null;
    this.loadingPromise = null;
    this.randomPoolsByEquipId = null;
  }

  async buildEquipmentRecMap() {
    if (this.recMap) {
      return this.recMap;
    }

    if (this.loadingPromise) {
      return await this.loadingPromise;
    }

    if (!this.equipmentUrl) {
      throw new Error('EquipmentFactory: equipmentUrl이 설정되지 않았습니다.');
    }

    this.loadingPromise = (async () => {
      const equipJson = await fetchJson(this.equipmentUrl);
      const list = normalizeRootJson(equipJson);

      const out = new Map();

      for (const raw of list) {
        const id = safeNumber(raw?.id);
        if (id === null) {
          continue;
        }

        const rarity = mapQualityToRarity(raw?.quality);
        const fc = this.resolveFactionAndCategoryFromTags(raw);

        // -------------------------
        // 테스트/더미 레코드 제외:
        // - 장비 id가 ListFactory에 없으면 제외
        // -------------------------
        if (String(raw.idCN).startsWith('00')) continue;

        let mainStat = null;
        if (this.growthById) {
          const growthId = safeNumber(raw?.growthId);
          const growthRec = growthId === null ? null : this.growthById.get(growthId) || null;
          mainStat = this.calcMainStatWithGrowth(raw, growthRec);
        }

        const tipsPath = String(raw?.tipsPath || raw?.iconPath || raw?.icon || raw?.imagePath || '').trim();
        const imageUrl = this.resolveImageUrl(tipsPath);

        let mainOption = '';
        {
          const fixed = this.resolveFixedSkills(raw);
          const first = Array.isArray(fixed) && fixed.length > 0 ? fixed[0] : null;
          if (first) {
            mainOption = String(first?.description || first?.tempdescription || '').trim();
          }
        }

        const rec = {
          id,
          raw, // 원본 보존(팩토리 내부만)
          name: String(raw?.name || ''),
          rarity,
          faction: fc.faction,
          category: fc.category,
          mainStat,
          tipsPath,
          imageUrl,
          mainOption
        };

        out.set(id, rec);
      }

      this.recMap = out;
      return this.recMap;
    })();

    return await this.loadingPromise;
  }

  getRecMap() {
    return this.recMap;
  }

  getById(id) {
    if (!this.recMap) {
      return null;
    }

    const key = safeNumber(id);
    if (key === null) {
      return null;
    }

    return this.recMap.get(key) || null;
  }

  // -------------------------
  // UI 보조: 스탯 계산 (현행 유지)
  // -------------------------

  resolveMainStat(e) {
    if (safeNumber(e?.attack_SN) > 0) {
      return { key: 'atk', label: '공격력', sn: e.attack_SN };
    }

    if (safeNumber(e?.healthPoint_SN) > 0) {
      return { key: 'hp', label: '체력', sn: e.healthPoint_SN };
    }

    if (safeNumber(e?.defence_SN) > 0) {
      return { key: 'def', label: '방어력', sn: e.defence_SN };
    }

    return { key: '', label: '-', sn: 0 };
  }

  calcEquipStatRange(equipSN, growthSN, maxLevel = 80) {
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

  calcMainStatWithGrowth(e, growthRec) {
    const main = this.resolveMainStat(e);

    if (!main.key || !growthRec) {
      return { label: main.label, min: '-', max: '-' };
    }

    let growthSN = 0;
    if (main.key === 'atk') {
      growthSN = growthRec.gAtk_SN;
    }
    if (main.key === 'hp') {
      growthSN = growthRec.gHp_SN;
    }
    if (main.key === 'def') {
      growthSN = growthRec.gDef_SN;
    }

    if (!growthSN) {
      const v = Math.round(main.sn / 10000);
      return { label: main.label, min: v, max: v };
    }

    const r = this.calcEquipStatRange(main.sn, growthSN);

    return {
      label: main.label,
      min: r.min,
      max: r.max
    };
  }

  // 장비 분류별 고정 옵션 최대(현행 유지)
  getFixedOptionMax(category) {
    if (category === '장신구') {
      return 6;
    }

    return 4;
  }

  // -------------------------
  // Fixed 옵션(고정 스킬)
  // -------------------------

  pickSkillIds(listLike) {
    const ids = [];
    for (const it of Array.isArray(listLike) ? listLike : []) {
      const sid = safeNumber(it?.skillId);
      if (sid) {
        ids.push(sid);
      }
    }

    return ids;
  }

  resolveFixedSkills(equipRaw) {
    const skillById = this.skillById;
    if (!skillById) {
      return [];
    }

    const fixedIds = this.pickSkillIds(equipRaw?.skillList);
    const out = [];

    for (const sid of fixedIds) {
      const rec = skillById.get(sid);
      if (rec) {
        out.push(rec);
      }
    }

    return out;
  }

  // -------------------------
  // Random 옵션 풀 (lazy)
  // -------------------------

  getRandomPools(equipId) {
    const id = safeNumber(equipId);
    if (id === null) {
      return [];
    }

    if (!this.randomPoolsByEquipId) {
      this.randomPoolsByEquipId = new Map();
    }

    if (this.randomPoolsByEquipId.has(id)) {
      return this.randomPoolsByEquipId.get(id) || [];
    }

    const rec = this.getById(id);
    if (!rec || !rec.raw) {
      this.randomPoolsByEquipId.set(id, []);
      return [];
    }

    const pools = this.buildRandomOptionPools(rec.raw);
    this.randomPoolsByEquipId.set(id, pools);

    return pools;
  }

  pickCampTagIds(skillRec) {
    const out = [];
    const list = Array.isArray(skillRec?.campList) ? skillRec.campList : [];

    for (const it of list) {
      const n = safeNumber(it) ?? safeNumber(it?.id) ?? safeNumber(it?.tagId) ?? safeNumber(it?.name) ?? null;
      if (n) {
        out.push(n);
      }
    }

    return Array.from(new Set(out));
  }

  pickSpecialTagIds(skillRec) {
    const out = [];
    const list = Array.isArray(skillRec?.specialTagList) ? skillRec.specialTagList : [];

    for (const it of list) {
      if (typeof it === 'number') {
        const n = safeNumber(it);
        if (n) out.push(n);
        continue;
      }

      const n = safeNumber(it?.specialTag) ?? safeNumber(it?.tagId) ?? safeNumber(it?.id) ?? safeNumber(it?.name) ?? null;
      if (n) {
        out.push(n);
      }
    }

    return Array.from(new Set(out));
  }

  resolvePoolLabelFromSkillRec(skillRec) {
    const tagById = this.tagById;
    if (!tagById) {
      return '';
    }

    // 1) campList 우선
    const campIds = this.pickCampTagIds(skillRec);
    for (const tid of campIds) {
      const t = tagById.get(tid) || null;
      if (!t) {
        continue;
      }

      const sideName = String(t?.sideName || '').trim();
      if (sideName) {
        return sideName;
      }
    }

    // 2) specialTagList
    const spIds = this.pickSpecialTagIds(skillRec);
    for (const tid of spIds) {
      const t = tagById.get(tid) || null;
      if (!t) {
        continue;
      }

      const sideName = String(t?.sideName || '').trim();
      if (sideName) {
        return sideName;
      }
    }

    return '';
  }

  // 반환 형식(기존 유지):
  // [{ poolId, weight, refType, listRec, faction(Map<label, SkillRec[]>), common(SkillRec[]) }]
  buildRandomOptionPools(equipRaw) {
    const listById = this.listById;
    const skillById = this.skillById;

    if (!listById || !skillById) {
      return [];
    }

    const pools = [];
    const src = Array.isArray(equipRaw?.randomSkillList) ? equipRaw.randomSkillList : [];

    for (const p of src) {
      const poolId = safeNumber(p?.skillId);
      if (!poolId) {
        continue;
      }

      const listRec = listById.get(poolId) || null;
      if (!listRec) {
        continue;
      }

      const weight = safeNumber(p?.weight) ?? 1;

      const faction = new Map(); // label -> SkillRec[]
      const common = [];

      const entries = Array.isArray(listRec?.EquipmentEntryList) ? listRec.EquipmentEntryList : [];
      for (const ent of entries) {
        const sid = safeNumber(ent?.id);
        if (!sid) {
          continue;
        }

        const skillRec = skillById.get(sid) || null;
        if (!skillRec) {
          continue;
        }

        const label = this.resolvePoolLabelFromSkillRec(skillRec);
        if (label) {
          if (!faction.has(label)) {
            faction.set(label, []);
          }
          faction.get(label).push(skillRec);
        } else {
          common.push(skillRec);
        }
      }

      pools.push({
        poolId,
        weight,
        refType: 'list',
        listRec,
        faction,
        common
      });
    }

    return pools;
  }

  // -------------------------
  // build: recMap (UI 표시용 최소)
  // -------------------------

  resolveFactionAndCategoryFromTags(raw) {
    const tagById = this.tagById;
    const equipTagId = safeNumber(raw?.equipTagId);
    const campTagId = safeNumber(raw?.campTagId);

    let category = '';
    let faction = '';

    if (tagById) {
      if (equipTagId && tagById.has(equipTagId)) {
        const t = tagById.get(equipTagId);
        category = String(t?.Name || t?.tagName || '').trim();
      }

      if (campTagId && tagById.has(campTagId)) {
        const t = tagById.get(campTagId);
        faction = String(t?.sideName || '').trim();
      }
    }

    return { faction: faction || '-', category: category || '-' };
  }

  resolveImageUrl(tipsPath) {
    const p0 = String(tipsPath || '').trim();
    if (!p0) {
      return '';
    }

    // 1) 정규화
    let p = normalizePathSlash(p0).replace(/^\/+/g, '');

    // 2) assets/ 제거
    p = p.replace(/^assets\//i, '');

    // 3) 이미 item/weapon 으로 시작하면 그대로 사용
    if (/^item\/weapon\//i.test(p)) {
      // 그대로 둠
    } else if (/^weapon\//i.test(p)) {
      p = `item/${p}`;
    } else {
      p = `item/weapon/${p}`;
    }

    // 4) 확장자 (지금은 png)
    const rel = /\.(png|jpg|jpeg|webp)$/i.test(p) ? p : `${p}.png`;

    // 5) 소문자 정규화
    return assetPath(rel.toLowerCase());
  }
}

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