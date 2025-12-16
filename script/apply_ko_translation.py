import os
import json

# ============================================================
# 적용 규칙
# - Factory = 파일명(확장자 제거) 예: TextFactory.json -> TextFactory
# - Field   = JSON key
# - ConfigLanguage.json의 Factory/Field 매핑을 유지해서, 해당 field의 "문자열 value"만 치환
# - 매칭은 exact match (+ 줄바꿈 정규화)만 사용
#
# 로그
# - untranslated_report.txt:
#   * MAPPED_FIELD_MISS: 매핑 대상 field인데 value가 매핑에 없음 (번역 누락/원문 불일치 가능)
#   * UNMAPPED_FIELD_HAN: 매핑 대상이 아닌 field에서 한자 문자열 발견 (탐색/매핑 범위 재검토용)
# ============================================================

DATA_DIR_CANDIDATES = [r"./public/data", r"./data"]
KR_SUBDIR_NAME = "KR"
CONFIG_NAME = "ConfigLanguage.json"

SCRIPT_DIR = r"./script"   # 사용자가 지정: ./script
OUT_LOG_DIR = os.path.join(SCRIPT_DIR, "output_apply_ko")
OUT_SUMMARY = os.path.join(OUT_LOG_DIR, "summary.txt")
OUT_UNTRANSLATED = os.path.join(OUT_LOG_DIR, "untranslated_report.txt")  # json-lines


def pick_data_dir():
    for d in DATA_DIR_CANDIDATES:
        if os.path.isdir(d):
            return d
    return DATA_DIR_CANDIDATES[0]


def ensure_dir(path):
    if not os.path.exists(path):
        os.makedirs(path, exist_ok=True)


