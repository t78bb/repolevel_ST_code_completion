#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
单个项目目录的 CodeBLEU 评估脚本
用于评估 output 目录下的项目
"""

import argparse
from pathlib import Path
from evaluate.codebleu_evaluator import evaluate_and_save


def main():
    parser = argparse.ArgumentParser(description="评估单个项目目录的 CodeBLEU")
    parser.add_argument(
        "--dir",
        type=str,
        required=True,
        help="项目目录路径（例如：output/20260121_021602_fixed/repoeval_readwriteFile）"
    )
    parser.add_argument(
        "--lang",
        type=str,
        default="python",
        help="编程语言（默认：python）"
    )
    parser.add_argument(
        "--use_project_code_gt",
        action="store_true",
        help="使用 project_code/[项目名]/FUN/ 作为参考代码（默认使用 generation_context_ground_truth）"
    )
    
    args = parser.parse_args()
    
    # 获取项目目录
    project_dir = Path(args.dir)
    
    if not project_dir.exists():
        print(f"错误: 目录不存在 - {project_dir}")
        return 1
    
    if not project_dir.is_dir():
        print(f"错误: 不是目录 - {project_dir}")
        return 1
    
    print("="*80)
    print("CodeBLEU 评估")
    print("="*80)
    print(f"项目目录: {project_dir}")
    print(f"编程语言: {args.lang}")
    
    # 显示参考代码来源
    if args.use_project_code_gt:
        print(f"参考代码来源: dataset/project_code/[项目名]/FUN/")
    else:
        print(f"参考代码来源: dataset/generation_context_ground_truth/[项目名]/")
    
    print("-"*80)
    
    # 执行评估
    try:
        success = evaluate_and_save(
            project_dir,
            output_filename="codebleu_evaluation.json",
            lang=args.lang,
            use_project_code=args.use_project_code_gt
        )
        
        if success:
            print("\n" + "="*80)
            print("✓ 评估完成!")
            print(f"结果已保存到: {project_dir / 'codebleu_evaluation.json'}")
            print("="*80)
            return 0
        else:
            print("\n" + "="*80)
            print("⚠ 评估未完成")
            print("="*80)
            return 1
            
    except Exception as e:
        print(f"\n错误: 评估失败 - {e}")
        import traceback
        traceback.print_exc()
        return 1


if __name__ == "__main__":
    exit(main())



