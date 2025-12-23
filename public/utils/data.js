/**
 * data.js
 * - 팩토리 기반 데이터 처리 모음
 *
 * 규칙
 * - DOM 조작/렌더링 함수는 포함하지 않는다. fileciteturn7file1L9-L12
 * - '기본 유틸'(fetchJson, normalizePathSlash 등)은 utils.js에 두고, 여기서는 import해서 사용한다. fileciteturn7file1L9-L15
 */

import { fetchJson, normalizePathSlash } from './utils.js';
import { assetPath } from './path.js';

// =========================
// 1) 공용: 정규화 / 안전 변환
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

// 안전한 숫자 변환 (실패 시 null)
// - Map key, 비교 등에 사용
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

// TagFactory가 없을 때만 쓰는 최소 fallback
function parseFactionCategoryFromIdCN(idCN) {
  const raw = normalizePathSlash(idCN);
  const parts = raw
    .split('/')
    .map((s) => String(s).trim())
    .filter(Boolean);

  // 예: 学会装备/橙/武器/xxxx
  const factionCN = (parts[0] || '').replace(/装备$/u, '');
  const categoryCN = parts[2] || '';

  // fallback은 "원문 그대로" (번역은 TagFactory가 담당)
  return {
    faction: factionCN || '-',
    category: categoryCN || '-'
  };
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
    // 장비 분류는 Name으로 들어있는 케이스 확인됨 (예: 무기/장신구)
    const v = String(tagRec?.Name || tagRec?.tagName || '').trim();
    return v || '';
  }

  resolveFactionName(tagRec) {
    // 진영은 sideName으로 들어있는 케이스 확인됨
    const v = String(tagRec?.sideName || '').trim();
    return v || '';
  }
}

