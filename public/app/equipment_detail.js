import {
  parseIdCN,
  mapQualityToRarity,
  calcMainStatWithGrowth,
  getFixedOptionMax,
} from './utils/utils.js';

const BASE = (window.getAppBase && window.getAppBase()) || '/';

const DATA_URL = `${BASE}public/data/KR/EquipmentFactory.json`;
const GROWTH_URL = `${BASE}public/data/KR/GrowthFactory.json`;
const SKILL_URL = `${BASE}public/data/KR/SkillFactory.json`;
const LIST_URL = `${BASE}public/data/KR/ListFactory.json`;

const ASSET_SMALL_BASE = `${BASE}public/assets/item/weapon`;

function getQueryParam(name) {
  const u = new URL(location.href);
  return u.searchParams.get(name);
}

function safeNumber(v) {
  const n = Number(v);
  return Number.isFinite(n) ? n : 0;
}

function normalizeNewlines(s) {
  return (s || "").replace(/\\n/g, "\n");
}

function escapeHtml(s) {
  return (s || "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#39;");
}

// <color=#RRGGBB>text</color> -> span
function formatColorTagsToHtml(s) {
  const src = normalizeNewlines(s);
  if (!src) return "";

  // escape first, then re-inject spans
  let out = escapeHtml(src);

  // (1) opening tag
  out = out.replaceAll(/&lt;color=#([0-9A-Fa-f]{6})&gt;/g, '<span style="color:#$1">');

  // (2) closing tag
  out = out.replaceAll(/&lt;\/color&gt;/g, "</span>");

  // keep line breaks
  out = out.replaceAll("\n", "<br>");
  return out;
}

async function fetchJson(url) {
  const res = await fetch(url, { cache: "no-store" });
  if (!res.ok) {
    throw new Error("fetch failed: " + res.status + " " + url);
  }
  return await res.json();
}

function setText(id, text) {
  const el = document.getElementById(id);
  if (!el) return;
  el.textContent = text ?? "";
}

function setHtml(id, html) {
  const el = document.getElementById(id);
  if (!el) return;
  el.innerHTML = html || "";
}

function clearChildren(el) {
  while (el && el.firstChild) {
    el.removeChild(el.firstChild);
  }
}

function pickSkillIds(listLike) {
  const ids = [];
  for (const it of (Array.isArray(listLike) ? listLike : [])) {
    const sid = safeNumber(it?.skillId);
    if (sid) ids.push(sid);
  }
  return ids;
}

function buildSkillMaps(skillJson) {
  const list = Array.isArray(skillJson) ? skillJson : (Array.isArray(skillJson?.data) ? skillJson.data : []);
  const byId = new Map();
  for (const s of list) {
    const id = safeNumber(s?.id);
    if (id) byId.set(id, s);
  }
  return byId;
}

function buildListMaps(growthJson) {
  const list = Array.isArray(growthJson) ? growthJson : (Array.isArray(growthJson?.data) ? growthJson.data : []);
  const byId = new Map();
  for (const r of list) {
    const id = safeNumber(r?.id);
    if (id) byId.set(id, r);
  }
  return byId;
}

function buildRandomOptionPools(e, listById, skillById) {
  const pools = [];
  const src = Array.isArray(e?.randomSkillList) ? e.randomSkillList : [];

  for (const p of src) {
    const poolId = Number(p?.skillId ?? 0); // EquipmentFactory.randomSkillList.skillId -> ListFactory.id
    if (!poolId) { continue; }

    const listRec = listById.get(poolId);
    if (!listRec) { continue; }

    const faction = new Map(); // label -> [{skillRec}]
    const common = [];

    const entries = Array.isArray(listRec?.EquipmentEntryList) ? listRec.EquipmentEntryList : [];
    for (const ent of entries) {
      const sid = Number(ent?.id ?? 0); // ListFactory.EquipmentEntryList.id -> SkillFactory.id
      if (!sid) { continue; }

      const skillRec = skillById.get(sid);
      if (!skillRec) { continue; }

      const cls = classifyPoolKind(skillRec); // ✅ 여기서 분류

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


// listRec 기반으로 소속/공용만 구분(중국어 문자열은 표시하지 않음)
function classifyPoolKind(skillRec) {
  
  const idcn = String(skillRec?.idCN ?? '');
  const parts = idcn.split('/').map(s => s.trim()).filter(Boolean);

  // 랜덤 옵션(12随机词条) 계열이 아니면 분류를 보수적으로 처리
  // (캐릭/무기 스킬과 섞여있다고 했으니, 여기서 확실히 좁혀줌)
  const isRandomAffix = parts.length > 0 && parts[0].includes('随机词条');
  if (!isRandomAffix) {
    return { kind: 'common', label: '공용' };
  }  

  if (parts.some(p => p.includes('通用'))) return { kind: 'common', label: '공용' };
  if (parts.some(p => p.includes('铁盟'))) return { kind: 'faction', label: '철도연맹' };
  if (parts.some(p => p.includes('学会'))) return { kind: 'faction', label: '시타델' };
  if (parts.some(p => p.includes('商会'))) return { kind: 'faction', label: '상회' };
  if (parts.some(p => p.includes('黑月'))) return { kind: 'faction', label: '흑월' };

  return { kind: 'faction', label: '소속' };
}


function resolveSkillName(skill) {
  // 우선 name(번역본) -> description이름 비어있으면 idCN은 쓰지 않음
  const name = (skill?.name || "").trim();
  return name;
}

function resolveSkillDesc(skill) {
  const desc = (skill?.description || skill?.tempdescription || "").trim();
  return desc;
}

function createOptionRow(htmlText) {
  const row = document.createElement("div");
  row.className = "option-row";

  const body = document.createElement("div");
  body.className = "opt-body";
  body.innerHTML = htmlText;

  row.appendChild(body);
  return row;
}


function createSkillCard(skill, metaText) {
  const card = document.createElement("div");
  card.className = "skill-card";

  const skillName = resolveSkillName(skill);
  if (skillName) {
    const name = document.createElement("div");
    name.className = "skill-name";
    name.textContent = skillName;
    card.appendChild(name);
  }

  const desc = document.createElement("div");
  desc.className = "skill-desc";

  let d = String(resolveSkillDesc(skill) || "");

  // 템플릿 파라미터 치환:
  // - %s%% / %d%%  -> x%
  // - %s%  / %d%   -> x%
  // - %s   / %d    -> x
  // (공백 섞인 케이스까지 포함)
  d = d
    .replace(/%\s*[sd]\s*%%/g, "x%")
    .replace(/%\s*[sd]\s*%/g, "x%")
    .replace(/%\s*[sd]/g, "x");

  desc.innerHTML = formatColorTagsToHtml(d);  

  const meta = document.createElement("div");
  meta.className = "skill-meta muted";
  meta.textContent = metaText || "";

  card.appendChild(desc);

  if (metaText) {
    card.appendChild(meta);
  }

  return card;
}



function setImage(src) {
  const img = document.getElementById("equip-image");
  const fallback = document.getElementById("equip-image-fallback");
  if (!img || !fallback) return;

  if (src) {
    img.src = src;
    img.hidden = false;
    fallback.hidden = true;
  } else {
    img.removeAttribute("src");
    img.hidden = true;
    fallback.hidden = false;
  }
}

function buildWeaponImageUrl(pathLike) {
  const raw = normalizePathSlash(pathLike);
  const parts = raw.split('/').filter(Boolean);

  const idx = parts.findIndex(x => String(x).toLowerCase() === 'weapon');
  if (idx < 0 || parts.length < idx + 4) return '';

  const faction = String(parts[idx + 1] || '').toLowerCase();
  const size = String(parts[idx + 2] || '').toLowerCase();
  const file = String(parts[idx + 3] || '');

  if (!faction || !size || !file) return '';

  const filename = file.toLowerCase().endsWith('.png') ? file : `${file}.png`;
  return `${ASSET_SMALL_BASE.replace(/\/$/, '')}/${faction}/${size}/${filename}`;
}

function resolveEquipmentImageUrl(e) {
  return buildWeaponImageUrl(e?.tipsPath) || buildWeaponImageUrl(e?.iconPath) || '';
}

function normalizeAcquireText(e) {
  const gw = e?.Getway;
  if (Array.isArray(gw)) {
    const names = [];
    for (const it of gw) {
      const s = String(it?.DisplayName ?? "").trim();
      if (s) {
        names.push(s);
      }
    }
    return names.join(" / ");
  }

  // 혹시 문자열 필드로 들어오는 케이스 대비 (없으면 빈 값)
  const t = String(e?.obtain ?? e?.acquire ?? e?.getPath ?? e?.gain ?? "").trim();
  return t;
}

function getEquipFixedMax(e) {
  // 장신구면 6, 아니면 4
  // category 판정은 프로젝트에서 이미 쓰는 parseCategoryFromIdCN(e.idCN) 같은 게 있으면 그걸 쓰는 게 제일 안전함.
  const catRaw = (parseCategoryFromIdCN?.(e?.idCN) || "").toLowerCase();

  // 프로젝트 표기 케이스 대응 (필요하면 여기 문자열만 추가)
  const isAccessory =
    catRaw.includes("장신구") ||
    catRaw.includes("挂件") ||
    catRaw.includes("accessory");

  return isAccessory ? 6 : 4;
}

function formatFixedCountText(fixedMax) {
  return `옵션 수 1/${fixedMax}`;
}

function applyEquipmentToDom(e, ctx) {
  // 이름 / 메타 (레어리티, 분류, 소속, ID)
  setText("equip-name", (e?.name || "").trim() || "-");

  const rarity = mapQualityToRarity(e?.quality);
  const { category, faction } = parseIdCN(e?.idCN);
  const id = safeNumber(e?.id);

  // ✅ 레어리티는 별도 줄(크게)
  setText("equip-rarity", rarity);
  const rarityEl = document.getElementById("equip-rarity");
  if (rarityEl) {
    rarityEl.setAttribute("data-rarity", rarity || "-");
  }

  // ✅ 부가속성 줄(레어리티 제외)
  setText("equip-meta", `분류: 장비 > ${category} · 소속: ${faction} · ID: ${id}`);

  // stats (공격/HP/방어 중 1개만 보여주던 기존 규칙 유지)
  const atk = safeNumber(e?.attack_SN);
  const hp = safeNumber(e?.healthPoint_SN);
  const defv = safeNumber(e?.defence_SN);

  const growth = ctx.growthById.get(e?.growthId);
  const stat = calcMainStatWithGrowth(e, growth);

  setText("equip-stat-main", stat.label);
  setText("equip-stat-min", stat.min !== "-" ? stat.min.toLocaleString() : "-");
  setText("equip-stat-max", stat.max !== "-" ? stat.max.toLocaleString() : "-");

  // description
  setHtml("equip-description", formatColorTagsToHtml(e?.des || e?.description || ""));

  // image
  setImage(resolveEquipmentImageUrl(e));

  // fixed skills (top only)
  const fixedIds = pickSkillIds(e?.skillList);
  const fixedSkills = fixedIds.map(id => ctx.skillById.get(id)).filter(Boolean);

  const fixedMax = getFixedOptionMax(category);
  setText("fixed-skill-count", formatFixedCountText(fixedMax));

  const fixedList = document.getElementById("fixed-skill-list");
  if (fixedList) {
    clearChildren(fixedList);

    if (!fixedSkills.length) {
      const empty = document.createElement("div");
      empty.className = "muted";
      empty.textContent = "고정 옵션 없음";
      fixedList.appendChild(empty);
    } else {
      for (const s of fixedSkills) {
        // 고정 옵션은 '고정' 태그로만 표시
        fixedList.appendChild(createOptionRow(formatColorTagsToHtml(resolveSkillDesc(s))));

      }
    }
  }

  // acquire path (bottom)
  const acquire = normalizeAcquireText(e);
  const acquireEl = document.getElementById("equip-acquire");
  if (acquireEl) {
    clearChildren(acquireEl);

    const line = document.createElement("div");
    line.className = "acquire-item";
    line.textContent = acquire || "-";
    acquireEl.appendChild(line);
  }

  // random skills (bottom, under acquire)
  const pools = buildRandomOptionPools(e, ctx.listById, ctx.skillById);

  const factionEl = document.getElementById("random-skill-faction");
  const commonEl = document.getElementById("random-skill-common");
  if (factionEl) clearChildren(factionEl);
  if (commonEl) clearChildren(commonEl);

  let factionCount = 0;
  let commonCount = 0;

  for (const p of pools) {
    // 1) 소속 랜덤 옵션 (label 별)
    for (const [label, skills] of p.faction.entries()) {
      if (!skills.length) continue;

      // 섹션 제목
      const title = document.createElement("div");
      title.className = "random-skill-subtitle";
      title.textContent = `소속 - ${label}`;
      factionEl.appendChild(title);

      for (const skill of skills) {
        factionEl.appendChild(createSkillCard(skill, ""));
        factionCount += 1;
      }
    }

    // 2) 공용 랜덤 옵션
    for (const skill of p.common) {
      commonEl.appendChild(createSkillCard(skill, ""));
      commonCount += 1;
    }
  }

  setText("random-skill-count", `소속 ${factionCount} / 공용 ${commonCount}`);

  // empty states
  if (factionEl && !factionEl.childElementCount) {
    const empty = document.createElement("div");
    empty.className = "muted";
    empty.textContent = "소속 랜덤 옵션 없음";
    factionEl.appendChild(empty);
  }

  if (commonEl && !commonEl.childElementCount) {
    const empty = document.createElement("div");
    empty.className = "muted";
    empty.textContent = "공용 랜덤 옵션 없음";
    commonEl.appendChild(empty);
  }
}

async function main() {
  const id = safeNumber(getQueryParam("id"));
  if (!id) {
    setText("equip-name", "id 파라미터가 없습니다.");
    return;
  }

  // load data
  const [equipJson, growthJson, skillJson, listJson] = await Promise.all([
    fetchJson(DATA_URL),
    fetchJson(GROWTH_URL),
    fetchJson(SKILL_URL),
    fetchJson(LIST_URL),
  ]);

  const equipList = Array.isArray(equipJson) ? equipJson : (Array.isArray(equipJson?.data) ? equipJson.data : []);
  const e = equipList.find(x => safeNumber(x?.id) === id);
  if (!e) {
    setText("equip-name", `장비를 찾을 수 없습니다. id=${id}`);
    return;
  }

  const ctx = {
    listById: buildListMaps(listJson),
    skillById: buildSkillMaps(skillJson),
  };

  const growthById = buildListMaps(growthJson);

  // NOTE:
  // randomSkillList의 listId는 실제로 ListFactory 계열일 가능성이 높습니다.
  // 현재 프로젝트에서 list json이 GrowthFactory로 연결돼 있지 않다면,
  // 아래 listById를 실제 ListFactory.json으로 교체해야 합니다.

   applyEquipmentToDom(e, { ...ctx, growthById });
}

main().catch(err => {
  console.error(err);
  setText("equip-name", "로딩 실패");
});
