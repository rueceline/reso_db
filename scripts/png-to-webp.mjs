// png-to-webp.mjs
// 사용법:
// 1) npm i sharp
// 2) node png-to-webp.mjs ./assets
//
// 기능:
// - 지정 폴더(재귀) 내 *.png → *.webp 생성
// - 기본: 원본과 같은 위치에 같은 이름.webp 생성
// - 이미 webp가 있으면 스킵

import fs from 'node:fs/promises';
import path from 'node:path';
import sharp from 'sharp';

const ROOT = process.cwd();
const inputRoot = path.join(ROOT, 'public', 'assets');

async function exists(p) {
  try {
    await fs.access(p);
    return true;
  } catch {
    return false;
  }
}

async function walk(dir) {
  const entries = await fs.readdir(dir, { withFileTypes: true });
  const out = [];

  for (const e of entries) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) {
      out.push(...(await walk(p)));
    } else if (e.isFile()) {
      out.push(p);
    }
  }
  return out;
}

function isPngFile(p) {
  return path.extname(p).toLowerCase() === '.png';
}

function toWebpPath(pngPath) {
  return pngPath.slice(0, -4) + '.webp'; // ".png" -> ".webp"
}

async function convertOne(pngPath) {
  const webpPath = toWebpPath(pngPath);

  if (await exists(webpPath)) {
    return { pngPath, webpPath, status: 'skip' };
  }

  // lossless: 원본 품질 유지(용량은 커질 수 있음)
  // 필요 시 quality 옵션으로 바꿀 수 있음 (예: .webp({ quality: 85 }))
  await sharp(pngPath)
    .webp({ lossless: true })
    .toFile(webpPath);

  return { pngPath, webpPath, status: 'ok' };
}

(async () => {
  const all = await walk(inputRoot);
  const pngs = all.filter(isPngFile);

  let ok = 0;
  let skip = 0;
  let fail = 0;

  for (const p of pngs) {
    try {
      const r = await convertOne(p);
      if (r.status === 'ok') {
        ok++;
        console.log(`[ok]   ${path.relative(inputRoot, r.webpPath)}`);
      } else {
        skip++;
        console.log(`[skip] ${path.relative(inputRoot, r.webpPath)}`);
      }
    } catch (err) {
      fail++;
      console.error(`[fail] ${path.relative(inputRoot, p)}\n       ${err?.message || err}`);
    }
  }

  console.log(`\nDone. ok=${ok}, skip=${skip}, fail=${fail}, total_png=${pngs.length}`);
})();
