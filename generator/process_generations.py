#!/usr/bin/env python3
"""将 generations_repoeval-function_repoeval-function 中的字符串转换为可读代码文件."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path
from typing import Iterable, List, Optional, Dict


DEFAULT_RESULT_ROOT = Path(__file__).resolve().parent.parent / "output"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "读取指定 result_dir 下每个项目的 results.jsonl 和 "
            "generations_repoeval-function_repoeval-function.json，"
            "把 generation 中的代码写到 readful_result 子目录。"
        )
    )
    parser.add_argument(
        "--result-root",
        type=Path,
        default=DEFAULT_RESULT_ROOT,
        help="结果根目录，包含各个 result_dir 子目录，默认使用仓库下的 output。",
    )
    parser.add_argument(
        "--subdir",
        required=True,
        help="`result_root` 下面需要处理的子目录名称，例如 `20251125_noretrieve`。",
    )
    parser.add_argument(
        "--project-pattern",
        nargs="*",
        help="可选的项目名 glob 过滤器（支持多个），不匹配的目录会跳过。",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="仅打印会做什么，不写文件。",
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="打印处理过程中的细节信息。",
    )
    return parser.parse_args()


def read_jsonl(path: Path) -> List[dict]:
    results = []
    with path.open("r", encoding="utf-8") as fp:
        for line in fp:
            line = line.strip()
            if line:
                results.append(json.loads(line))
    return results


def sanitize_filename(name: str) -> str:
    name = name.strip()
    if not name:
        return "unknown"
    name = re.sub(r"[<>:\"/\\|?*\n\r\t]+", "_", name)
    return name


def extract_extension(result: dict) -> str:
    # 优先从 metadata.fpath_tuple 提取（旧格式）
    metadata = result.get("metadata", {})
    if isinstance(metadata, dict):
        fpath_tuple = metadata.get("fpath_tuple")
        if fpath_tuple and isinstance(fpath_tuple, list) and fpath_tuple:
            suffix = Path(str(fpath_tuple[-1])).suffix
            if suffix:
                return suffix
    
    # 新格式：尝试从 docs 中提取扩展名
    docs = result.get("docs", [])
    if docs and isinstance(docs, list) and len(docs) > 0:
        first_doc = docs[0]
        if isinstance(first_doc, dict):
            title = first_doc.get("title", "")
            if title:
                # title 格式可能是 "Builder_Application_RPI-FUN\\ConcreteBuilder.st"
                suffix = Path(title).suffix
                if suffix:
                    return suffix
    
    # 如果都没有，默认使用 .st（因为这些都是 ST 代码文件）
    return ".st"
# 缓存检索数据集的 fpath->text 映射
_DATASET_TEXT_CACHE: Dict[str, Dict[str, str]] = {}


def _load_dataset_text_map(dataset_name: str) -> Dict[str, str]:
    """读取 retrieval/my_datasets/{dataset_name}/queries.jsonl，建立 fpath_tuple 最后一段到 text 的映射。"""
    if dataset_name in _DATASET_TEXT_CACHE:
        return _DATASET_TEXT_CACHE[dataset_name]

    base_dir = Path("/root/code_rag_bench/code-rag-bench/retrieval/my_datasets")
    queries_path = base_dir / dataset_name / "queries.jsonl"
    mapping: Dict[str, str] = {}
    if not queries_path.exists():
        _DATASET_TEXT_CACHE[dataset_name] = mapping
        return mapping

    for line in queries_path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            obj = json.loads(line)
        except json.JSONDecodeError:
            continue
        meta = obj.get("metadata") or {}
        if not isinstance(meta, dict):
            continue
        ftuple = meta.get("fpath_tuple")
        if ftuple and isinstance(ftuple, list) and ftuple:
            fname = str(ftuple[-1])
            mapping[fname] = obj.get("text", "")

    _DATASET_TEXT_CACHE[dataset_name] = mapping
    return mapping


def _get_prefix_text(dataset_name: str, fpath_last: Optional[str]) -> Optional[str]:
    """根据数据集名与 fpath_tuple 最后一段获取 text 字段，用作文件头部前缀。"""
    if not fpath_last:
        return None
    text_map = _load_dataset_text_map(dataset_name)
    return text_map.get(str(fpath_last))


def normalize_generation(raw: Optional[str]) -> str:
    if not raw:
        return ""
    text = raw.replace("\\r", "\r").replace("\n", "\n").replace("\\t", "\t")
    text = text.strip()
    if text.startswith("```"):
        lines = text.splitlines()
        if lines:
            # 移除首尾 ``` 行
            if lines[0].startswith("```"):
                lines = lines[1:]
            if lines and lines[-1].strip().startswith("```"):
                lines = lines[:-1]
        text = "\n".join(lines).strip()
    return text


def write_candidates(
    candidates: Iterable[str],
    output_dir: Path,
    base_name: str,
    ext: str,
    verbose: bool,
    dry_run: bool,
    prefix_text: Optional[str] = None,
) -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    for idx, candidate in enumerate(candidates, start=1):
        normalized = normalize_generation(candidate)
        if not normalized:
            continue
        if prefix_text:
            normalized = prefix_text.rstrip() + "\n" + normalized
        suffix = f"_cand{idx}" if idx > 1 else ""
        candidate_name = sanitize_filename(base_name) + suffix + ext
        dest = output_dir / candidate_name
        counter = 1
        while dest.exists():
            dest = output_dir / f"{sanitize_filename(base_name)}{suffix}_{counter}{ext}"
            counter += 1
        if dry_run:
            if verbose:
                print(f"[dry-run] 会写入: {dest}")
            continue
        with dest.open("w", encoding="utf-8") as out_fp:
            out_fp.write(normalized)
        if verbose:
            print(f"写入: {dest}")


def _resolve_function_name(result: dict, idx: int) -> str:
    # 优先使用 task_id（新格式）
    task_id = result.get("task_id")
    if task_id:
        return str(task_id)
    
    # 其次使用 fpath_tuple 的最后一个值（去掉扩展名）
    metadata = result.get("metadata") or {}
    if isinstance(metadata, dict):
        fpath_tuple = metadata.get("fpath_tuple")
        if fpath_tuple and isinstance(fpath_tuple, list) and fpath_tuple:
            fpath_value = str(fpath_tuple[-1])
            # 去掉扩展名，只保留文件名部分
            name_without_ext = Path(fpath_value).stem
            if name_without_ext:
                return name_without_ext
    
    # 如果没有 fpath_tuple，回退到原来的逻辑
    explicit = result.get("function_name")
    if explicit:
        return explicit
    if isinstance(metadata, dict):
        meta_fn = metadata.get("function_name")
        if meta_fn:
            return meta_fn
    title = result.get("title")
    if title:
        return title
    return f"result_{idx}"


def process_project(project_dir: Path, args: argparse.Namespace) -> None:
    results_path = project_dir / "results.jsonl"
    gens_path = project_dir / "generations_repoeval-function_repoeval-function.json"
    if not results_path.exists() or not gens_path.exists():
        if args.verbose:
            print(f"跳过 {project_dir}：缺少 results 或 generations 文件。")
        return

    results = read_jsonl(results_path)
    try:
        generations = json.loads(gens_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        print(f"[错误] 解析 {gens_path} 失败：{exc}")
        return

    output_dir = project_dir / "readful_result"
    dataset_name = project_dir.name  # 对应 retrieval/my_datasets/{dataset_name}
    for idx, result in enumerate(results):
        function_name = _resolve_function_name(result, idx)
        ext = extract_extension(result)
        metadata = result.get("metadata") or {}
        fpath_tuple = metadata.get("fpath_tuple") if isinstance(metadata, dict) else None
        fpath_last = str(fpath_tuple[-1]) if fpath_tuple and isinstance(fpath_tuple, list) and fpath_tuple else None
        prefix_text = _get_prefix_text(dataset_name, fpath_last)
        candidate_group = generations[idx] if idx < len(generations) else []
        if not isinstance(candidate_group, list):
            candidate_group = [candidate_group]
        if not candidate_group:
            if args.verbose:
                print(f"没有生成结果: {project_dir.name} -> {function_name}")
            continue
        write_candidates(
            candidate_group,
            output_dir,
            base_name=function_name,
            ext=ext,
            verbose=args.verbose,
            dry_run=args.dry_run,
            prefix_text=prefix_text,
        )


def filter_projects(root: Path, patterns: Optional[List[str]]) -> Iterable[Path]:
    for child in sorted(root.iterdir()):
        if not child.is_dir():
            continue
        if not patterns:
            yield child
            continue
        if any(child.match(pattern) for pattern in patterns):
            yield child


def main() -> None:
    args = parse_args()
    result_root = args.result_root.expanduser().resolve()
    target_dir = result_root / args.subdir
    if not target_dir.is_dir():
        # 兼容历史 codesys_result 路径
        legacy_root = Path("/root/code_rag_bench/code-rag-bench/codesys_result")
        legacy_dir = legacy_root / args.subdir
        if legacy_dir.is_dir():
            target_dir = legacy_dir
        else:
            raise SystemExit(f"{target_dir} 不是目录或不存在。可通过 --result-root 指定根目录。")

    if args.verbose:
        print(f"正在处理: {target_dir}")

    for project_dir in filter_projects(target_dir, args.project_pattern):
        if args.verbose:
            print(f"处理项目: {project_dir.name}")
        process_project(project_dir, args)


if __name__ == "__main__":
    main()

