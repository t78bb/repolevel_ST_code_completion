#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
比较两个 evaluation_summary 文件
将指定文件与基准文件进行详细对比，输出为 JSON 格式
"""

import argparse
import json
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, Optional


# 基准文件路径（写死）
BASELINE_FILE = Path(r"D:\graduate_project\项目级st补全\repo_gen_project\real_groud_truth最新\evaluation_summary_20260121_171642.json")


def load_json(file_path: Path) -> Optional[Dict]:
    """
    加载 JSON 文件
    
    参数:
        file_path: JSON 文件路径
    
    返回:
        JSON 数据字典，如果失败则返回 None
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception as e:
        print(f"❌ 读取文件失败 {file_path}: {e}")
        return None


def calculate_diff(baseline_value: float, compare_value: float) -> Dict[str, float]:
    """
    计算差异
    
    参数:
        baseline_value: 基准值
        compare_value: 对比值
    
    返回:
        包含绝对差异和相对差异的字典
    """
    absolute_diff = compare_value - baseline_value
    
    if baseline_value != 0:
        relative_diff = (absolute_diff / baseline_value) * 100
    else:
        relative_diff = 0.0 if compare_value == 0 else float('inf')
    
    return {
        "baseline": round(baseline_value, 6),
        "compare": round(compare_value, 6),
        "absolute_diff": round(absolute_diff, 6),
        "relative_diff_percent": round(relative_diff, 2)
    }


def compare_overall_statistics(baseline_data: Dict, compare_data: Dict) -> Dict:
    """
    比较整体统计信息
    
    参数:
        baseline_data: 基准数据
        compare_data: 对比数据
    
    返回:
        比较结果字典
    """
    result = {
        "total_projects": {
            "baseline": baseline_data.get("total_projects", 0),
            "compare": compare_data.get("total_projects", 0),
            "diff": compare_data.get("total_projects", 0) - baseline_data.get("total_projects", 0)
        },
        "success_count": {
            "baseline": baseline_data.get("success_count", 0),
            "compare": compare_data.get("success_count", 0),
            "diff": compare_data.get("success_count", 0) - baseline_data.get("success_count", 0)
        },
        "failed_count": {
            "baseline": baseline_data.get("failed_count", 0),
            "compare": compare_data.get("failed_count", 0),
            "diff": compare_data.get("failed_count", 0) - baseline_data.get("failed_count", 0)
        }
    }
    
    # 比较整体平均分数
    baseline_stats = baseline_data.get("overall_statistics", {})
    compare_stats = compare_data.get("overall_statistics", {})
    
    result["total_files"] = {
        "baseline": baseline_stats.get("total_files", 0),
        "compare": compare_stats.get("total_files", 0),
        "diff": compare_stats.get("total_files", 0) - baseline_stats.get("total_files", 0)
    }
    
    # 比较各项平均分数
    baseline_scores = baseline_stats.get("average_scores", {})
    compare_scores = compare_stats.get("average_scores", {})
    
    metrics = ["codebleu", "ngram_match_score", "weighted_ngram_match_score", 
               "syntax_match_score", "dataflow_match_score"]
    
    result["average_scores"] = {}
    for metric in metrics:
        baseline_val = baseline_scores.get(metric, 0.0)
        compare_val = compare_scores.get(metric, 0.0)
        result["average_scores"][metric] = calculate_diff(baseline_val, compare_val)
    
    return result


