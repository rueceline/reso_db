// scripts/lib.js
// Small shared utilities: io + normalize + translation + minimal helpers

import fs from "fs";
import path from "path";

// ---------- IO ----------
export function readJson(absPath) {
  return JSON.parse(fs.readFileSync(absPath, "utf-8"));
}

export function writeJson(absPath, data) {
  fs.mkdirSync(path.dirname(absPath), { recursive: true });
  fs.writeFileSync(absPath, JSON.stringify(data, null, 2), "utf-8");
}

// ---------- Normalize ----------
export function normalizePathSlash(p) {
  return String(p || "").replace(/\\/g, "/");
}

export function normalizeRootJson(raw) {
  if (Array.isArray(raw)) return raw;
  if (raw && typeof raw === "object") {
    if (Array.isArray(raw.list)) return raw.list;
    if (Array.isArray(raw.data)) return raw.data;
    if (Array.isArray(raw.items)) return raw.items;
  }
  return [];
}

export function safeNumber(v) {
  if (v === null || v === undefined) return null;
  const n = Number(v);
  return Number.isFinite(n) ? n : null;
}

export function buildIdMap(list) {
  const map = new Map();
  for (const r of list) {
    const id = safeNumber(r?.id);
    if (id === null) continue;

    if (!map.has(id)) {
      map.set(id, r);
    }
  }
  return map;
}

export function normText(s) {
  return String(s).replace(/\r\n/g, "\n").replace(/\r/g, "\n");
}

// ---------- ConfigLanguage (factory/field mapping) ----------
export function loadConfigLanguage(cfgAbsPath) {
  const cfg = readJson(cfgAbsPath) || {};

  // Add normalized-key variants (CRLF -> LF) for safer 1:1 matching.
  for (const factoryName of Object.keys(cfg)) {
    const facObj = cfg[factoryName];
    if (!facObj || typeof facObj !== "object" || Array.isArray(facObj)) continue;

    for (const fieldName of Object.keys(facObj)) {
      const mapping = facObj[fieldName];
      if (!mapping || typeof mapping !== "object" || Array.isArray(mapping)) continue;

      const add = {};
      for (const [zh, ko] of Object.entries(mapping)) {
        if (typeof zh !== "string" || typeof ko !== "string" || ko === "") continue;

        const nzh = normText(zh);
        const nko = normText(ko);

        if (nzh !== zh && !Object.prototype.hasOwnProperty.call(mapping, nzh)) {
          add[nzh] = nko;
        }
      }

      for (const [k, v] of Object.entries(add)) {
        mapping[k] = v;
      }
    }
  }

  return cfg;
}

export function tr(cfg, factoryName, fieldName, textCN) {
  if (textCN === null || textCN === undefined) return textCN;

  const src = String(textCN);
  if (!src) return src;

  const facObj = cfg?.[factoryName];
  const mapping = facObj?.[fieldName];

  if (!mapping || typeof mapping !== "object") {
    return src;
  }

  if (Object.prototype.hasOwnProperty.call(mapping, src)) {
    return mapping[src];
  }

  const n = normText(src);
  if (Object.prototype.hasOwnProperty.call(mapping, n)) {
    return mapping[n];
  }

  return src; // 누락은 미번역이므로 그대로
}

// ---------- Equipment helpers ----------
export function mapQualityToRarity(quality) {
  const m = {
    Orange: "UR",
    Golden: "SSR",
    Purple: "SR",
    Blue: "R",
    White: "N",
  };
  return m[String(quality)] || "-";
}

export function resolveMainStat(e) {
  if ((safeNumber(e?.attack_SN) ?? 0) > 0) return { key: "atk", label: "공격력", sn: e.attack_SN };
  if ((safeNumber(e?.healthPoint_SN) ?? 0) > 0) return { key: "hp", label: "체력", sn: e.healthPoint_SN };
  if ((safeNumber(e?.defence_SN) ?? 0) > 0) return { key: "def", label: "방어력", sn: e.defence_SN };
  return { key: "", label: "-", sn: 0 };
}

export function calcEquipStatRange(equipSN, growthSN, maxLevel = 80) {
  const equipBase = equipSN / 10000;
  const growthInitial = growthSN / 1000;
  const perLevel = growthSN / 10000;

  const growthMax = growthInitial + perLevel * (maxLevel - 1);
  const delta = equipBase - growthInitial;

  return {
    min: Math.round(equipBase),
    max: Math.round(growthMax + delta),
  };
}