def load_json(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def save_json(path, obj):
    ensure_dir(os.path.dirname(path))
    with open(path, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, indent=2)


def norm_text(s):
    return s.replace("\r\n", "\n").replace("\r", "\n")


def looks_like_han(s):
    for ch in s:
        o = ord(ch)
        if 0x4E00 <= o <= 0x9FFF:
            return True
    return False


# UNMAPPED_FIELD_HAN 로그에서 제외할 필드들
# - 식별자/경로/임시 문자열 등: 번역 대상이 아니고 한자 포함이 정상일 수 있음
EXCLUDE_FIELDS_FOR_UNMAPPED_LOG = {
    "idCN",
    "mod",
    "tempdescription",
    "temptypeStr",
    "typeStr",
}


def load_configlanguage(cfg_path):
    """
    기대 구조:
    {
      "TextFactory": {
        "text": { "中文": "한국어", ... },
        ...
      },
      ...
    }
    """
    cfg = load_json(cfg_path)
    if not isinstance(cfg, dict):
        return {}

    # 줄바꿈 normalize 버전도 같이 넣어줘서 매칭률을 올림(Factory/Field 구조 유지)
    for fac, fac_obj in list(cfg.items()):
        if not isinstance(fac_obj, dict):
            continue

        for field, mapping in list(fac_obj.items()):
            if not isinstance(mapping, dict):
                continue

            add = {}
            for zh, ko in mapping.items():
                if not isinstance(zh, str) or not isinstance(ko, str) or ko == "":
                    continue

                nzh = norm_text(zh)
                nko = norm_text(ko)
                if nzh != zh and nzh not in mapping:
                    add[nzh] = nko

            if len(add) > 0:
                mapping.update(add)

    return cfg


def factory_name_from_relpath(rel_path):
    base = os.path.basename(rel_path)
    name = os.path.splitext(base)[0]
    return name


def should_skip_input(rel_path):
    rp = rel_path.replace("\\", "/").lower()
    if rp.startswith(KR_SUBDIR_NAME.lower() + "/"):
        return True
    if rp.endswith("/" + CONFIG_NAME.lower()):
        return True
    if rp.endswith(CONFIG_NAME.lower()):
        return True
    if "/.git/" in rp:
        return True
    return False


def iter_json_files(data_dir):
    for root, _, files in os.walk(data_dir):
        for fn in files:
            if not fn.lower().endswith(".json"):
                continue
            full = os.path.join(root, fn)
            rel = os.path.relpath(full, data_dir)
            if should_skip_input(rel):
                continue
            yield full, rel


def path_join(parent, key_or_index):
    if parent == "":
        return str(key_or_index)

    return parent + "." + str(key_or_index)


def translate_node(node, fac_maps, factory, current_key, json_path, untranslated_rows, stats):
    """
    fac_maps: dict[fieldName] -> dict[zh->ko]
    current_key: 현재 노드가 "어떤 key의 값인지" (dict recursion에서 전달)
    json_path: 사람이 찾기 위한 간단 경로 문자열
    """
    if isinstance(node, dict):
        out = {}
        for k, v in node.items():
            out[k] = translate_node(
                v,
                fac_maps,
                factory,
                k,
                path_join(json_path, k),
                untranslated_rows,
                stats,
            )
        return out

    if isinstance(node, list):
        out_list = []
        for i, v in enumerate(node):
            out_list.append(
                translate_node(
                    v,
                    fac_maps,
                    factory,
                    current_key,
                    path_join(json_path, i),
                    untranslated_rows,
                    stats,
                )
            )
        return out_list

    if isinstance(node, str):
        # 1) 매핑 대상 field인 경우만 치환 시도
        if isinstance(current_key, str) and current_key in fac_maps:
            m = fac_maps[current_key]

            if node in m:
                stats["replaced"] += 1
                return m[node]

            nn = norm_text(node)
            if nn in m:
                stats["replaced"] += 1
                return m[nn]

            # 치환 실패 + 한자 포함이면 "매핑 대상 필드에서 누락"으로 기록
            if looks_like_han(node):
                untranslated_rows.append({
                    "reason": "MAPPED_FIELD_MISS",
                    "factory": factory,
                    "field": current_key,
                    "path": json_path,
                    "zh": node,
                })

            return node

        # 2) 매핑 대상이 아닌 필드에서 한자 문자열 발견 (탐색/범위 점검용)
        if looks_like_han(node):
            if isinstance(current_key, str) and current_key in EXCLUDE_FIELDS_FOR_UNMAPPED_LOG:
                return node


            untranslated_rows.append({
                "reason": "UNMAPPED_FIELD_HAN",
                "factory": factory,
                "field": current_key if isinstance(current_key, str) else "",
                "path": json_path,
                "zh": node,
            })

        return node

    return node


def main():
    data_dir = pick_data_dir()
    kr_dir = os.path.join(data_dir, KR_SUBDIR_NAME)
    cfg_path = os.path.join(kr_dir, CONFIG_NAME)

    ensure_dir(kr_dir)
    ensure_dir(OUT_LOG_DIR)

    if not os.path.exists(cfg_path):
        raise FileNotFoundError(f"ConfigLanguage.json not found: {cfg_path}")

    cfg = load_configlanguage(cfg_path)

    ok = 0
    fail = 0
    total_replaced = 0
    per_file = []
    untranslated_rows = []
    no_factory_map_files = 0

    for in_path, rel in iter_json_files(data_dir):
        fac = factory_name_from_relpath(rel)
        out_path = os.path.join(kr_dir, rel)

        fac_obj = cfg.get(fac)
        if not isinstance(fac_obj, dict):
            # factory 매핑이 없으면 파일 복사(번역 없음)
            try:
                obj = load_json(in_path)
                save_json(out_path, obj)
                ok += 1
                per_file.append((rel, 0, "NO_FACTORY_MAP"))
                no_factory_map_files += 1
            except Exception as e:
                fail += 1
                per_file.append((rel, f"FAIL: {e}", "NO_FACTORY_MAP"))
            continue

        fac_maps = {}
        for field, mapping in fac_obj.items():
            if isinstance(field, str) and isinstance(mapping, dict):
                fac_maps[field] = mapping

        try:
            obj = load_json(in_path)
            stats = {"replaced": 0}
            tr_obj = translate_node(
                obj,
                fac_maps,
                fac,
                None,
                "",
                untranslated_rows,
                stats,
            )
            save_json(out_path, tr_obj)

            ok += 1
            total_replaced += stats["replaced"]
            per_file.append((rel, stats["replaced"], "OK"))

        except Exception as e:
            fail += 1
            per_file.append((rel, f"FAIL: {e}", "ERR"))

    # untranslated log (json-lines 스타일로 단순 저장)
    # 사람이 grep/search 하기 쉽게 1줄 1개 레코드
    with open(OUT_UNTRANSLATED, "w", encoding="utf-8") as f:
        for row in untranslated_rows:
            f.write(json.dumps(row, ensure_ascii=False))
            f.write("\n")

    with open(OUT_SUMMARY, "w", encoding="utf-8") as f:
        f.write("== APPLY KO (FACTORY/FIELD AWARE) SUMMARY ==\n")
        f.write(f"data_dir = {os.path.abspath(data_dir)}\n")
        f.write(f"kr_dir   = {os.path.abspath(kr_dir)}\n")
        f.write(f"config   = {os.path.abspath(cfg_path)}\n\n")

        f.write("== POLICY ==\n")
        f.write("- Keep JSON structure\n")
        f.write("- Factory=file name, Field=json key\n")
        f.write("- Translate only string values under mapped fields\n")
        f.write("- Exact match (+ newline-normalized)\n\n")

        f.write("== STATS ==\n")
        f.write(f"ok = {ok}\n")
        f.write(f"fail = {fail}\n")
        f.write(f"no_factory_map_files = {no_factory_map_files}\n")
        f.write(f"total_replaced = {total_replaced}\n")
        f.write(f"untranslated_rows = {len(untranslated_rows)}\n\n")

        f.write("== PER FILE ==\n")
        for name, v, tag in per_file:
            f.write(f"- {name}: {v} ({tag})\n")

    print(os.path.abspath(kr_dir))
    print(os.path.abspath(OUT_SUMMARY))
    print(os.path.abspath(OUT_UNTRANSLATED))


if __name__ == "__main__":
    main()
