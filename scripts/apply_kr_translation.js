// scripts/apply_kr_translation.js
// - Python 없이 Node.js로 CN -> KR 번역 치환
// - 입력:  ./public/data/CN
// - 출력:  ./public/data/KR
// - 매핑:  ./public/data/KR/ConfigLanguage.json
// 실행:
//   node scripts/apply_kr_translation.js

const fs = require("fs/promises");
const path = require("path");

const CN_DIR = path.resolve("./public/data/CN");
const KR_DIR = path.resolve("./public/data/KR");
const CONFIG_NAME = "ConfigLanguage.json";

async function ensureDir(p) {
  await fs.mkdir(p, { recursive: true });
}

async function loadJson(p) {
  const txt = await fs.readFile(p, "utf-8");
  return JSON.parse(txt);
}

async function saveJson(p, obj) {
  await ensureDir(path.dirname(p));
  await fs.writeFile(p, JSON.stringify(obj, null, 2), "utf-8");
}

function normText(s) {
  return String(s).replace(/\r\n/g, "\n").replace(/\r/g, "\n");
}

function factoryNameFromRel(relPath) {
  const base = path.basename(relPath);
  return path.parse(base).name;
}

function shouldSkip(relPath) {
  const rp = relPath.replace(/\\/g, "/").toLowerCase();
  if (rp.endsWith("/" + CONFIG_NAME.toLowerCase())) return true;
  if (rp.endsWith(CONFIG_NAME.toLowerCase())) return true;
  if (rp.includes("/.git/")) return true;
  return false;
}

async function* iterJsonFiles(baseDir) {
  // 재귀 walk
  async function* walk(dir) {
    const entries = await fs.readdir(dir, { withFileTypes: true });
    for (const ent of entries) {
      const full = path.join(dir, ent.name);
      if (ent.isDirectory()) {
        yield* walk(full);
      } else if (ent.isFile() && ent.name.toLowerCase().endsWith(".json")) {
        const rel = path.relative(baseDir, full);
        if (!shouldSkip(rel)) {
          yield { full, rel };
        }
      }
    }
  }
  yield* walk(baseDir);
}

function buildFacMaps(facObj) {
  const facMaps = {};
  for (const [field, mapping] of Object.entries(facObj)) {
    if (typeof field === "string" && mapping && typeof mapping === "object" && !Array.isArray(mapping)) {
      facMaps[field] = mapping;
    }
  }
  return facMaps;
}

function translateNode(node, facMaps, currentKey) {
  if (node && typeof node === "object" && !Array.isArray(node)) {
    const out = {};
    for (const [k, v] of Object.entries(node)) {
      out[k] = translateNode(v, facMaps, k);
    }
    return out;
  }

  if (Array.isArray(node)) {
    return node.map((v) => translateNode(v, facMaps, currentKey));
  }

  if (typeof node === "string") {
    if (typeof currentKey === "string" && facMaps[currentKey]) {
      const m = facMaps[currentKey];

      if (Object.prototype.hasOwnProperty.call(m, node)) {
        return m[node];
      }

      const nn = normText(node);
      if (Object.prototype.hasOwnProperty.call(m, nn)) {
        return m[nn];
      }
    }
    return node;
  }

  return node;
}

async function loadConfigLanguage(cfgPath) {
  const cfg = await loadJson(cfgPath);
  if (!cfg || typeof cfg !== "object" || Array.isArray(cfg)) {
    return {};
  }

  // 줄바꿈 normalize 버전도 추가 (Factory/Field 구조 유지)
  for (const fac of Object.keys(cfg)) {
    const facObj = cfg[fac];
    if (!facObj || typeof facObj !== "object" || Array.isArray(facObj)) continue;

    for (const field of Object.keys(facObj)) {
      const mapping = facObj[field];
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

async function main() {
  // CN 존재 확인
  try {
    const st = await fs.stat(CN_DIR);
    if (!st.isDirectory()) {
      throw new Error("CN_DIR is not a directory");
    }
  } catch {
    throw new Error(`입력 폴더 없음: ${CN_DIR}`);
  }

  await ensureDir(KR_DIR);

  const cfgPath = path.join(KR_DIR, CONFIG_NAME);
  try {
    await fs.access(cfgPath);
  } catch {
    throw new Error(`ConfigLanguage.json 없음: ${cfgPath}`);
  }

  const cfg = await loadConfigLanguage(cfgPath);

  for await (const { full, rel } of iterJsonFiles(CN_DIR)) {
    const fac = factoryNameFromRel(rel);
    const outPath = path.join(KR_DIR, rel);

    const facObj = cfg[fac];
    if (!facObj || typeof facObj !== "object" || Array.isArray(facObj)) {
      // 매핑 없으면 그대로 복사
      const obj = await loadJson(full);
      await saveJson(outPath, obj);
      continue;
    }

    const facMaps = buildFacMaps(facObj);
    const obj = await loadJson(full);
    const trObj = translateNode(obj, facMaps, null);
    await saveJson(outPath, trObj);
  }

  console.log(KR_DIR);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
