import {
  dataPath,
  assetPath,
  uiSideIconPath,
} from "../utils/path.js";

import { qs, setText, setHtml, clearChildren } from "../utils/dom.js";
import { getQueryParam } from "../utils/utils.js";
import { DEFAULT_LANG } from "../utils/config.js";

import {
  UnitFactory,
  SkillFactory,
  TagFactory,
  ProfilePhotoFactory,
  TalentFactory,
  AwakeFactory,
  safeNumber,
  mapUnitQualityToRarity,
} from "../utils/data.js";

// -------------------------
// URLs
// -------------------------
const UNIT_URL = dataPath(DEFAULT_LANG, "UnitFactory.json");
const UNIT_VIEW_URL = dataPath(DEFAULT_LANG, "UnitViewFactory.json");
const TAG_URL = dataPath(DEFAULT_LANG, "TagFactory.json");
const SKILL_URL = dataPath(DEFAULT_LANG, "SkillFactory.json");
const PROFILE_PHOTO_URL = dataPath(DEFAULT_LANG, "ProfilePhotoFactory.json");
const TALENT_URL = dataPath(DEFAULT_LANG, "TalentFactory.json");
const AWAKE_URL = dataPath(DEFAULT_LANG, "AwakeFactory.json");

const ASSET_BASE = assetPath("");

// -------------------------
// local helpers
// -------------------------
function byString(v) {
  return v === null || v === undefined ? "" : String(v);
}

function buildSideIconUrlFromTag(tagRec) {
  const raw = String(tagRec?.iconPath || tagRec?.icon || tagRec?.IconPath || tagRec?.Icon || "").trim();
  if (!raw) {
    return "";
  }

  const norm = raw.replace(/\\/g, "/");
  const base = norm.split("/").pop();
  if (!base) {
    return "";
  }

  return uiSideIconPath(`${base}.png`);
}

function extractFactionFromUnit(unitRec, tagF) {
  const list = Array.isArray(unitRec?.tagList) ? unitRec.tagList : [];
  for (const it of list) {
    const tid = safeNumber(it?.tagId);
    if (tid === null) {
      continue;
    }

    const t = tagF.getById(tid);
    const sideName = String(t?.sideName || "").trim();
    if (sideName) {
      return {
        name: sideName,
        iconUrl: buildSideIconUrlFromTag(t),
      };
    }
  }

  return { name: "", iconUrl: "" };
}

function resolveProfilePhotoIdFromView(viewRec) {
  // 관측: profilePhotoID, State1profilePhotoID, State2profilePhotoID
  const ids = [
    safeNumber(viewRec?.State2profilePhotoID),
    safeNumber(viewRec?.State1profilePhotoID),
    safeNumber(viewRec?.profilePhotoID),
  ].filter((n) => n !== null && n >= 0);

  return ids.length > 0 ? ids[0] : null;
}

function buildSkillRow(skillRec, skillF) {
  const name = skillF.resolveSkillName(skillRec);
  const desc = skillF.resolveSkillDesc(skillRec);
  const detail = skillF.resolveSkillDetailDesc(skillRec);
  const iconPath = skillF.resolveSkillIconPath(skillRec);

  const row = document.createElement("div");
  row.className = "skill-row";

  const icon = document.createElement("img");
  icon.className = "skill-icon";
  icon.alt = "";
  icon.loading = "lazy";
  icon.decoding = "async";
  icon.src = iconPath ? `${ASSET_BASE}${iconPath}.png` : "";
  if (!icon.src) {
    icon.hidden = true;
  }

  const body = document.createElement("div");
  body.className = "skill-body";

  const title = document.createElement("div");
  title.className = "skill-title";
  title.textContent = name || "(이름 없음)";

  const d1 = document.createElement("div");
  d1.className = "skill-desc";
  d1.textContent = desc || "";

  const d2 = document.createElement("div");
  d2.className = "skill-detail muted";
  d2.textContent = detail || "";

  body.appendChild(title);
  if (desc) {
    body.appendChild(d1);
  }
  if (detail) {
    body.appendChild(d2);
  }

  row.appendChild(icon);
  row.appendChild(body);

  return row;
}

