#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
上下文规划器模块
通过收集待补全函数块被调用位置的相关上下文，对待补全功能做出细致规划
"""

import re
from pathlib import Path
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass


@dataclass
class ContextWindow:
    """代码上下文窗口"""
    file_path: str  # 文件路径
    line_number: int  # 调用/定义所在行号（1-based）
    context_type: str  # 'call' 或 'definition'
    code_window: str  # 上下10行的代码窗口
    surrounding_lines: List[str]  # 原始代码行列表


@dataclass
class PlannerConfig:
    """规划器配置"""
    project_code_root: Path  # project_code 根目录路径
    context_window_size: int = 10  # 上下文窗口大小（上下各N行）
    project_name: Optional[str] = None  # 项目名称（如果为None，则需要在调用时指定）
    function_type: str = "function_block"  # 函数类型：'function_block' 或 'function'


def find_function_occurrences(
    function_name: str,
    project_code_dir: Path,
    function_type: str = "function_block",
    context_window_size: int = 10
) -> List[ContextWindow]:
    """
    在项目代码目录中查找函数的所有调用位置（不包括函数定义本身）
    并提取调用位置上下N行的代码窗口
    
    参数:
        function_name: 待查找的函数名
        project_code_dir: 项目代码目录路径（如 dataset/project_code/counter）
        function_type: 函数类型，'function_block' 或 'function'（默认 'function_block'）
        context_window_size: 上下文窗口大小（默认10行）
    
    返回:
        ContextWindow 对象列表，包含所有找到的调用位置及其上下文
    """
    contexts = []
    
    if not project_code_dir.exists():
        return contexts
    
    # 递归查找所有 .st 文件（排除函数定义所在的文件）
    st_files = list(project_code_dir.rglob("*.st"))
    
    for st_file in st_files:
        try:
            content = st_file.read_text(encoding='utf-8')
            lines = content.split('\n')
            
            # 跳过函数定义文件（不能看函数定义本身）
            if _contains_function_definition(lines, function_name):
                continue
            
            # 根据函数类型选择不同的查找策略
            if function_type.lower() == "function_block":
                # FUNCTION_BLOCK: 找到所有实例声明行（如 F1 : FB_Counter;），然后找到该实例的所有调用位置（如 F1(...)）
                instance_declarations = _find_instance_declarations(lines, function_name)
                
                for instance_name, decl_line_idx in instance_declarations:
                    call_positions = _find_instance_calls(lines, instance_name)
                    
                    for call_line_idx in call_positions:
                        # 提取上下文窗口
                        start_line = max(0, call_line_idx - context_window_size)
                        end_line = min(len(lines), call_line_idx + context_window_size + 1)
                        code_window = '\n'.join(lines[start_line:end_line])
                        surrounding_lines = lines[start_line:end_line]
                        
                        context = ContextWindow(
                            file_path=str(st_file.relative_to(project_code_dir.parent.parent)),
                            line_number=call_line_idx + 1,  # 1-based line number
                            context_type='call',
                            code_window=code_window,
                            surrounding_lines=surrounding_lines
                        )
                        contexts.append(context)
            
            elif function_type.lower() == "function":
                # FUNCTION: 直接找到所有函数调用位置（如 FunctionName(...)）
                function_calls = _find_function_calls(lines, function_name)
                
                for call_line_idx in function_calls:
                    # 提取上下文窗口
                    start_line = max(0, call_line_idx - context_window_size)
                    end_line = min(len(lines), call_line_idx + context_window_size + 1)
                    code_window = '\n'.join(lines[start_line:end_line])
                    surrounding_lines = lines[start_line:end_line]
                    
                    context = ContextWindow(
                        file_path=str(st_file.relative_to(project_code_dir.parent.parent)),
                        line_number=call_line_idx + 1,  # 1-based line number
                        context_type='call',
                        code_window=code_window,
                        surrounding_lines=surrounding_lines
                    )
                    contexts.append(context)
            else:
                raise ValueError(f"不支持的函数类型: {function_type}，必须是 'function_block' 或 'function'")
        
        except Exception as e:
            # 如果文件读取失败，跳过该文件
            print(f"警告: 无法读取文件 {st_file}: {e}")
            continue
    
    return contexts


def _contains_function_definition(lines: List[str], function_name: str) -> bool:
    """
    检查文件是否包含函数定义（需要跳过，因为不能看函数定义本身）
    
    参数:
        lines: 文件的所有行
        function_name: 函数名
    
    返回:
        是否包含函数定义
    """
    for line in lines:
        stripped = line.strip()
        
        # 检查 FUNCTION_BLOCK
        if re.match(rf'^\s*FUNCTION_BLOCK\s+{re.escape(function_name)}\b', stripped, re.IGNORECASE):
            return True
        
        # 检查 FUNCTION
        if re.match(rf'^\s*FUNCTION\s+{re.escape(function_name)}\b', stripped, re.IGNORECASE):
            return True
        
        # 检查 METHOD
        if re.match(rf'^\s*METHOD\s+{re.escape(function_name)}\b', stripped, re.IGNORECASE):
            return True
    
    return False


def _find_instance_declarations(lines: List[str], function_name: str) -> List[Tuple[str, int]]:
    """
    找到所有 FUNCTION_BLOCK 的实例声明行
    例如：F1 : FB_Counter; 或 FB_Counter_0:FB_Counter;
    
    参数:
        lines: 文件的所有行
        function_name: 函数名（FUNCTION_BLOCK 名称）
    
    返回:
        (实例名, 行号) 元组列表，行号是 0-based
    """
    declarations = []
    
    for line_idx, line in enumerate(lines):
        # 去掉所有空格后再匹配，应对各种格式
        # 例如：F1 : FB_Counter; 或 F1:FB_Counter; 或 F1 :FB_Counter; 等
        line_no_spaces = re.sub(r'\s+', '', line)
        
        # 匹配模式：instance_name:function_name;
        pattern = rf'(\w+):{re.escape(function_name)};'
        match = re.search(pattern, line_no_spaces, re.IGNORECASE)
        
        if match:
            instance_name = match.group(1)
            declarations.append((instance_name, line_idx))
    
    return declarations


def _find_instance_calls(lines: List[str], instance_name: str) -> List[int]:
    """
    在文件中找到实例的所有调用位置
    例如：F1(...) 或 F1(param1 := value1, param2 := value2);
    
    参数:
        lines: 文件的所有行
        instance_name: 实例名
    
    返回:
        调用位置的行号列表（0-based）
    """
    call_positions = []
    
    for line_idx, line in enumerate(lines):
        stripped = line.strip()
        
        # 匹配模式：instance_name(...)
        # 例如：F1(...) 或 FB_Counter_0(param1 := value1);
        pattern = rf'\b{re.escape(instance_name)}\s*\('
        if re.search(pattern, stripped, re.IGNORECASE):
            call_positions.append(line_idx)
    
    return call_positions


def _find_function_calls(lines: List[str], function_name: str) -> List[int]:
    """
    找到函数的直接调用位置（用于 FUNCTION 类型）
    例如：FunctionName(...) 或 result := FunctionName(param1, param2);
    
    参数:
        lines: 文件的所有行
        function_name: 函数名
    
    返回:
        调用位置的行号列表（0-based）
    """
    call_positions = []
    
    for line_idx, line in enumerate(lines):
        stripped = line.strip()
        
        # 匹配模式：function_name(...)
        # 但不能是方法调用（instance.function_name(...)）
        # 也不能是声明（: function_name）
        pattern = rf'\b{re.escape(function_name)}\s*\('
        if re.search(pattern, stripped, re.IGNORECASE):
            # 排除方法调用（前面有点号）
            if not re.search(rf'\.\s*{re.escape(function_name)}\s*\(', stripped, re.IGNORECASE):
                call_positions.append(line_idx)
    
    return call_positions


def collect_contexts(
    function_name: str,
    config: PlannerConfig,
    project_name: Optional[str] = None
) -> List[ContextWindow]:
    """
    收集函数的所有上下文（对外暴露的主接口）
    
    参数:
        function_name: 待补全函数的名称
        config: 规划器配置对象
        project_name: 项目名称（可选，如果提供则覆盖 config 中的 project_name）
    
    返回:
        ContextWindow 对象列表，包含所有找到的调用和定义位置及其上下文
    """
    # 确定使用的项目名称
    used_project_name = project_name if project_name is not None else config.project_name
    
    if not used_project_name:
        raise ValueError("必须指定 project_name（通过参数或 config）")
    
    # 构建项目代码目录路径：project_code_root / project_name
    project_code_dir = config.project_code_root / used_project_name
    
    if not project_code_dir.exists():
        raise ValueError(f"项目目录不存在: {project_code_dir}")
    
    contexts = find_function_occurrences(
        function_name=function_name,
        project_code_dir=project_code_dir,
        function_type=config.function_type,
        context_window_size=config.context_window_size
    )
    # print(f"找到 {len(contexts)} 个上下文位置:")
    # for ctx in contexts:
    #     print(f"\n类型: {ctx.context_type}, 文件: {ctx.file_path}, 行号: {ctx.line_number}")
    #     print("代码窗口:")
    #     print(ctx.code_window)
    #     print("-" * 80)
    return contexts


# 示例使用
if __name__ == "__main__":
    # 测试代码
    from pathlib import Path
    
    # 创建配置
    config = PlannerConfig(
        project_code_root=Path(__file__).parent.parent / "dataset" / "project_code",
        context_window_size=10,
        function_type="function_block"  # FB_Counter 是 FUNCTION_BLOCK
    )
    
    # 通过参数指定项目名称和函数名（方便调试时修改）
    function_name = "readFile"
    project_name = "readwriteFile"
    
    contexts = collect_contexts(function_name, config, project_name=project_name)
    
    print(f"找到 {len(contexts)} 个上下文位置:")
    for ctx in contexts:
        print(f"\n类型: {ctx.context_type}, 文件: {ctx.file_path}, 行号: {ctx.line_number}")
        print("代码窗口:")
        print(ctx.code_window)
        print("-" * 80)