export function calcMainStatWithGrowth(e, growthRec) {
  const main = resolveMainStat(e);

  if (!main.key || !growthRec) {
    return { label: main.label, min: "-", max: "-" };
  }

  let growthSN = 0;
  if (main.key === "atk") growthSN = growthRec.gAtk_SN;
  if (main.key === "hp") growthSN = growthRec.gHp_SN;
  if (main.key === "def") growthSN = growthRec.gDef_SN;

  if (!growthSN) {
    const v = Math.round(main.sn / 10000);
    return { label: main.label, min: v, max: v };
  }

  const r = calcEquipStatRange(main.sn, growthSN);
  return { label: main.label, min: r.min, max: r.max };
}

export function normalizeAcquireText(e) {
  const gw = e?.Getway;
  if (Array.isArray(gw)) {
    const names = [];
    for (const it of gw) {
      const s = String(it?.DisplayName ?? "").trim();
      if (s) names.push(s);
    }
    return names.join(" / ");
  }

  return String(e?.obtain ?? e?.acquire ?? e?.getPath ?? e?.gain ?? "").trim();
}

export function pickFirstFixedSkillId(skillList) {
  const list = Array.isArray(skillList) ? skillList : [];
  for (const it of list) {
    const sid = safeNumber(it?.skillId);
    if (sid) return sid;
  }
  return null;
}

// ListFactory: EquipmentEntryList[*].id => skillId
export function pickSkillIdsFromListRec(listRec) {
  const out = [];
  const entries = Array.isArray(listRec?.EquipmentEntryList) ? listRec.EquipmentEntryList : [];

  for (const ent of entries) {
    const sid = safeNumber(ent?.id);
    if (sid) out.push(sid);
  }

  if (out.length > 0) {
    return Array.from(new Set(out));
  }

  // fallback for schema drift
  for (const k of Object.keys(listRec || {})) {
    const v = listRec[k];
    if (!Array.isArray(v)) continue;

    if (String(k).toLowerCase().includes("entry")) {
      for (const it of v) {
        const sid = safeNumber(it?.id) ?? safeNumber(it?.skillId) ?? safeNumber(it?.value) ?? null;
        if (sid) out.push(sid);
      }
    }
  }

  return Array.from(new Set(out));
}

// Skill faction label (for EquipmentSkillVM)
export function pickCampTagIds(skillRec) {
  const out = [];
  const list = Array.isArray(skillRec?.campList) ? skillRec.campList : [];

  for (const it of list) {
    const n = safeNumber(it) ?? safeNumber(it?.id) ?? safeNumber(it?.tagId) ?? safeNumber(it?.name) ?? null;
    if (n) out.push(n);
  }

  return Array.from(new Set(out));
}

export function pickSpecialTagIds(skillRec) {
  const out = [];
  const list = Array.isArray(skillRec?.specialTagList) ? skillRec.specialTagList : [];

  for (const it of list) {
    if (typeof it === "number") {
      const n = safeNumber(it);
      if (n) out.push(n);
      continue;
    }

    const n =
      safeNumber(it?.specialTag) ??
      safeNumber(it?.tagId) ??
      safeNumber(it?.id) ??
      safeNumber(it?.name) ??
      null;

    if (n) out.push(n);
  }

  return Array.from(new Set(out));
}

export function resolveFactionLabelFromSkillRec(skillRec, tagById) {
  // 규칙:
  // - campList가 "정확히 1개"일 때만 소속으로 판정
  // - 그 외(0개/2개 이상/불명확)는 전부 공용(common) 처리
  // - skillRec.sideName, specialTagList는 소속 판정에서 사용하지 않음

  const raw = Array.isArray(skillRec?.campList) ? skillRec.campList : [];

  const ids = [];
  for (const it of raw) {
    const n = safeNumber(it) ?? safeNumber(it?.id) ?? safeNumber(it?.tagId) ?? safeNumber(it?.name) ?? null;
    if (n) ids.push(n);
  }

  const uniq = Array.from(new Set(ids));

  if (uniq.length !== 1) {
    return "";
  }

  const t = tagById.get(uniq[0]) || null;
  if (!t) {
    return "";
  }

  const sideName = String(t?.sideName || "").trim();
  return sideName || "";
}