// =========================
// 5) EquipmentFactory (요청사항 반영)
// - parseEquipmentIdCN 제거: equipTagId/campTagId -> TagFactory로 해석
// - randomSkillList.skillId는 SkillFactory 또는 ListFactory 둘 다 가능 fileciteturn7file0L28-L38
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

  // -------------------------
  // UI 보조: 스탯 계산 (현행 유지)
  // - GrowthFactory 쪽에 계산식이 별도 등록돼 있진 않아서(등록 파일에 공식 식 없음) 기존 식 유지
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

    // 기존 data.js 가정 유지 fileciteturn7file2L18-L34
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
  // Skill/Random 옵션 해석
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

  // 랜덤 옵션(스킬) 분류
  // 1) SkillFactory.specialTagList -> TagFactory 를 우선 사용 (구조 기반)
  // 2) (임시) tag 기반 분류가 불가하면 idCN 문자열로 fallback
  // - randomSkillList.skillId는 SkillFactory 또는 ListFactory 참조 가능 fileciteturn7file0L28-L38
  // - SkillFactory에는 specialTagList(detail=specialTag) / specialTag(arg0=TagFactory) 정의가 있음 fileciteturn7file0L0-L0
  classifyPoolKind(skillRec) {
    const tagById = this.tagById;

    // 1) 태그 기반 분류
    if (tagById) {
      const ids = this.pickSpecialTagIds(skillRec);
      if (ids.length > 0) {
        // '阵营' 계열 태그가 있으면 소속으로 판정
        for (const tid of ids) {
          const t = tagById.get(tid) || null;
          if (!t) {
            continue;
          }

          const mod = String(t?.mod || '').trim();
          const idCN = String(t?.idCN || '').trim();

          // 소속 태그 판정: mod=阵营 또는 idCN이 '阵营标签/'로 시작하거나 sideName이 존재
          const sideName = String(t?.sideName || '').trim();
          const name = String(t?.Name || t?.tagName || '').trim();

          const isFaction = mod === '阵营' || idCN.startsWith('阵营标签/') || !!sideName;
          if (isFaction) {
            return {
              kind: 'faction',
              label: sideName || name || '소속',
              tagIds: ids
            };
          }

          // 공용 판정: idCN/Name에 '通用'이 포함
          const isCommon =
            idCN.includes('通用') ||
            name.includes('通用') ||
            String(t?.tagName || '').includes('通用');

          if (isCommon) {
            return { kind: 'common', label: '공용', tagIds: ids };
          }
        }

        // 태그는 있는데 소속/공용을 확정 못하면 unknown으로 둠
        return { kind: 'unknown', label: '기타', tagIds: ids };
      }
    }

    // 2) fallback: idCN 문자열 기반(기존 임시 로직 유지)
    {
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
  }

  pickSpecialTagIds(skillRec) {
    // SkillFactory.specialTagList 형태가 다양할 수 있어서 넓게 처리
    // - [number]
    // - [{ specialTag: number }]
    // - [{ id: number }]
    const out = [];

    const list = Array.isArray(skillRec?.specialTagList) ? skillRec.specialTagList : [];
    for (const it of list) {
      if (typeof it === 'number') {
        const n = safeNumber(it);
        if (n) out.push(n);
        continue;
      }

      const n =
        safeNumber(it?.specialTag) ??
        safeNumber(it?.tagId) ??
        safeNumber(it?.id) ??
        null;

      if (n) {
        out.push(n);
      }
    }

    // 중복 제거
    return Array.from(new Set(out));
  }

  resolveFixedSkills(equipRaw) {
    const skillById = this.skillById;
    if (!skillById) {
      return [];
    }

    // skillList.skillId -> SkillFactory.id fileciteturn7file0L15-L25
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

  // randomSkillList.skillId -> SkillFactory 또는 ListFactory fileciteturn7file0L28-L38
  resolveRandomSkillRefId(entry) {
    const id = safeNumber(entry?.skillId);
    if (!id) {
      return { ref: 'none', id: 0 };
    }

    const listById = this.listById;
    const skillById = this.skillById;

    if (listById && listById.has(id)) {
      return { ref: 'list', id };
    }

    if (skillById && skillById.has(id)) {
      return { ref: 'skill', id };
    }

    // 컨텍스트가 아직 안 로드된 경우/미스: 우선 list 우선으로 취급 (기존 로직과 충돌 최소화)
    return { ref: 'unknown', id };
  }

  // 반환 형식(기존 유지):
  // [{ poolId, weight, refType, listRec, directSkill, faction(Map<label, SkillRec[]>), common(SkillRec[]) }]
  buildRandomOptionPools(equipRaw) {
    const listById = this.listById;
    const skillById = this.skillById;

    if (!listById || !skillById) {
      return [];
    }

    const pools = [];
    const src = Array.isArray(equipRaw?.randomSkillList) ? equipRaw.randomSkillList : [];

    for (const p of src) {
      const weight = safeNumber(p?.weight) ?? 1;
      const refInfo = this.resolveRandomSkillRefId(p);

      // 1) ListFactory 풀
      if (refInfo.ref === 'list' || refInfo.ref === 'unknown') {
        const poolId = refInfo.id;
        const listRec = listById.get(poolId);
        if (!listRec) {
          // unknown인데 list에도 없으면 다음 케이스로 넘김
        } else {
          const faction = new Map(); // label -> SkillRec[]
          const common = [];

          // ListFactory.EquipmentEntryList[].id -> SkillFactory.id (lua에 명시) fileciteturn7file0L28-L38
          const entries = Array.isArray(listRec?.EquipmentEntryList) ? listRec.EquipmentEntryList : [];
          for (const ent of entries) {
            const sid = safeNumber(ent?.id);
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

          pools.push({
            poolId,
            weight,
            refType: 'list',
            listRec,
            directSkill: null,
            faction,
            common
          });

          continue;
        }
      }

      // 2) SkillFactory 직접 참조
      if (refInfo.ref === 'skill') {
        const sid = refInfo.id;
        const skillRec = skillById.get(sid) || null;

        pools.push({
          poolId: sid,
          weight,
          refType: 'skill',
          listRec: null,
          directSkill: skillRec,
          faction: new Map(),
          common: skillRec ? [skillRec] : []
        });

        continue;
      }
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
        category = String(t?.Name || '').trim();
      }

      if (campTagId && tagById.has(campTagId)) {
        const t = tagById.get(campTagId);
        faction = String(t?.sideName || '').trim();
      }
    }

    if (!category || !faction) {
      const fb = parseFactionCategoryFromIdCN(raw?.idCN || '');
      if (!faction) faction = fb.faction;
      if (!category) category = fb.category;
    }

    return { faction: faction || '-', category: category || '-' };
  }

  resolveImageUrl(tipsPath) {
    const p = String(tipsPath || '').trim();
    if (!p) {
      return '';
    }

    // tipsPath가 이미 'item/weapon/xxx' 형태면 그대로
    // 아니면 item/weapon 아래로
    const rel = p.startsWith('item/')
      ? p
      : joinPath('item/weapon', p);

    // 확장자 없으면 .webp
    const file = /\.(png|webp|jpg|jpeg)$/i.test(rel)
      ? rel
      : `${rel}.webp`;

    return assetPath(file);
  }

  buildEquipmentRecMapFromRaw(equipJsonRaw) {
    const list = normalizeRootJson(equipJsonRaw);
    const out = new Map();

    for (const raw of list) {
      const id = safeNumber(raw?.id);
      if (id === null) {
        continue;
      }

      const rarity = mapQualityToRarity(raw?.quality);
      const fc = this.resolveFactionAndCategoryFromTags(raw);

      let mainStat = null;
      if (this.growthById) {
        const growthId = safeNumber(raw?.growthId);
        const growthRec = growthId === null ? null : this.growthById.get(growthId) || null;
        mainStat = this.calcMainStatWithGrowth(raw, growthRec);
      }

           // tipsPath 후보(데이터 케이스 다양) - 일단 가장 흔한 필드부터
      const tipsPath = String(raw?.tipsPath || raw?.iconPath || raw?.icon || raw?.imagePath || '').trim();

      // 이미지 URL은 assetPath + tipsPath 규칙으로 팩토리에서 결정
      const imageUrl = this.resolveImageUrl(tipsPath);

      // mainOption: 고정 스킬 중 첫 번째 description
      let mainOption = '';
      {
        const fixed = this.resolveFixedSkills(raw); // SkillRec[] 
        const first = Array.isArray(fixed) && fixed.length > 0 ? fixed[0] : null;
        if (first) {
          // SkillFactory.resolveSkillDesc와 동일 규칙 
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

    return out;
  }
}