// -------------------------
// main
// -------------------------
async function loadDetail(unitId) {
  const unitF = new UnitFactory({ unitUrl: UNIT_URL, unitViewUrl: UNIT_VIEW_URL });
  const tagF = new TagFactory({ tagUrl: TAG_URL });
  const skillF = new SkillFactory({ skillUrl: SKILL_URL });
  const photoF = new ProfilePhotoFactory({ profilePhotoUrl: PROFILE_PHOTO_URL });

  // 아래 둘은 지금 단계에서 “있으면 로딩만” (UI 확장 대비)
  const talentF = new TalentFactory({ talentUrl: TALENT_URL });
  const awakeF = new AwakeFactory({ awakeUrl: AWAKE_URL });

  await Promise.all([
    unitF.load(),
    tagF.load(),
    skillF.load(),
    photoF.load(),
    talentF.load(),
    awakeF.load(),
  ]);

  const unitRec = unitF.getUnitById(unitId);
  if (!unitRec) {
    throw new Error(`UnitFactory에서 id=${unitId} 레코드를 찾지 못했습니다.`);
  }

  const viewRec = unitF.getViewForUnit(unitRec);

  const name = String(unitRec?.name || viewRec?.name || "").trim();
  const rarity = mapUnitQualityToRarity(unitRec?.quality ?? viewRec?.quality);
  const faction = extractFactionFromUnit(unitRec, tagF);

  const portraits = unitF.viewFactory.pickPortraitUrls(viewRec || {});
  const portraitUrl = portraits.primary || portraits.squads1 || portraits.squads2 || "";

  const photoId = resolveProfilePhotoIdFromView(viewRec || {});
  const photoRec = photoId !== null ? photoF.getById(photoId) : null;
  const avatarUrl = photoRec ? photoF.resolvePhotoUrl(photoRec) : "";

  // 기본 정보
  const birthday = String(unitRec?.birthday || "").trim();
  const gender = String(unitRec?.gender || "").trim();
  const height = String(unitRec?.height || "").trim();

  // 스킬 목록 (UnitFactory.skillList: [{ num, skillId }])
  const skillRefs = Array.isArray(unitRec?.skillList) ? unitRec.skillList : [];
  const skills = [];
  for (const it of skillRefs) {
    const sid = safeNumber(it?.skillId);
    if (sid === null) {
      continue;
    }
    const srec = skillF.getById(sid);
    if (!srec) {
      continue;
    }
    skills.push(srec);
  }

  return {
    unitRec,
    viewRec,
    name,
    rarity,
    factionName: faction.name,
    factionIconUrl: faction.iconUrl,
    portraitUrl,
    avatarUrl,
    birthday,
    gender,
    height,
    skills,
    skillF,
  };
}

function render(detail) {
  setText("status", "");

  setText("char-name", detail.name);
  setText("char-rarity", detail.rarity);

  // 소속
  setText("char-faction", detail.factionName || "");
  const factionIcon = qs("#char-faction-icon");
  if (factionIcon) {
    factionIcon.src = detail.factionIconUrl || "";
    factionIcon.hidden = !detail.factionIconUrl;
  }

  // 메인 이미지
  const portrait = qs("#char-portrait");
  if (portrait) {
    portrait.src = detail.portraitUrl || "";
    portrait.hidden = !detail.portraitUrl;
  }

  const avatar = qs("#char-avatar");
  if (avatar) {
    avatar.src = detail.avatarUrl || "";
    avatar.hidden = !detail.avatarUrl;
  }

  // 기본 정보
  setText("info-birthday", detail.birthday || "-");
  setText("info-gender", detail.gender || "-");
  setText("info-height", detail.height || "-");

  // 스킬 렌더
  const skillRoot = qs("#skill-list");
  if (skillRoot) {
    clearChildren(skillRoot);

    if (!detail.skills || detail.skills.length === 0) {
      const empty = document.createElement("div");
      empty.className = "muted";
      empty.textContent = "표시할 스킬이 없습니다.";
      skillRoot.appendChild(empty);
    } else {
      for (const s of detail.skills) {
        skillRoot.appendChild(buildSkillRow(s, detail.skillF));
      }
    }
  }
}

async function main() {
  try {
    setText("status", "불러오는 중...");

    const unitId = safeNumber(getQueryParam("id"));
    if (unitId === null) {
      throw new Error("쿼리스트링 id가 없습니다. 예: character_detail.html?id=10000004");
    }

    const detail = await loadDetail(unitId);
    render(detail);
  } catch (e) {
    console.error(e);
    setText("status", `데이터를 불러오는 데 실패했습니다.\n${String(e?.message || e)}`);
  }
}

document.addEventListener("DOMContentLoaded", () => {
  main();
});
