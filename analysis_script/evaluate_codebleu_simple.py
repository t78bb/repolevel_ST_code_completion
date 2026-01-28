#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
CodeBLEU 简单评估脚本 - 直接输入字符串
只需要提供 ground truth 和生成的代码字符串即可
"""

import sys
from pathlib import Path

# 添加 codebleu 模块到 Python 路径
REPO_ROOT = Path(__file__).parent.parent  # 项目根目录
codebleu_path = REPO_ROOT / "codebleu-main"
sys.path.insert(0, str(codebleu_path))

# 检查 codebleu-main 目录是否存在
if not codebleu_path.exists():
    print(f"错误: codebleu-main 目录不存在: {codebleu_path}")
    print(f"请确保 codebleu-main 目录位于项目根目录下")
    sys.exit(1)

try:
    from codebleu import calc_codebleu
except ImportError as e:
    print(f"错误: 无法导入 codebleu 模块")
    print(f"请确保已安装所有依赖: pip install tree-sitter tree-sitter-python")
    print(f"详细错误: {e}")
    sys.exit(1)


def evaluate_code(ground_truth: str, generated_code: str, lang: str = "python") -> dict:
    """
    评估生成代码与参考代码的 CodeBLEU 分数
    
    参数:
        ground_truth: 参考代码（字符串）
        generated_code: 生成的代码（字符串）
        lang: 编程语言（默认 "python"）
    
    返回:
        包含各项评估指标的字典
    """
    result = calc_codebleu(
        [ground_truth],      # references
        [generated_code],    # predictions
        lang=lang,
        weights=(0.25, 0.25, 0.25, 0.25)
    )
    
    return result


def print_result(result: dict, show_details: bool = True):
    """打印评估结果"""
    print("\n" + "="*80)
    print("CodeBLEU 评估结果")
    print("="*80)
    print(f"  ✅ CodeBLEU 总分:           {result['codebleu']:.4f}")
    
    if show_details:
        print(f"\n  子指标详情:")
        print(f"    📊 N-gram 匹配分数:       {result['ngram_match_score']:.4f}")
        print(f"    📊 加权 N-gram 分数:      {result['weighted_ngram_match_score']:.4f}")
        print(f"    🌳 语法树匹配分数:        {result['syntax_match_score']:.4f}")
        print(f"    🔄 数据流匹配分数:        {result['dataflow_match_score']:.4f}")
    print("="*80 + "\n")


# ============================================================================
# 使用示例
# ============================================================================

if __name__ == "__main__":
    # # 示例 1: Python 代码评估
    # print("\n【示例 1: Python 代码】")
    
    # ground_truth_py = """def add(a, b):
    # return a + b"""
    
    # generated_py = """def sum(x, y):
    # return x + y"""
    
    # print("Ground Truth:")
    # print(ground_truth_py)
    # print("\nGenerated:")
    # print(generated_py)
    
    # result = evaluate_code(ground_truth_py, generated_py, lang="python")
    # print_result(result)
    
    
    # 示例 2: ST 代码评估（使用 python 作为近似）
    # print("\n【示例 2: ST 代码】")
    
    ground_truth_st = """
IF bUp THEN						
	nValue:=nValue+1;
END_IF
IF bDown THEN
	nValue:=nValue-1;
END_IF
IF bReset THEN
	nValue:=0;
END_IF

"""
    
    generated_st = """

IF bReset THEN
    nValue :=0;
ELSIF bUp THEN 
    nValue:=nValue +1;
ELSIF bDown THEN
    nValue:=nValue-1;
END_IF

"""
    
    print("Ground Truth:")
    print(ground_truth_st)
    print("\nGenerated:")
    print(generated_st)
    
    result = evaluate_code(ground_truth_st, generated_st, lang="python")
    print_result(result)
    
    
    # 示例 3: 完全相同的代码（预期得分接近 1.0）
    # print("\n【示例 3: 完全相同的代码】")
    
    # same_code = "def foo(x):\n    return x * 2"
    
    # result = evaluate_code(same_code, same_code, lang="python")
    # print_result(result, show_details=False)