def compare_project_statistics(baseline_data: Dict, compare_data: Dict) -> Dict:
    """
    比较每个项目的详细统计
    
    参数:
        baseline_data: 基准数据
        compare_data: 对比数据
    
    返回:
        比较结果字典
    """
    baseline_projects = baseline_data.get("project_statistics", {})
    compare_projects = compare_data.get("project_statistics", {})
    
    # 获取所有项目名称（并集）
    all_projects = set(baseline_projects.keys()) | set(compare_projects.keys())
    
    result = {}
    
    for project_name in sorted(all_projects):
        baseline_proj = baseline_projects.get(project_name)
        compare_proj = compare_projects.get(project_name)
        
        project_result = {}
        
        # 项目存在性
        if baseline_proj is None:
            project_result["status"] = "新增项目"
            project_result["baseline_exists"] = False
            project_result["compare_exists"] = True
        elif compare_proj is None:
            project_result["status"] = "缺失项目"
            project_result["baseline_exists"] = True
            project_result["compare_exists"] = False
        else:
            project_result["status"] = "共同项目"
            project_result["baseline_exists"] = True
            project_result["compare_exists"] = True
        
        # 比较文件数量
        if baseline_proj and compare_proj:
            project_result["total_files"] = {
                "baseline": baseline_proj.get("total_files", 0),
                "compare": compare_proj.get("total_files", 0),
                "diff": compare_proj.get("total_files", 0) - baseline_proj.get("total_files", 0)
            }
            
            project_result["successful_evaluations"] = {
                "baseline": baseline_proj.get("successful_evaluations", 0),
                "compare": compare_proj.get("successful_evaluations", 0),
                "diff": compare_proj.get("successful_evaluations", 0) - baseline_proj.get("successful_evaluations", 0)
            }
            
            # 比较各项分数
            baseline_scores = baseline_proj.get("average_scores", {})
            compare_scores = compare_proj.get("average_scores", {})
            
            metrics = ["codebleu", "ngram_match_score", "weighted_ngram_match_score", 
                      "syntax_match_score", "dataflow_match_score"]
            
            project_result["average_scores"] = {}
            for metric in metrics:
                baseline_val = baseline_scores.get(metric, 0.0)
                compare_val = compare_scores.get(metric, 0.0)
                project_result["average_scores"][metric] = calculate_diff(baseline_val, compare_val)
        
        elif compare_proj:
            # 只在对比数据中存在
            project_result["total_files"] = compare_proj.get("total_files", 0)
            project_result["successful_evaluations"] = compare_proj.get("successful_evaluations", 0)
            project_result["average_scores"] = compare_proj.get("average_scores", {})
        
        elif baseline_proj:
            # 只在基准数据中存在
            project_result["total_files"] = baseline_proj.get("total_files", 0)
            project_result["successful_evaluations"] = baseline_proj.get("successful_evaluations", 0)
            project_result["average_scores"] = baseline_proj.get("average_scores", {})
        
        result[project_name] = project_result
    
    return result


def compare_project_lists(baseline_data: Dict, compare_data: Dict) -> Dict:
    """
    比较项目列表（成功/失败/跳过）
    
    参数:
        baseline_data: 基准数据
        compare_data: 对比数据
    
    返回:
        比较结果字典
    """
    baseline_results = baseline_data.get("results", {})
    compare_results = compare_data.get("results", {})
    
    baseline_success = set(baseline_results.get("success", []))
    compare_success = set(compare_results.get("success", []))
    
    baseline_failed = set(baseline_results.get("failed", []))
    compare_failed = set(compare_results.get("failed", []))
    
    return {
        "success": {
            "baseline_count": len(baseline_success),
            "compare_count": len(compare_success),
            "common": sorted(list(baseline_success & compare_success)),
            "only_in_baseline": sorted(list(baseline_success - compare_success)),
            "only_in_compare": sorted(list(compare_success - baseline_success)),
            "newly_successful": sorted(list((compare_success - baseline_success) & baseline_failed)),  # 从失败变成功
            "newly_failed": sorted(list((baseline_success - compare_success) & compare_failed))  # 从成功变失败
        },
        "failed": {
            "baseline_count": len(baseline_failed),
            "compare_count": len(compare_failed),
            "common": sorted(list(baseline_failed & compare_failed)),
            "only_in_baseline": sorted(list(baseline_failed - compare_failed)),
            "only_in_compare": sorted(list(compare_failed - baseline_failed))
        }
    }


