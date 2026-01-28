#!/usr/bin/env python3
"""
清理 ground_truth 目录
删除每个子目录下的 readful_result 子目录和 codebleu_evaluation.json 文件
"""

import sys
import shutil
from pathlib import Path


def clean_ground_truth_project(project_dir: Path) -> dict:
    """
    清理单个项目目录
    
    返回:
        删除结果字典 {"readful_result": bool, "codebleu_json": bool}
    """
    result = {
        "readful_result": False,
        "codebleu_json": False
    }
    
    # 删除 readful_result 目录
    readful_result_dir = project_dir / "readful_result"
    if readful_result_dir.exists():
        try:
            shutil.rmtree(readful_result_dir)
            result["readful_result"] = True
            print(f"    ✅ 已删除: readful_result/")
        except Exception as e:
            print(f"    ❌ 删除 readful_result 失败: {e}")
    
    # 删除 codebleu_evaluation.json 文件
    codebleu_file = project_dir / "codebleu_evaluation.json"
    if codebleu_file.exists():
        try:
            codebleu_file.unlink()
            result["codebleu_json"] = True
            print(f"    ✅ 已删除: codebleu_evaluation.json")
        except Exception as e:
            print(f"    ❌ 删除 codebleu_evaluation.json 失败: {e}")
    
    return result


def main():
    """主函数"""
    import argparse
    
    parser = argparse.ArgumentParser(description="清理 ground_truth 目录")
    parser.add_argument(
        "--ground-truth-dir",
        type=str,
        default="ground_truth",
        help="ground_truth 目录路径（默认: ground_truth）"
    )
    parser.add_argument(
        "--yes",
        action="store_true",
        help="不询问，直接删除"
    )
    
    args = parser.parse_args()
    
    # 获取 ground_truth 目录
    repo_root = Path(__file__).parent
    ground_truth_dir = repo_root / args.ground_truth_dir
    
    if not ground_truth_dir.exists():
        print(f"❌ ground_truth 目录不存在: {ground_truth_dir}")
        return 1
    
    # 获取所有子目录
    project_dirs = [d for d in ground_truth_dir.iterdir() if d.is_dir()]
    
    if not project_dirs:
        print(f"❌ ground_truth 目录下没有子目录")
        return 1
    
    print(f"{'='*80}")
    print(f"清理 ground_truth 目录")
    print(f"{'='*80}")
    print(f"目录路径: {ground_truth_dir}")
    print(f"找到 {len(project_dirs)} 个项目\n")
    
    # 统计要删除的内容
    to_delete = {
        "readful_result_dirs": [],
        "codebleu_files": []
    }
    
    for project_dir in sorted(project_dirs):
        if (project_dir / "readful_result").exists():
            to_delete["readful_result_dirs"].append(project_dir.name)
        if (project_dir / "codebleu_evaluation.json").exists():
            to_delete["codebleu_files"].append(project_dir.name)
    
    print(f"将要删除:")
    print(f"  - readful_result 目录: {len(to_delete['readful_result_dirs'])} 个")
    print(f"  - codebleu_evaluation.json 文件: {len(to_delete['codebleu_files'])} 个")
    
    # 询问确认（除非使用 --yes）
    if not args.yes:
        print(f"\n{'='*80}")
        response = input("确认删除？(y/N): ")
        if response.lower() != 'y':
            print("已取消")
            return 0
    
    # 执行清理
    print(f"\n{'='*80}")
    print("开始清理...")
    print(f"{'='*80}\n")
    
    stats = {
        "readful_result_deleted": 0,
        "codebleu_deleted": 0,
        "total_projects": 0
    }
    
    for project_dir in sorted(project_dirs):
        project_name = project_dir.name
        
        # 检查是否有需要删除的内容
        has_readful = (project_dir / "readful_result").exists()
        has_codebleu = (project_dir / "codebleu_evaluation.json").exists()
        
        if not has_readful and not has_codebleu:
            continue
        
        print(f"  📁 {project_name}")
        stats["total_projects"] += 1
        
        result = clean_ground_truth_project(project_dir)
        
        if result["readful_result"]:
            stats["readful_result_deleted"] += 1
        if result["codebleu_json"]:
            stats["codebleu_deleted"] += 1
        
        print()
    
    # 输出统计
    print(f"{'='*80}")
    print(f"清理完成")
    print(f"{'='*80}")
    print(f"处理项目数: {stats['total_projects']}")
    print(f"删除 readful_result 目录: {stats['readful_result_deleted']} 个")
    print(f"删除 codebleu_evaluation.json 文件: {stats['codebleu_deleted']} 个")
    print(f"{'='*80}")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())



