#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
为 ground truth 文件添加完整的定义部分和结束标记
从 BEIR_data/queries.jsonl 中提取定义，与 readful_result 合并生成 full_result
"""

import os
import sys
import json
from pathlib import Path
from typing import Dict, Optional

# 项目根目录
REPO_ROOT = Path(__file__).parent.parent.parent

# 相关目录路径
GROUND_TRUTH_ROOT = REPO_ROOT / "real_groud_truth最新"
BEIR_DATA_ROOT = REPO_ROOT / "dataset" / "BEIR_data"


def load_queries_mapping(queries_file: Path) -> Dict[str, Dict]:
    """
    加载 queries.jsonl 文件并构建 function_name -> query 的映射
    
    参数:
        queries_file: queries.jsonl 文件路径
    
    返回:
        function_name -> query_data 的映射字典
    """
    mapping = {}
    
    if not queries_file.exists():
        return mapping
    
    try:
        with open(queries_file, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                    
                query = json.loads(line)
                metadata = query.get('metadata', {})
                function_name = metadata.get('function_name')
                
                if function_name:
                    mapping[function_name] = {
                        'text': query.get('text', ''),
                        'task_id': metadata.get('task_id', ''),
                        'ground_truth': metadata.get('ground_truth', '')
                    }
    except Exception as e:
        print(f"  ⚠️ 读取 queries.jsonl 失败: {e}")
        return {}
    
    return mapping


def detect_pou_type(text: str) -> Optional[str]:
    """
    检测文本中的 POU 类型（FUNCTION 或 FUNCTION_BLOCK）
    
    参数:
        text: 定义文本
    
    返回:
        'FUNCTION' 或 'FUNCTION_BLOCK' 或 None
    """
    text_upper = text.upper()
    
    # 检查 FUNCTION_BLOCK（必须在 FUNCTION 之前检查，因为包含 FUNCTION）
    if 'FUNCTION_BLOCK' in text_upper:
        return 'FUNCTION_BLOCK'
    
    # 检查 FUNCTION
    if 'FUNCTION' in text_upper:
        return 'FUNCTION'
    
    # 检查 METHOD
    if 'METHOD' in text_upper:
        return 'METHOD'
    
    return None


def get_end_marker(pou_type: str) -> str:
    """
    根据 POU 类型返回对应的结束标记
    
    参数:
        pou_type: POU 类型
    
    返回:
        结束标记字符串
    """
    if pou_type == 'FUNCTION_BLOCK':
        return 'END_FUNCTION_BLOCK'
    elif pou_type == 'FUNCTION':
        return 'END_FUNCTION'
    elif pou_type == 'METHOD':
        return 'END_METHOD'
    else:
        return 'END_FUNCTION_BLOCK'  # 默认


def process_project(project_dir: Path) -> int:
    """
    处理单个项目目录
    
    参数:
        project_dir: 项目目录路径
    
    返回:
        成功处理的文件数量
    """
    project_name = project_dir.name
    readful_result_dir = project_dir / "readful_result"
    full_result_dir = project_dir / "full_result"
    
    # 检查 readful_result 目录是否存在
    if not readful_result_dir.exists():
        print(f"  ⚠️ readful_result 目录不存在，跳过")
        return 0
    
    # 查找对应的 BEIR_data 目录
    beir_project_dir = BEIR_DATA_ROOT / project_name
    queries_file = beir_project_dir / "queries.jsonl"
    
    if not queries_file.exists():
        print(f"  ⚠️ queries.jsonl 文件不存在: {queries_file}")
        return 0
    
    # 加载 queries 映射
    queries_mapping = load_queries_mapping(queries_file)
    
    if not queries_mapping:
        print(f"  ⚠️ queries.jsonl 为空或无法解析")
        return 0
    
    print(f"  加载了 {len(queries_mapping)} 个 function 定义")
    
    # 创建 full_result 目录
    full_result_dir.mkdir(parents=True, exist_ok=True)
    
    # 处理每个 .st 文件
    st_files = list(readful_result_dir.glob("*.st"))
    success_count = 0
    
    for st_file in sorted(st_files):
        # 提取 function name（去掉 .st 扩展名）
        function_name = st_file.stem
        
        # 查找对应的 query
        if function_name not in queries_mapping:
            print(f"    ⚠️ {st_file.name}: 未找到对应的 function 定义")
            continue
        
        query_data = queries_mapping[function_name]
        definition_text = query_data['text']
        
        # 检测 POU 类型
        pou_type = detect_pou_type(definition_text)
        
        if not pou_type:
            print(f"    ⚠️ {st_file.name}: 无法检测 POU 类型")
            continue
        
        end_marker = get_end_marker(pou_type)
        
        # 读取 readful_result 中的文件内容
        try:
            implementation_content = st_file.read_text(encoding='utf-8')
        except Exception as e:
            print(f"    ⚠️ {st_file.name}: 读取失败 - {e}")
            continue
        
        # 组合完整内容：定义 + 空行 + 实现 + 结束标记
        full_content_lines = []
        full_content_lines.append(definition_text)
        full_content_lines.append('')  # 空行
        full_content_lines.append(implementation_content)
        
        # 检查是否已经有结束标记
        if not implementation_content.strip().endswith(end_marker):
            full_content_lines.append(end_marker)
        
        full_content = '\n'.join(full_content_lines)
        
        # 写入 full_result 目录
        output_file = full_result_dir / st_file.name
        try:
            output_file.write_text(full_content, encoding='utf-8')
            print(f"    ✓ {st_file.name} -> {pou_type} -> {end_marker}")
            success_count += 1
        except Exception as e:
            print(f"    ⚠️ {st_file.name}: 写入失败 - {e}")
    
    return success_count


def main():
    """主函数"""
    print("="*80)
    print("为 Ground Truth 文件添加完整定义和结束标记")
    print("="*80)
    print(f"Ground Truth 根目录: {GROUND_TRUTH_ROOT}")
    print(f"BEIR Data 根目录: {BEIR_DATA_ROOT}")
    print("="*80)
    
    if not GROUND_TRUTH_ROOT.exists():
        print(f"错误: Ground Truth 目录不存在 - {GROUND_TRUTH_ROOT}")
        return 1
    
    if not BEIR_DATA_ROOT.exists():
        print(f"错误: BEIR Data 目录不存在 - {BEIR_DATA_ROOT}")
        return 1
    
    # 查找所有项目目录
    project_dirs = []
    for item in GROUND_TRUTH_ROOT.iterdir():
        if item.is_dir() and (item / "readful_result").exists():
            project_dirs.append(item)
    
    if not project_dirs:
        print(f"未找到包含 readful_result 的项目目录")
        return 1
    
    print(f"\n找到 {len(project_dirs)} 个项目\n")
    
    # 处理每个项目
    total_success = 0
    for idx, project_dir in enumerate(sorted(project_dirs), 1):
        print(f"[{idx}/{len(project_dirs)}] 处理项目: {project_dir.name}")
        success_count = process_project(project_dir)
        total_success += success_count
        print(f"  完成: {success_count} 个文件\n")
    
    print("="*80)
    print(f"处理完成")
    print(f"总共处理了 {len(project_dirs)} 个项目")
    print(f"成功生成 {total_success} 个完整文件")
    print("="*80)
    
    return 0


if __name__ == "__main__":
    exit(main())

