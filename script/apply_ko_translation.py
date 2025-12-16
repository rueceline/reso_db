import os
import json
from datetime import datetime


# ============================================================
# 고정 경로
# ============================================================
DATA_DIR = r"./public/data"
KR_DIR = os.path.join(DATA_DIR, "KR")
CONFIG_PATH = os.path.join(KR_DIR, "ConfigLanguage.json")

LUA_DIR = r"./scripts/lua"  # 참고용(이번 스크립트에서 직접 파싱하진 않음)

OUT_LOG_DIR = r"./scripts/output_apply_ko"
OUT_SUMMARY = os.path.join(OUT_LOG_DIR, "summary.txt")
OUT_UNTRANSLATED = os.path.join(OUT_LOG_DIR, "untranslated_strings.txt")


# ============================================================
# Helpers
# ============================================================
def ensure_dir(path):
    if not os.path.exists(path):
        os.makedirs(path, exist_ok=True)


def load_json(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def save_json(path, obj):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, indent=2)


def looks_like_han(s):
    for ch in s:
        code = ord(ch)
        if 0x4E00 <= code <= 0x9FFF:
            return True
    return False


def normalize_translation_map(cfg_obj):
    # flat: { "中": "韩" }
    if isinstance(cfg_obj, dict):
        flat_like = True

        for k, v in cfg_obj.items():
            if not isinstance(k, str):
                flat_like = False
                break

            if not (isinstance(v, str) or v is None):
                flat_like = False
                break

        if flat_like:
            out = {}
            for zh, ko in cfg_obj.items():
                if isinstance(zh, str) and isinstance(ko, str) and ko != "":
                    out[zh] = ko
            return out

        # nested: { factory: { field: [[a,b], ...] } }
        out = {}

        for fac_obj in cfg_obj.values():
            if not isinstance(fac_obj, dict):
                continue

            for pairs in fac_obj.values():
                if not isinstance(pairs, list):
                    continue

                for pair in pairs:
                    if not (isinstance(pair, list) and len(pair) == 2):
                        continue

                    zh = pair[0]
                    ko = pair[1]

                    if isinstance(zh, str) and isinstance(ko, str) and ko != "":
                        out[zh] = ko

        return out

    return {}


def translate_any_value(value, tr_map, untranslated_set, stats):
    # JSON 구조 유지, 문자열 value만 치환(정확히 일치하는 경우만)
    if isinstance(value, dict):
        out = {}
        for k, v in value.items():
            out[k] = translate_any_value(v, tr_map, untranslated_set, stats)
        return out

    if isinstance(value, list):
        return [translate_any_value(x, tr_map, untranslated_set, stats) for x in value]

    if isinstance(value, str):
        if value in tr_map:
            stats["replaced"] += 1
            return tr_map[value]

        if looks_like_han(value):
            untranslated_set.add(value)

        return value

    return value


def main():
    ensure_dir(KR_DIR)
    ensure_dir(OUT_LOG_DIR)

    if not os.path.exists(DATA_DIR):
        raise FileNotFoundError(f"DATA_DIR not found: {DATA_DIR}")

    if not os.path.exists(CONFIG_PATH):
        raise FileNotFoundError(f"ConfigLanguage.json not found: {CONFIG_PATH}")

    cfg_obj = load_json(CONFIG_PATH)
    tr_map = normalize_translation_map(cfg_obj)

    untranslated_set = set()
    per_file = []
    total_replaced = 0
    ok = 0
    fail = 0

    # 대상: public/data/*.json (KR 폴더 내부 제외)
    names = []
    for name in os.listdir(DATA_DIR):
        if name.lower().endswith(".json"):
            names.append(name)

    names.sort()

    for fname in names:
        in_path = os.path.join(DATA_DIR, fname)

        # ConfigLanguage는 이미 KR에 있으므로 변환 대상에서 제외
        if fname.lower() == "configlanguage.json":
            continue

        out_path = os.path.join(KR_DIR, fname)

        try:
            obj = load_json(in_path)

            stats = {"replaced": 0}
            tr_obj = translate_any_value(obj, tr_map, untranslated_set, stats)

            save_json(out_path, tr_obj)

            ok += 1
            total_replaced += stats["replaced"]
            per_file.append((fname, stats["replaced"]))

        except Exception as e:
            fail += 1
            per_file.append((fname, f"FAIL: {e}"))

    with open(OUT_UNTRANSLATED, "w", encoding="utf-8") as f:
        for s in sorted(untranslated_set):
            f.write(s)
            f.write("\n")

    with open(OUT_SUMMARY, "w", encoding="utf-8") as f:
        f.write("== INPUT ==\n")
        f.write(f"DATA_DIR = {os.path.abspath(DATA_DIR)}\n")
        f.write(f"KR_DIR   = {os.path.abspath(KR_DIR)}\n")
        f.write(f"CONFIG   = {os.path.abspath(CONFIG_PATH)}\n")
        f.write(f"LUA_DIR  = {os.path.abspath(LUA_DIR)} (reference only)\n\n")

        f.write("== RULE ==\n")
        f.write("- Keep JSON structure\n")
        f.write("- Translate string values by exact match only\n")
        f.write("- If not matched: keep original, collect untranslated(Han-containing)\n\n")

        f.write("== STATS ==\n")
        f.write(f"created_at = {datetime.now().isoformat(timespec='seconds')}\n")
        f.write(f"translation_entries = {len(tr_map)}\n")
        f.write(f"ok = {ok}\n")
        f.write(f"fail = {fail}\n")
        f.write(f"total_replaced = {total_replaced}\n")
        f.write(f"untranslated_unique = {len(untranslated_set)}\n\n")

        f.write("== PER FILE ==\n")
        for name, v in per_file:
            f.write(f"- {name}: {v}\n")

    # 콘솔엔 경로만
    print(os.path.abspath(KR_DIR))
    print(os.path.abspath(OUT_SUMMARY))
    print(os.path.abspath(OUT_UNTRANSLATED))


if __name__ == "__main__":
    main()
