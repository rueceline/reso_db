// scripts/test-equipment-icons.js
// - TypeScript 없이 Node.js로 바로 실행
// - 필요: pnpm add @tsuk1ko/rsns-unpack
//
// 실행:
//   node scripts/test-equipment-icons.js
//
// 출력:
//   output_equipment_icons/*.png
//   output_equipment_icons/result_log.txt

const fs = require("fs/promises");
const path = require("path");

const OUT_DIR = "output_equipment_icons";
const ICON_LIMIT = 10;
const TIPS_LIMIT = 10;

function safeName(s) {
  return String(s || "").replace(/[\\/:*?"<>|]/g, "_");
}

async function saveSprite(unpacker, spritePath, outPath) {
  const img = await unpacker.getAssetSpriteImageJimp(spritePath);
  const png = await getJimpPNG(img); // Buffer(또는 Uint8Array 계열)
  await fs.writeFile(outPath, png);
}

let RsnsUnpacker;
let getJimpPNG;

async function main() {
  await fs.mkdir(OUT_DIR, { recursive: true });

  // rsns-unpack이 ESM일 수도 있어서 동적 import 사용
  const m = await import("@tsuk1ko/rsns-unpack");
  RsnsUnpacker = m.RsnsUnpacker;
  getJimpPNG = m.getJimpPNG;

  const unpacker = new RsnsUnpacker();
  const ver = await unpacker.getLatestVersion();
  console.log("Latest version:", ver);

  const equipmentFactory = await unpacker.getBinaryConfig("EquipmentFactory");
  const list = equipmentFactory;

  let iconOk = 0;
  let tipsOk = 0;

  const log = [];
  log.push(`version=${ver}`);
  log.push(`total=${list.length}`);

  for (const e of list) {
    if (iconOk < ICON_LIMIT) {
      const p = e.iconPath;
      if (p) {
        const out = path.join(
          OUT_DIR,
          `icon_${iconOk + 1}_${e.id}_${safeName(e.name)}.png`
        );
        try {
          await saveSprite(unpacker, p, out);
          log.push(`ICON OK id=${e.id} name=${e.name} path=${p} -> ${out}`);
          iconOk += 1;
        } catch (err) {
          log.push(
            `ICON FAIL id=${e.id} name=${e.name} path=${p} err=${String(err?.message ?? err)}`
          );
        }
      }
    }

    if (tipsOk < TIPS_LIMIT) {
      const p = e.tipsPath;
      if (p) {
        const out = path.join(
          OUT_DIR,
          `tips_${tipsOk + 1}_${e.id}_${safeName(e.name)}.png`
        );
        try {
          await saveSprite(unpacker, p, out);
          log.push(`TIPS OK id=${e.id} name=${e.name} path=${p} -> ${out}`);
          tipsOk += 1;
        } catch (err) {
          log.push(
            `TIPS FAIL id=${e.id} name=${e.name} path=${p} err=${String(err?.message ?? err)}`
          );
        }
      }
    }

    if (iconOk >= ICON_LIMIT && tipsOk >= TIPS_LIMIT) {
      break;
    }
  }

  const logPath = path.join(OUT_DIR, "result_log.txt");
  await fs.writeFile(logPath, log.join("\n"), "utf-8");

  console.log("DONE");
  console.log("iconOk =", iconOk, "tipsOk =", tipsOk);
  console.log("log =", logPath);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