def generate_summary(comparison_result: Dict) -> Dict:
    """
    生成比较总结
    
    参数:
        comparison_result: 完整的比较结果
    
    返回:
        总结字典
    """
    overall = comparison_result.get("overall_comparison", {})
    project_lists = comparison_result.get("project_lists_comparison", {})
    
    summary = {
        "total_projects_change": overall.get("total_projects", {}).get("diff", 0),
        "success_count_change": overall.get("success_count", {}).get("diff", 0),
        "failed_count_change": overall.get("failed_count", {}).get("diff", 0),
        "newly_successful_projects": len(project_lists.get("success", {}).get("newly_successful", [])),
        "newly_failed_projects": len(project_lists.get("success", {}).get("newly_failed", [])),
        "codebleu_change": overall.get("average_scores", {}).get("codebleu", {}).get("relative_diff_percent", 0.0)
    }
    
    # 计算改进/下降的项目数量
    project_stats = comparison_result.get("project_statistics_comparison", {})
    improved = 0
    degraded = 0
    unchanged = 0
    
    for project_name, project_data in project_stats.items():
        if project_data.get("status") == "共同项目":
            codebleu_diff = project_data.get("average_scores", {}).get("codebleu", {}).get("absolute_diff", 0.0)
            if codebleu_diff > 0.01:  # 提升超过 1%
                improved += 1
            elif codebleu_diff < -0.01:  # 下降超过 1%
                degraded += 1
            else:
                unchanged += 1
    
    summary["improved_projects"] = improved
    summary["degraded_projects"] = degraded
    summary["unchanged_projects"] = unchanged
    
    return summary


def main():
    parser = argparse.ArgumentParser(description="比较两个 evaluation_summary 文件")
    parser.add_argument(
        "--file",
        type=str,
        required=True,
        help="要比较的 evaluation_summary 文件路径"
    )
    parser.add_argument(
        "--output",
        type=str,
        default=None,
        help="输出 JSON 文件路径（默认：comparison_result_[timestamp].json）"
    )
    
    args = parser.parse_args()
    
    # 检查基准文件
    if not BASELINE_FILE.exists():
        print(f"❌ 基准文件不存在: {BASELINE_FILE}")
        return 1
    
    # 检查对比文件
    compare_file = Path(args.file)
    if not compare_file.exists():
        print(f"❌ 对比文件不存在: {compare_file}")
        return 1
    
    print("="*80)
    print("评估结果比较工具")
    print("="*80)
    print(f"基准文件: {BASELINE_FILE}")
    print(f"对比文件: {compare_file}")
    print("="*80)
    
    # 加载数据
    print("\n📂 加载数据...")
    baseline_data = load_json(BASELINE_FILE)
    compare_data = load_json(compare_file)
    
    if baseline_data is None or compare_data is None:
        print("❌ 数据加载失败")
        return 1
    
    print("✓ 数据加载成功")
    
    # 执行比较
    print("\n📊 开始比较...")
    
    comparison_result = {
        "metadata": {
            "comparison_timestamp": datetime.now().isoformat(),
            "baseline_file": str(BASELINE_FILE),
            "compare_file": str(compare_file),
            "baseline_timestamp": baseline_data.get("timestamp"),
            "compare_timestamp": compare_data.get("timestamp")
        },
        "overall_comparison": compare_overall_statistics(baseline_data, compare_data),
        "project_lists_comparison": compare_project_lists(baseline_data, compare_data),
        "project_statistics_comparison": compare_project_statistics(baseline_data, compare_data)
    }
    
    # 生成总结
    comparison_result["summary"] = generate_summary(comparison_result)
    
    print("✓ 比较完成")
    
    # 保存结果
    if args.output:
        output_file = Path(args.output)
    else:
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        output_file = Path(__file__).parent / f"comparison_result_{timestamp}.json"
    
    print(f"\n💾 保存结果到: {output_file}")
    
    try:
        output_file.parent.mkdir(parents=True, exist_ok=True)
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(comparison_result, f, indent=2, ensure_ascii=False)
        print("✓ 保存成功")
    except Exception as e:
        print(f"❌ 保存失败: {e}")
        return 1
    
    # 打印总结
    summary = comparison_result["summary"]
    print("\n" + "="*80)
    print("比较总结")
    print("="*80)
    print(f"总项目数变化:     {summary['total_projects_change']:+d}")
    print(f"成功项目变化:     {summary['success_count_change']:+d}")
    print(f"失败项目变化:     {summary['failed_count_change']:+d}")
    print(f"新成功的项目:     {summary['newly_successful_projects']}")
    print(f"新失败的项目:     {summary['newly_failed_projects']}")
    print(f"改进的项目:       {summary['improved_projects']}")
    print(f"下降的项目:       {summary['degraded_projects']}")
    print(f"不变的项目:       {summary['unchanged_projects']}")
    print(f"CodeBLEU 变化:    {summary['codebleu_change']:+.2f}%")
    print("="*80)
    
    return 0


if __name__ == "__main__":
    exit(main())

