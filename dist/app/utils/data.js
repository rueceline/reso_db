/**
 * data.js
 * - 팩토리 기반 데이터 처리 모음
 *   1) 데이터 정규화 / 인덱스(Map) 구성
 *   2) 팩토리 파싱(idCN 등)
 *   3) 단어/표기 변환(매핑)
 *   4) 팩토리 기반 계산식(성장/스탯)
 *
 * 규칙
 * - DOM 조작/렌더링 함수는 포함하지 않는다.
 * - '기본 유틸' (예: normalizePathSlash)는 utils.js에 두고, 여기서는 import해서 사용한다.
 */

import { normalizePathSlash } from './utils.js';
import { fetchJson } from './fetch.js';

// =========================
// 1) 단어/표기 변환(매핑)
// =========================

export const qualityToRarityMap = {
  Orange: 'UR',
  Golden: 'SSR',
  Purple: 'SR',
  Blue: 'R',
  White: 'N'
};

export const factionMap = {
  铁盟: '철도연맹',
  混沌海: '혼돈해',
  学会: '시타델',
  黑月: '흑월',
  帝国: '제국',
  ANITA: '아니타'
};

export const categoryMap = {
  武器: '무기',
  护甲: '방어구',
  挂件: '장신구'
};

export function mapQualityToRarity(quality) {
  return qualityToRarityMap[String(quality)] || '-';
}

// =========================
// 2) 데이터 정규화 / 인덱스(Map) 구성
// =========================

export function normalizeRootJson(json) {
  if (Array.isArray(json)) {
    return json;
  }

  if (json && Array.isArray(json.data)) {
    return json.data;
  }

  return [];
}

// =========================
// 안전한 숫자 변환 (실패 시 null)
// - Map key, 비교 등에 사용
// =========================

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
// ListFactory
// - 각종 id 목록
// =========================

export class ListFactory {
  constructor(opt = {}) {
    this.listUrl = opt.listUrl || null;

    this.mapById = null; // Map<number, ListRec>
    this.loadingPromise = null;
  }

