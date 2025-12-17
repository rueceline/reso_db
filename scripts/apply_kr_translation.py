import os
import json

# ============================================================
# 적용 규칙
# - 입력: ./public/data/CN
# - 출력: ./public/data/KR
# - ConfigLanguage: ./public/data/KR/ConfigLanguage.json
# - 로그/리포트 생성 없음
# ============================================================

CN_DIR = r"./public/data/CN"
KR_DIR = r"./public/data/KR"
CONFIG_NAME = "ConfigLanguage.json"


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


def load_configlanguage(cfg_path):
    cfg = load_json(cfg_path)
    if not isinstance(cfg, dict):
        return {}

    # 줄바꿈 normalize 버전 추가
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

            if add:
                mapping.update(add)

    return cfg


def should_skip(rel_path):
    rp = rel_path.replace("\\", "/").lower()
    if rp.endswith("/" + CONFIG_NAME.lower()):
        return True
    if rp.endswith(CONFIG_NAME.lower()):
        return True
    if "/.git/" in rp:
        return True
    return False


def iter_json_files(base_dir):
    for root, _, files in os.walk(base_dir):
        for fn in files:
            if not fn.lower().endswith(".json"):
                continue
            full = os.path.join(root, fn)
            rel = os.path.relpath(full, base_dir)
            if should_skip(rel):
                continue
            yield full, rel


def factory_name_from_relpath(rel_path):
    base = os.path.basename(rel_path)
    return os.path.splitext(base)[0]


def translate_node(node, fac_maps, current_key):
    if isinstance(node, dict):
        return {
            k: translate_node(v, fac_maps, k)
            for k, v in node.items()
        }

    if isinstance(node, list):
        return [
            translate_node(v, fac_maps, current_key)
            for v in node
        ]

    if isinstance(node, str):
        if isinstance(current_key, str) and current_key in fac_maps:
            m = fac_maps[current_key]
            if node in m:
                return m[node]
            nn = norm_text(node)
            if nn in m:
                return m[nn]
        return node

    return node


def main():
    if not os.path.isdir(CN_DIR):
        raise FileNotFoundError(CN_DIR)

    ensure_dir(KR_DIR)

    cfg_path = os.path.join(KR_DIR, CONFIG_NAME)
    if not os.path.exists(cfg_path):
        raise FileNotFoundError(cfg_path)

    cfg = load_configlanguage(cfg_path)

    for in_path, rel in iter_json_files(CN_DIR):
        fac = factory_name_from_relpath(rel)
        out_path = os.path.join(KR_DIR, rel)

        fac_obj = cfg.get(fac)
        if not isinstance(fac_obj, dict):
            # 매핑 없으면 그대로 복사
            obj = load_json(in_path)
            save_json(out_path, obj)
            continue

        fac_maps = {
            field: mapping
            for field, mapping in fac_obj.items()
            if isinstance(field, str) and isinstance(mapping, dict)
        }

        obj = load_json(in_path)
        tr_obj = translate_node(obj, fac_maps, None)
        save_json(out_path, tr_obj)

    print(os.path.abspath(KR_DIR))


if __name__ == "__main__":
    main()
