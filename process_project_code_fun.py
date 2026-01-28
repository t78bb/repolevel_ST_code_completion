#!/usr/bin/env python3
"""
处理 project_code 目录下的 FUN 子目录
删除文件头部的声明和输入输出变量定义，只保留 VAR 及之后的实现部分
"""

import sys
from pathlib import Path
import shutil


def find_cut_position(lines):
    """
    找到应该开始保留内容的位置
    
    规则：
    1. 如果有 VAR 定义（不是 VAR_INPUT/VAR_OUTPUT/VAR_IN_OUT），从第一个 VAR 开始保留
    2. 如果没有 VAR，找到最后一个 END_VAR，从其下一行开始保留
    3. 如果都没有，返回 0（保留全部内容）
    
    返回：应该保留的起始行索引（0-based）
    """
    # 查找第一个 VAR（但不是 VAR_INPUT/VAR_OUTPUT/VAR_IN_OUT）
    for i, line in enumerate(lines):
        stripped = line.strip()
        # 检查是否是纯 VAR 声明（不是 VAR_INPUT 等）
        if stripped.startswith('VAR') and not any(
            stripped.startswith(prefix) for prefix in ['VAR_INPUT', 'VAR_OUTPUT', 'VAR_IN_OUT', 'VAR_EXTERNAL', 'VAR_GLOBAL', 'VAR_TEMP']
        ):
            return i
    
    # 如果没有找到 VAR，找最后一个 END_VAR
    last_end_var_index = -1
    for i, line in enumerate(lines):
        if line.strip().startswith('END_VAR'):
            last_end_var_index = i
    
    if last_end_var_index >= 0:
        # 从 END_VAR 的下一行开始保留
        return last_end_var_index + 1
    
    # 如果什么都没找到，保留全部内容
    return 0


def process_st_file(input_file, output_file):
    """
    处理单个 ST 文件
    
    参数:
        input_file: 输入文件路径
        output_file: 输出文件路径
    
    返回:
        删除的行数
    """
    try:
        # 读取文件内容
        with open(input_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        # 找到应该开始保留的位置
        cut_position = find_cut_position(lines)
        
        # 保留从 cut_position 开始的内容
        preserved_lines = lines[cut_position:]
        
        # 写入输出文件
        output_file.parent.mkdir(parents=True, exist_ok=True)
        with open(output_file, 'w', encoding='utf-8') as f:
            f.writelines(preserved_lines)
        
        return cut_position
    
    except Exception as e:
        print(f"      ❌ 处理失败: {e}")
        return 0


def process_project_code(project_code_dir, output_dir):
    """
    处理整个 project_code 目录
    
    参数:
        project_code_dir: project_code 目录路径
        output_dir: 输出目录路径
    """
    print(f"\n{'='*80}")
    print(f"处理 project_code 目录")
    print(f"{'='*80}")
    print(f"源目录: {project_code_dir}")
    print(f"目标目录: {output_dir}")
    
    # 获取所有项目目录
    project_dirs = [d for d in project_code_dir.iterdir() if d.is_dir()]
    project_dirs.sort()
    
    print(f"\n找到 {len(project_dirs)} 个项目")
    
    total_files = 0
    processed_files = 0
    total_removed_lines = 0
    
    # 处理每个项目
    for project_dir in project_dirs:
        project_name = project_dir.name
        fun_dir = project_dir / "FUN"
        
        # 检查是否有 FUN 目录
        if not fun_dir.exists() or not fun_dir.is_dir():
            print(f"\n  ⚠️  {project_name}: 没有 FUN 目录，跳过")
            continue
        
        # 获取 FUN 目录下的所有 .st 文件
        st_files = list(fun_dir.glob("*.st"))
        
        if not st_files:
            print(f"\n  ⚠️  {project_name}: FUN 目录中没有 .st 文件，跳过")
            continue
        
        print(f"\n  📁 {project_name}")
        print(f"     找到 {len(st_files)} 个 ST 文件")
        
        # 创建输出项目目录
        output_project_dir = output_dir / project_name
        
        # 处理每个 ST 文件
        for st_file in sorted(st_files):
            filename = st_file.name
            output_file = output_project_dir / filename
            
            # 处理文件
            removed_lines = process_st_file(st_file, output_file)
            
            if removed_lines > 0:
                print(f"     ✅ {filename}: 删除前 {removed_lines} 行")
                processed_files += 1
                total_removed_lines += removed_lines
            else:
                print(f"     ⚠️  {filename}: 未删除任何行（保留原样）")
                processed_files += 1
            
            total_files += 1
    
    # 输出统计
    print(f"\n{'='*80}")
    print(f"处理完成")
    print(f"{'='*80}")
    print(f"总项目数: {len(project_dirs)}")
    print(f"总文件数: {total_files}")
    print(f"处理文件数: {processed_files}")
    print(f"总删除行数: {total_removed_lines}")
    print(f"平均每文件删除: {total_removed_lines / processed_files if processed_files > 0 else 0:.1f} 行")


def main():
    """主函数"""
    import argparse
    
    parser = argparse.ArgumentParser(description="处理 project_code/FUN 目录，提取实现部分")
    parser.add_argument(
        "--input",
        type=str,
        default="dataset/project_code",
        help="输入目录（默认: dataset/project_code）"
    )
    parser.add_argument(
        "--output",
        type=str,
        default="dataset/project_code_processed",
        help="输出目录（默认: dataset/project_code_processed）"
    )
    
    args = parser.parse_args()
    
    # 获取项目根目录
    repo_root = Path(__file__).parent
    input_dir = repo_root / args.input
    output_dir = repo_root / args.output
    
    # 检查输入目录是否存在
    if not input_dir.exists():
        print(f"❌ 输入目录不存在: {input_dir}")
        return 1
    
    # 检查输出目录
    if output_dir.exists():
        print(f"\n⚠️  输出目录已存在: {output_dir}")
        response = input("是否删除并重新创建？(y/N): ")
        if response.lower() == 'y':
            print(f"正在删除: {output_dir}")
            shutil.rmtree(output_dir)
            print(f"✓ 已删除")
        else:
            print("已取消")
            return 1
    
    # 处理目录
    try:
        process_project_code(input_dir, output_dir)
        print(f"\n✅ 处理完成！")
        print(f"结果保存在: {output_dir}")
        return 0
    
    except Exception as e:
        print(f"\n❌ 处理出错: {e}")
        import traceback
        traceback.print_exc()
        return 1


if __name__ == "__main__":
    sys.exit(main())