  async load() {
    if (this.mapById) {
      return this.mapById;
    }

    if (this.loadingPromise) {
      return await this.loadingPromise;
    }

    if (!this.listUrl) {
      throw new Error('ListFactory: listUrl이 설정되지 않았습니다.');
    }

    this.loadingPromise = (async () => {
      const json = await fetchJson(this.listUrl);
      // ListFactory/GrowthFactory 류는 buildListMaps를 공용으로 사용
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
// EquipmentFactory
// =========================

export class EquipmentFactory {
  constructor(opt = {}) {
    this.equipmentUrl = opt.equipmentUrl || null;

    this.growthById = opt.growthById || null;
    this.skillById = opt.skillById || null;
    this.listById = opt.listById || null;

    this.recMap = null;
    this.loadingPromise = null;
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
      this.recMap = this.buildEquipmentRecMapFromRaw(equipJson);
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

  setContext(ctx = {}) {
    if (ctx.growthById) this.growthById = ctx.growthById;
    if (ctx.skillById) this.skillById = ctx.skillById;
    if (ctx.listById) this.listById = ctx.listById;
  }

  invalidate() {
    this.recMap = null;
    this.loadingPromise = null;
  }

  // =========================
  // 3) 팩토리 파싱
  // =========================

  parseEquipmentIdCN(idCN) {
    const raw = normalizePathSlash(idCN);
    const parts = raw
      .split('/')
      .map((s) => String(s).trim())
      .filter(Boolean);

    const factionCN = (parts[0] || '').replace(/装备$/u, '');
    const categoryCN = parts[2] || '';

    return {
      faction: factionMap[factionCN] || factionCN || '-',
      category: categoryMap[categoryCN] || categoryCN || '-'
    };
  }

  // =========================
  // 4) 팩토리 기반 계산식
  // =========================

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

  getFixedOptionMax(category) {
    if (category === '장신구') {
      return 6;
    }

    return 4;
  }

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

  // listRec 기반으로 소속/공용 분류 (현재 equipment_detail.js 로직 그대로)
  classifyPoolKind(skillRec) {
    const idcn = String(skillRec?.idCN ?? '');
    const parts = idcn
      .split('/')
      .map((s) => s.trim())
      .filter(Boolean);

    const isRandomAffix = parts.length > 0 && parts[0].includes('随机词条');
    if (!isRandomAffix) {
      return { kind: 'common', label: '공용' };
    }

    if (parts.some((p) => p.includes('通用'))) return { kind: 'common', label: '공용' };
    if (parts.some((p) => p.includes('铁盟'))) return { kind: 'faction', label: '철도연맹' };
    if (parts.some((p) => p.includes('学会'))) return { kind: 'faction', label: '시타델' };
    if (parts.some((p) => p.includes('商会'))) return { kind: 'faction', label: '상회' };
    if (parts.some((p) => p.includes('黑月'))) return { kind: 'faction', label: '흑월' };

    return { kind: 'faction', label: '소속' };
  }

  // 이름: 우선 번역 name만 (equipment_detail.js 로직 동일)
  resolveSkillName(skillRec) {
    return String(skillRec?.name || '').trim();
  }

  // 설명: description 우선, 없으면 tempdescription
  resolveSkillDesc(skillRec) {
    return String(skillRec?.description || skillRec?.tempdescription || '').trim();
  }

  /**
   * 고정 옵션 스킬 레코드 배열 반환
   * - equipRaw.skillList[].skillId -> SkillFactory.id
   */
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

  /**
   * 랜덤 옵션 풀 구성
   * - equipRaw.randomSkillList[].skillId -> ListFactory.id (poolId)
   * - listRec.EquipmentEntryList[].id    -> SkillFactory.id
   *
   * 반환 형식은 equipment_detail.js가 쓰던 것과 동일:
   * [{ poolId, listRec, faction(Map<label, SkillRec[]>), common(SkillRec[]) }]
   */
  buildRandomOptionPools(equipRaw) {
    const listById = this.listById;
    const skillById = this.skillById;

    if (!listById || !skillById) {
      return [];
    }

    const pools = [];
    const src = Array.isArray(equipRaw?.randomSkillList) ? equipRaw.randomSkillList : [];

    for (const p of src) {
      const poolId = Number(p?.skillId ?? 0);
      if (!poolId) {
        continue;
      }

      const listRec = listById.get(poolId);
      if (!listRec) {
        continue;
      }

      const faction = new Map(); // label -> SkillRec[]
      const common = [];

      const entries = Array.isArray(listRec?.EquipmentEntryList) ? listRec.EquipmentEntryList : [];
      for (const ent of entries) {
        const sid = Number(ent?.id ?? 0);
        if (!sid) {
          continue;
        }

        const skillRec = skillById.get(sid);
        if (!skillRec) {
          continue;
        }

        const cls = this.classifyPoolKind(skillRec);

        if (cls.kind === 'faction') {
          const key = cls.label || '소속';
          if (!faction.has(key)) {
            faction.set(key, []);
          }
          faction.get(key).push(skillRec);
        } else {
          common.push(skillRec);
        }
      }

      pools.push({ poolId, listRec, faction, common });
    }

    return pools;
  }

  // =========================
  // 5) 빌드(클래스 내부 일원화)
  // =========================

  buildEquipmentRecMapFromRaw(equipJsonRaw) {
    const list = normalizeRootJson(equipJsonRaw);
    const out = new Map();

    for (const raw of list) {
      const id = safeNumber(raw?.id);
      if (id === null) {
        continue;
      }

      const idCN = String(raw?.idCN || '');
      const parsed = this.parseEquipmentIdCN(idCN);
      const rarity = this.mapQualityToRarity(raw?.quality);

      let mainStat = null;
      if (this.growthById) {
        const growthId = safeNumber(raw?.growthId);
        const growthRec = growthId === null ? null : this.growthById.get(growthId) || null;
        mainStat = this.calcMainStatWithGrowth(raw, growthRec);
      }

      const rec = {
        id,
        idCN,
        raw,
        name: String(raw?.name || ''),
        rarity,
        faction: parsed.faction,
        category: parsed.category,
        mainStat
      };

      out.set(id, rec);
    }

    return out;
  }
}

// =========================
// 6) Skill / List / Growth Factory (로딩 + 캐시)
// =========================

export class SkillFactory {
  constructor(opt = {}) {
    this.skillUrl = opt.skillUrl || null;

    this.mapById = null; // Map<number, SkillRec>
    this.loadingPromise = null;
  }

  async load() {
    if (this.mapById) {
      return this.mapById;
    }

    if (this.loadingPromise) {
      return await this.loadingPromise;
    }

    if (!this.skillUrl) {
      throw new Error('SkillFactory: skillUrl이 설정되지 않았습니다.');
    }

    this.loadingPromise = (async () => {
      const json = await fetchJson(this.skillUrl);
      this.mapById = buildIdMapFromRootJson(json); // id -> skillRec
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

export class GrowthFactory {
  constructor(opt = {}) {
    this.growthUrl = opt.growthUrl || null;

    this.mapById = null; // Map<number, GrowthRec>
    this.loadingPromise = null;
  }

  async load() {
    if (this.mapById) {
      return this.mapById;
    }

    if (this.loadingPromise) {
      return await this.loadingPromise;
    }

    if (!this.growthUrl) {
      throw new Error('GrowthFactory: growthUrl이 설정되지 않았습니다.');
    }

    this.loadingPromise = (async () => {
      const json = await fetchJson(this.growthUrl);
      // GrowthFactory도 id -> record Map이면 충분 (EquipmentFactory가 gAtk_SN/gHp_SN/gDef_SN만 사용)
      this.mapById = buildIdMapFromRootJson(json); // id -> growthRec
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
