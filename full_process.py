#!/usr/bin/env python3
"""
完整的代码生成和修复流程
对 dataset/query 下的每个项目：
1. 先执行检索（调用 retrieve 模块）
2. 然后执行代码生成（调用 generator 模块）
3. 生成完成后立即执行验证和修复（调用 verifier 模块）
"""
import os
import sys
import subprocess
import json
import shutil
import time
from pathlib import Path
from datetime import datetime
from typing import Optional
from types import SimpleNamespace

# 添加verifier目录到路径，以便导入模块
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'verifier'))
from auto_fix_st_code import auto_fix_st_code

# 添加retrieve目录到路径，以便导入模块
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'retrieve'))
from eval_beir_sbert_canonical import main as retrieval_main

# 智增增API配置 - 从环境变量读取
ZHIZENGZENG_API_KEY = os.getenv("ZHIZENGZENG_API_KEY")
ZHIZENGZENG_BASE_URL = os.getenv("ZHIZENGZENG_BASE_URL", "https://api.zhizengzeng.com/v1")

# CODESYS API 配置
CODESYS_API_URL = os.getenv("CODESYS_API_URL", "http://192.168.103.117:9000/api/v1/pou/project_workflow")


def extract_code_from_markdown(content: str) -> str:
    """如果存在两个```，截取这两个```中间的行"""
    first_idx = content.find('```')
    if first_idx == -1:
        return content
    
    second_idx = content.find('```', first_idx + 3)
    if second_idx == -1:
        return content
    
    extracted = content[first_idx + 3:second_idx].strip()
    
    # 移除可能的语言标识
    if extracted.startswith('st\n') or extracted.startswith('st\r\n'):
        extracted = extracted[3:].lstrip()
    elif extracted.startswith('ST\n') or extracted.startswith('ST\r\n'):
        extracted = extracted[3:].lstrip()
    
    return extracted


def extract_function_name_from_filename(filename: str) -> str:
    """从文件名提取function_name"""
    return os.path.splitext(filename)[0]


def load_results_jsonl(jsonl_path: str) -> list:
    """加载results.jsonl文件"""
    results = []
    if not os.path.exists(jsonl_path):
        return results
    
    with open(jsonl_path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line:
                try:
                    results.append(json.loads(line))
                except json.JSONDecodeError:
                    continue
    
    return results


def find_prompt_by_function_name(results: list, function_name: str) -> Optional[str]:
    """在results.jsonl中找到function_name字段匹配的prompt"""
    for result in results:
        if 'metadata' in result:
            metadata = result['metadata']
            if 'function_name' in metadata and metadata['function_name'] == function_name:
                if 'prompt' in result:
                    return result['prompt']
    return None


def process_prompt_text(prompt: str) -> str:
    """处理prompt中的\t和\n，把它们换成真正的缩进和换行"""
    processed = prompt.replace('\\t', '\t')
    processed = processed.replace('\\n', '\n')
    return processed


# def process_st_file(st_file_path: str, results_jsonl_path: str, output_file_path: str) -> bool:
#     """处理单个ST文件，添加prompt并保存"""
#     with open(st_file_path, 'r', encoding='utf-8') as f:
#         st_content = f.read()
    
#     st_content = extract_code_from_markdown(st_content)
#     filename = os.path.basename(st_file_path)
#     function_name = extract_function_name_from_filename(filename)
    
#     results = load_results_jsonl(results_jsonl_path)
#     prompt = find_prompt_by_function_name(results, function_name)
    
#     if prompt is None:
#         final_content = st_content
#     else:
#         processed_prompt = process_prompt_text(prompt)
#         lower_prompt = processed_prompt.lstrip().lower()
#         end_suffix = ""
#         st_body = st_content.rstrip()
#         if lower_prompt.startswith("function "):
#             if not st_body.lower().endswith("end_function"):
#                 end_suffix = "END_FUNCTION"
#         elif lower_prompt.startswith("function_block "):
#             if not st_body.lower().endswith("end_function_block"):
#                 end_suffix = "END_FUNCTION_BLOCK"
        
#         parts = [processed_prompt.rstrip(), st_body]
#         if end_suffix:
#             parts.append(end_suffix)
#         final_content = "\n\n".join(parts) + "\n"
    
#     os.makedirs(os.path.dirname(output_file_path), exist_ok=True)
#     with open(output_file_path, 'w', encoding='utf-8') as f:
#         f.write(final_content)
    
#     return prompt is not None


def run_retrieve(query_dir: Path, result_dir_name: str, output_base_dir: Path, data_base_dir: Path) -> bool:
    """
    对指定的 query 目录执行检索（直接函数调用）
    
    Args:
        query_dir: query 目录路径（例如 dataset/query/repoeval_xxx）
        result_dir_name: 结果目录名称
        output_base_dir: 输出基础目录（通常是 output）
        data_base_dir: 数据基础目录（包含 corpus.jsonl 等）
    
    Returns:
        是否成功
    """
    print(f"\n{'='*80}")
    print(f"开始检索: {query_dir.name}")
    print(f"{'='*80}")
    
    # 检查是否有 JSON 文件
    json_files = list(query_dir.glob("*.json"))
    if not json_files:
        print(f"  ⚠ 跳过: query 目录下没有 JSON 文件: {query_dir}")
        return False
    
    print(f"  找到 {len(json_files)} 个查询文件")
    
    try:
        # 从项目名提取 dataset 名称（query 目录名就是 dataset 名）
        dataset_name = query_dir.name
        
        # 创建参数对象（调用 eval_beir_sbert_canonical.py 的 main 函数）
        retrieval_args = SimpleNamespace(
            dataset=dataset_name,
            query_dir=str(query_dir),
            result_dir=result_dir_name,
            output_base_dir=str(output_base_dir),
            data_base_dir=str(data_base_dir),
            model="BAAI/bge-base-en-v1.5",
            batch_size=64,
            dataset_path="output/origin_repoeval/datasets/function_level_completion_2k_context_codex.test.clean.jsonl",
            output_file="outputs.json",
            results_file="results.jsonl"
        )
        
        # 直接调用检索函数（非 main，是 eval_beir_sbert_canonical.py 的 main 函数）
        retrieval_main(retrieval_args)
        
        print(f"  ✓ 检索成功")
        return True
        
    except KeyboardInterrupt:
        print(f"\n  ✗ 用户中断")
        raise
    except Exception as e:
        print(f"  ✗ 检索异常: {str(e)}")
        import traceback
        traceback.print_exc()
        return False


def run_generation(dataset_dir: Path, result_dir_name: str) -> bool:
    """
    对指定数据集目录执行代码生成（直接函数调用）
    返回: 是否成功
    """
    print(f"\n{'='*80}")
    print(f"开始生成代码: {dataset_dir.name}")
    print(f"{'='*80}")
    
    # 检查 results.jsonl 是否存在
    results_jsonl = dataset_dir / "results.jsonl"
    if not results_jsonl.exists():
        print(f"  ⚠ 跳过: results.jsonl 文件不存在: {results_jsonl}")
        return False
    
    try:
        # 导入 generator 模块
        import sys
        script_dir = Path(__file__).resolve().parent
        generator_dir = script_dir / "generator"
        if str(generator_dir) not in sys.path:
            sys.path.insert(0, str(generator_dir))
        
        from eval.evaluator import ApiEvaluator
        from types import SimpleNamespace
        
        # 创建参数对象（使用 SimpleNamespace 来存储所有参数）
        args = SimpleNamespace()
        args.model_backend = "api"
        args.model = "gpt-4o"
        args.dataset_path = "json"
        args.data_files_test = str(results_jsonl)
        args.topk_docs = 5
        args.max_length_input = 2048
        args.max_length_generation = 1024
        args.temperature = 0.2
        args.top_p = 0.95
        args.save_generations = True
        args.result_dir = result_dir_name
        args.tasks = "repoeval-function"
        args.generation_only = True
        args.limit = None
        args.limit_start = 0
        args.save_every_k_tasks = -1
        args.n_samples = 1
        args.remove_linebreak = False
        args.save_generations_path = "generations.json"
        args.metric_output_path = "evaluation_results.json"
        args.prefix = ""
        args.do_sample = True
        args.top_k = 0
        args.eos = "<|endoftext|>"
        args.ignore_eos = False
        args.seed = 0
        args.batch_size = 1
        args.postprocess = True
        args.check_references = False
        args.load_generations_path = None
        args.load_generations_intermediate_paths = None
        args.allow_code_execution = False  # 代码执行权限
        args.save_references = False  # 是否保存参考结果
        args.save_references_path = "references.json"
        args.new_tokens_only = False
        args.instruction_tokens = None
        args.dataset_name = None
        args.cache_dir = None
        args.prompt = "prompt"  # Prompt type for HumanEvalPack tasks
        args.setup_repoeval = False
        args.repoeval_input_repo_dir = "../retrieval/output/codesys_repo"
        args.repoeval_cache_dir = "scripts/repoeval"
        
        # 设置 data_files
        args.data_files = {"test": args.data_files_test}
        
        # 处理输出路径：生成结果保存在 output/{result_dir}/{dataset_dir}/ 下
        import os
        import shutil
        output_dir = script_dir / "output"
        result_dir = output_dir / result_dir_name
        output_project_dir = result_dir / dataset_dir.name
        output_project_dir.mkdir(parents=True, exist_ok=True)
        
        # 复制 results.jsonl 到输出目录（process_project 需要它）
        target_results_jsonl = output_project_dir / "results.jsonl"
        if results_jsonl.exists():
            try:
                # 方法1: 尝试直接复制（最快）
                shutil.copy2(results_jsonl, target_results_jsonl)
                print(f"  已复制 results.jsonl 到输出目录")
            except (PermissionError, OSError) as e:
                # 方法2: 如果文件被占用，尝试读取内容后写入（避免文件锁定）
                print(f"  ⚠ 文件被占用，尝试读取内容后写入...")
                try:
                    import time
                    # 等待一小段时间后重试
                    for retry in range(3):
                        time.sleep(0.5)
                        try:
                            # 读取源文件内容
                            with open(results_jsonl, 'r', encoding='utf-8') as src:
                                content = src.read()
                            # 写入目标文件
                            with open(target_results_jsonl, 'w', encoding='utf-8') as dst:
                                dst.write(content)
                            print(f"  ✓ 通过读取-写入方式成功复制 results.jsonl")
                            break
                        except (PermissionError, OSError):
                            if retry == 2:
                                # 最后一次尝试：如果目标文件已存在，直接使用它
                                if target_results_jsonl.exists():
                                    print(f"  ⚠ 无法复制，但目标文件已存在，将使用现有文件")
                                    break
                                else:
                                    raise Exception(f"无法复制 results.jsonl: 文件被占用且无法读取")
                except Exception as e2:
                    # 方法3: 如果还是失败，检查目标文件是否已存在
                    if target_results_jsonl.exists():
                        print(f"  ⚠ 无法复制，但目标文件已存在，将使用现有文件")
                    else:
                        print(f"  ✗ 错误: 无法复制 results.jsonl")
                        print(f"     源文件: {results_jsonl}")
                        print(f"     目标文件: {target_results_jsonl}")
                        print(f"     错误: {e2}")
                        print(f"\n  建议:")
                        print(f"  1. 关闭所有打开该文件的程序（IDE、编辑器等）")
                        print(f"  2. 检查是否有其他 Python 进程正在使用该文件")
                        print(f"  3. 如果目标文件已存在，可以手动删除后重试")
                        raise
        
        # 设置生成文件路径（注意：evaluator.save_json_files 会添加任务名称后缀）
        base_generations_path = str(output_project_dir / "generations_repoeval-function.json")
        args.save_generations_path = base_generations_path
        args.metric_output_path = str(output_project_dir / "evaluation_results.json")
        
        print(f"  输出目录: {output_project_dir}")
        print(f"  生成文件: {base_generations_path}")
        
        # 创建 evaluator 并执行生成
        evaluator = ApiEvaluator(args.model, args)
        task_name = "repoeval-function"
        generations, references = evaluator.generate_text(task_name)
        
        # 保存生成结果（按照 main.py 的逻辑，会添加任务名称后缀）
        # 实际保存的文件名会是: generations_repoeval-function_repoeval-function.json
        save_generations_path = f"{os.path.splitext(base_generations_path)[0]}_{task_name}.json"
        save_references_path = f"{os.path.splitext(base_generations_path)[0]}_references.json"
        evaluator.save_json_files(
            generations,
            references,
            save_generations_path,
            save_references_path
        )
        
        print(f"  实际保存文件: {save_generations_path}")
        
        # 处理生成结果，转换为 ST 文件（生成 readful_result 目录）
        print(f"  开始处理生成结果，转换为 ST 文件...")
        from process_generations import process_project
        from types import SimpleNamespace as NS
        process_args = NS(verbose=True, dry_run=False)
        process_project(output_project_dir, process_args)
        
        # 检查 readful_result 目录是否创建成功
        readful_result_dir = output_project_dir / "readful_result"
        if readful_result_dir.exists():
            st_files = list(readful_result_dir.glob("*.st"))
            print(f"  ✓ 已生成 readful_result 目录，包含 {len(st_files)} 个 ST 文件")
        else:
            print(f"  ⚠ 警告: readful_result 目录未创建")
        
        print(f"  ✓ 生成成功")
        return True
    
    except Exception as e:
        print(f"  ✗ 生成异常: {str(e)}")
        import traceback
        traceback.print_exc()
        return False


def run_fix(dataset_dir: Path, output_dir: Path) -> bool:
    """
    对指定数据集目录执行验证和修复
    返回: 是否成功
    """
    print(f"\n{'='*80}")
    print(f"开始验证和修复: {dataset_dir.name}")
    print(f"{'='*80}")
    
    # 检查必要的目录和文件
    readful_result_dir = dataset_dir / 'readful_result'
    results_jsonl_path = dataset_dir / 'results.jsonl'
    
    if not readful_result_dir.exists():
        print(f"  ⚠ 跳过: 未找到readful_result目录")
        return False
    
    if not results_jsonl_path.exists():
        print(f"  ⚠ 跳过: 未找到results.jsonl文件")
        return False
    
    # 创建输出目录结构
    output_subdir = output_dir / dataset_dir.name
    output_readful_result = output_subdir / 'readful_result'
    output_readful_result.mkdir(parents=True, exist_ok=True)
    
    # 复制其他文件
    for file in dataset_dir.iterdir():
        if file.is_file() and file.name != 'results.jsonl':
            shutil.copy2(file, output_subdir / file.name)
    
    # 复制results.jsonl
    shutil.copy2(results_jsonl_path, output_subdir / 'results.jsonl')
    
    # 处理readful_result中的所有st文件
    st_files = list(readful_result_dir.glob('*.st'))
    print(f"  找到 {len(st_files)} 个ST文件")
    
    if len(st_files) == 0:
        print(f"  ⚠ 没有ST文件需要处理")
        return False
    
    # 历史版本目录
    history_dir = output_subdir / 'readful_result_history'
    history_dir.mkdir(parents=True, exist_ok=True)
    
    success_count = 0
    for st_file in st_files:
        filename = st_file.name
        print(f"\n  处理文件: {filename}")
        
        # 目标 ST 文件路径（位于 *_fixed 目录下）
        output_st_file = output_readful_result / filename
        
        # 确保修复前目标目录中已经有一份待修复的代码：
        # 目前生成阶段在原 result_dir 下的 readful_result 中已经完成了
        # 「定义部分 + 实现部分」的拼接，这里只需要把源文件复制到 *_fixed 目录下。
        try:
            shutil.copy2(st_file, output_st_file)
        except Exception as e:
            print(f"    ✗ 无法复制 ST 文件到修复目录: {e}")
            continue
        
        # 进行自动修复
        print(f"    开始自动修复...")

        project_name = dataset_dir.name[9:] #获取项目名称
        # 使用 Path 构建路径，更安全可靠
        path = Path(r"D:\graduate_project\codesys_call\CODESYSCompileService-main\projects") / f"{project_name}.project"

        try:
            fixed_code, success, count = auto_fix_st_code(
                str(output_st_file),
                project_name=str(path),  # 转换为字符串，避免 JSON 序列化错误
                max_verify_count=3,
                ip_port=CODESYS_API_URL,
                use_openai=True,
                openai_api_key=ZHIZENGZENG_API_KEY,
                base_url=ZHIZENGZENG_BASE_URL,
                model="gpt-4o",
                version_save_dir=str(history_dir)
            )
            
            if success:
                print(f"    ✓ 修复成功！共尝试 {count} 次")
                success_count += 1
                with open(output_st_file, 'w', encoding='utf-8') as f:
                    f.write(fixed_code)
            else:
                print(f"    ✗ 修复失败，已达到最大尝试次数 ({count})")
                with open(output_st_file, 'w', encoding='utf-8') as f:
                    f.write(fixed_code)
        
        except Exception as e:
            print(f"    ✗ 修复过程出错: {e}")
            import traceback
            traceback.print_exc()
    
    print(f"\n  ✓ 修复完成: {success_count}/{len(st_files)} 个文件修复成功")
    return success_count > 0


def main():
    import argparse
    parser = argparse.ArgumentParser(description="完整的代码生成和修复流程")
    parser.add_argument(
        "--result_dir",
        type=str,
        default=None,
        help="Directory name under output to process. If not provided, will use timestamp."
    )
    parser.add_argument(
        "--case",
        type=str,
        default=None,
        help="只处理某个特定的 case 目录名"
    )
    parser.add_argument(
        "--skip_generation",
        action="store_true",
        help="跳过生成步骤，只执行修复"
    )
    parser.add_argument(
        "--skip_fix",
        action="store_true",
        help="跳过修复步骤，只执行生成"
    )
    parser.add_argument(
        "--skip_retrieve",
        action="store_true",
        help="跳过检索步骤（如果已指定 --result_dir，则自动跳过检索）"
    )
    parser.add_argument(
        "--project",
        type=str,
        nargs="+",
        default=None,
        help="指定要处理的项目名称（可以指定多个，例如：--project repoeval_四层电梯控制实训 repoeval_交通信号灯控制实训）。如果不指定，则处理所有项目。仅在执行检索时有效。"
    )
    args = parser.parse_args()
    
    # 检查API配置
    if not ZHIZENGZENG_API_KEY and not args.skip_fix:
        print("错误: 未配置API密钥！")
        print("请在CMD中设置环境变量:")
        print("  set ZHIZENGZENG_API_KEY=你的API密钥")
        print("  set ZHIZENGZENG_BASE_URL=https://api.zhizengzeng.com/v1")
        sys.exit(1)
    
    script_dir = Path(__file__).resolve().parent
    output_dir = script_dir / "output"
    
    if not output_dir.exists():
        output_dir.mkdir(parents=True, exist_ok=True)
    
    # 确定执行模式：是否从 query 开始（需要执行 retrieve）
    use_query_mode = not args.result_dir and not args.skip_retrieve
    
    if use_query_mode:
        # 从 query 目录开始，需要执行 retrieve
        print("="*80)
        print("执行模式: 从需求开始（检索 + 生成 + 修复）")
        print("="*80)
        
        # 设置路径
        query_base_dir = script_dir / "dataset" / "query"
        data_base_dir = script_dir / "dataset" / "BEIR_data"
        
        # 检查目录是否存在
        if not query_base_dir.exists():
            print(f"错误: query 目录不存在: {query_base_dir}")
            sys.exit(1)
        
        # 如果 BEIR_data 不存在，尝试其他位置
        if not data_base_dir.exists():
            stable_data_dir = script_dir / "output" / "stable_data"
            if stable_data_dir.exists():
                data_base_dir = stable_data_dir
            else:
                data_base_dir = script_dir / "output"
        
        # 生成时间戳作为结果目录名称
        result_dir_name = datetime.now().strftime("%Y%m%d_%H%M%S")
        
        # 获取要处理的 query 子目录
        if args.project:
            # 指定了项目，只处理这些项目
            query_dirs = []
            for project_name in args.project:
                project_path = query_base_dir / project_name
                if project_path.exists() and project_path.is_dir():
                    query_dirs.append(project_path)
                else:
                    print(f"⚠ 警告: 项目目录不存在: {project_path}")
            query_dirs.sort(key=lambda x: x.name)
            if not query_dirs:
                print(f"错误: 没有找到任何指定的项目目录")
                sys.exit(1)
            print(f"\n指定处理 {len(query_dirs)} 个项目: {[p.name for p in query_dirs]}")
        else:
            # 未指定项目，处理所有项目
            query_dirs = [d for d in query_base_dir.iterdir() if d.is_dir()]
            query_dirs.sort(key=lambda x: x.name)
            if not query_dirs:
                print(f"警告: {query_base_dir} 下没有子目录")
                sys.exit(0)
        
        print(f"\nQuery 基础目录: {query_base_dir}")
        print(f"输出基础目录: {output_dir}")
        print(f"结果目录名称: {result_dir_name}")
        print(f"待处理项目数: {len(query_dirs)}")
        print(f"\n项目列表:")
        for i, d in enumerate(query_dirs, 1):
            print(f"  {i}. {d.name}")
        
        # 将 query_dirs 转换为后续处理需要的格式
        # 每个项目会依次执行: retrieve → generation → verifier
        projects_to_process = []
        for query_dir in query_dirs:
            # 检索后的输出目录会是 output/{result_dir_name}/{query_dir.name}/
            # 这个目录会包含 results.jsonl
            projects_to_process.append({
                "name": query_dir.name,
                "query_dir": query_dir,
                "dataset_dir": None,  # 检索后会被设置
                "type": "query"  # 标记为从 query 开始
            })
    else:
        # 从已有的 result_dir 开始，不需要执行 retrieve
        print("="*80)
        print("执行模式: 从已有结果开始（生成 + 修复）")
        print("="*80)
        
        # 确定要处理的 case 目录
        if args.result_dir:
            # 如果指定了 result_dir，将该目录下的所有子目录都当作 case
            result_dir_path = output_dir / args.result_dir
            if not result_dir_path.exists():
                print(f"错误: 结果目录不存在: {result_dir_path}")
                sys.exit(1)
            # 获取该目录下的所有子目录作为 case
            case_dirs = [d for d in result_dir_path.iterdir() if d.is_dir()]
            if not case_dirs:
                print(f"错误: 结果目录下没有子目录: {result_dir_path}")
                sys.exit(1)
            result_dir_name = args.result_dir
            print(f"\n指定了 --result_dir: {result_dir_name}")
            print(f"该目录下有 {len(case_dirs)} 个子目录，将作为 case 处理")
        else:
            # 从 output 目录中查找最新的目录
            case_dirs = [d for d in output_dir.iterdir() if d.is_dir()]
            if not case_dirs:
                print(f"错误: {output_dir} 下没有子目录")
                sys.exit(1)
            # 使用最新的目录作为 result_dir_name（通常是时间戳）
            case_dirs.sort(key=lambda x: x.stat().st_mtime, reverse=True)
            result_dir_name = case_dirs[0].name
            print(f"\n使用最新的结果目录: {result_dir_name}")
            case_dirs.sort(key=lambda x: x.name)  # 重新按名称排序
        
        # 将 case_dirs 转换为后续处理需要的格式
        projects_to_process = []
        for case_dir in case_dirs:
            # 判断 case 目录的结构
            case_has_results = (case_dir / "results.jsonl").exists()
            if case_has_results:
                # case 目录本身就是数据集目录
                projects_to_process.append({
                    "name": case_dir.name,
                    "query_dir": None,
                    "dataset_dir": case_dir,
                    "type": "existing"  # 标记为已有结果
                })
            else:
                # case 目录下还有数据集子目录
                dataset_dirs = [d for d in case_dir.iterdir() if d.is_dir()]
                for dataset_dir in dataset_dirs:
                    projects_to_process.append({
                        "name": f"{case_dir.name}/{dataset_dir.name}",
                        "query_dir": None,
                        "dataset_dir": dataset_dir,
                        "type": "existing"
                    })
    
    # 如果指定了 --case，只处理该 case
    if args.case:
        projects_to_process = [p for p in projects_to_process if args.case in p["name"]]
        if not projects_to_process:
            print(f"错误: 没有找到 case {args.case}")
            sys.exit(1)
    
    # 检查并删除已存在的 {result_dir_name}_fixed 目录（如果使用 query 模式）
    if use_query_mode:
        fixed_dir = output_dir / f"{result_dir_name}_fixed"
        if fixed_dir.exists():
            print(f"\n检测到已存在的修复结果目录: {fixed_dir}")
            print(f"正在删除该目录...")
            try:
                shutil.rmtree(fixed_dir)
                print(f"✓ 已成功删除: {fixed_dir}")
            except Exception as e:
                print(f"✗ 删除失败: {e}")
                print(f"  请手动删除该目录后重试")
                sys.exit(1)
        else:
            print(f"\n修复结果目录不存在，将创建: {fixed_dir}")
    
    print("="*80)
    if use_query_mode:
        print("完整流程：检索 + 代码生成 + 验证修复（每个项目依次执行）")
    else:
        print("完整流程：代码生成 + 验证修复")
    print("="*80)
    print(f"\n待处理项目数: {len(projects_to_process)}")
    print(f"项目列表:")
    for i, p in enumerate(projects_to_process, 1):
        print(f"  {i}. {p['name']}")
    
    # 记录结果
    results = {
        "success": [],
        "failed": [],
        "skipped": []
    }
    
    # 统计每个项目处理的文件数量
    project_statistics = {}  # {project_name: {"total_cases": int}}
    
    print(f"\n开始执行...")
    print("="*80)
    
    # 设置数据基础目录（用于 retrieve）
    if use_query_mode:
        data_base_dir = script_dir / "dataset" / "BEIR_data"
        if not data_base_dir.exists():
            stable_data_dir = script_dir / "output" / "stable_data"
            if stable_data_dir.exists():
                data_base_dir = stable_data_dir
            else:
                data_base_dir = script_dir / "output"
    
    # 对每个项目依次执行：retrieve → generation → verifier
    for idx, project_info in enumerate(projects_to_process, 1):
        project_name = project_info["name"]
        print(f"\n\n{'#'*80}")
        print(f"# [{idx}/{len(projects_to_process)}] 处理项目: {project_name}")
        print(f"{'#'*80}")
        
        project_success = True
        dataset_dir = None
        
        # 步骤0: 检索（如果需要）
        if use_query_mode and not args.skip_retrieve:
            query_dir = project_info["query_dir"]
            print(f"\n  [步骤 0/3] 执行检索: {query_dir.name}")
            print(f"  {'-'*76}")
            
            retrieve_success = run_retrieve(query_dir, result_dir_name, output_dir, data_base_dir)
            if not retrieve_success:
                project_success = False
                results["failed"].append({
                    "project": project_name,
                    "step": "retrieve",
                    "error": "检索失败"
                })
                continue
            
            # 检索成功后，设置 dataset_dir 为检索输出目录
            dataset_dir = output_dir / result_dir_name / query_dir.name
            if not dataset_dir.exists() or not (dataset_dir / "results.jsonl").exists():
                print(f"  ✗ 检索结果目录不存在或缺少 results.jsonl: {dataset_dir}")
                project_success = False
                results["failed"].append({
                    "project": project_name,
                    "step": "retrieve",
                    "error": "检索结果目录不存在"
                })
                continue
        else:
            # 使用已有的 dataset_dir
            dataset_dir = project_info["dataset_dir"]
            if dataset_dir is None or not dataset_dir.exists():
                print(f"  ⚠ 跳过: dataset_dir 不存在")
                results["skipped"].append({
                    "project": project_name,
                    "reason": "dataset_dir 不存在"
                })
                continue
        
        # 统计该数据集处理的 case 数量（从 results.jsonl 读取）
        dataset_case_count = 0
        results_jsonl = dataset_dir / "results.jsonl"
        if results_jsonl.exists():
            dataset_case_count = len(load_results_jsonl(str(results_jsonl)))
        
        # 步骤1: 代码生成
        if not args.skip_generation:
            print(f"\n  [步骤 {'1' if not use_query_mode or args.skip_retrieve else '1/3'}] 执行代码生成: {dataset_dir.name}")
            print(f"  {'-'*76}")
            
            gen_success = run_generation(dataset_dir, result_dir_name)
            if not gen_success:
                project_success = False
                results["failed"].append({
                    "project": project_name,
                    "step": "generation",
                    "error": "生成失败"
                })
                continue
        else:
            print(f"  跳过生成步骤（--skip_generation）")
        
        # 步骤2: 验证和修复
        if not args.skip_fix:
            print(f"\n  [步骤 {'2' if not use_query_mode or args.skip_retrieve else '2/3'}] 执行验证和修复: {dataset_dir.name}")
            print(f"  {'-'*76}")
            
            # 确定输出目录
            if use_query_mode:
                output_fixed_dir = output_dir / f"{result_dir_name}_fixed"
            elif args.result_dir:
                output_fixed_dir = output_dir / f"{result_dir_name}_fixed"
            else:
                output_fixed_dir = output_dir / f"{project_name}_fixed"
            
            fix_success = run_fix(dataset_dir, output_fixed_dir)
            if not fix_success:
                project_success = False
                results["failed"].append({
                    "project": project_name,
                    "step": "fix",
                    "error": "修复失败"
                })
        else:
            print(f"  跳过修复步骤（--skip_fix）")
        
        # 更新统计信息
        if project_name not in project_statistics:
            project_statistics[project_name] = {"total_cases": 0}
        project_statistics[project_name]["total_cases"] = dataset_case_count
        
        if project_success:
            print(f"\n  ✓ 项目 {project_name} 处理完成（{dataset_case_count} 个 case）")
            results["success"].append(project_name)
    
    # 输出总结
    print("\n" + "="*80)
    print("执行总结")
    print("="*80)
    print(f"\n总项目数: {len(projects_to_process)}")
    print(f"成功: {len(results['success'])}")
    print(f"失败: {len(results['failed'])}")
    print(f"跳过: {len(results['skipped'])}")
    
    # 输出每个项目处理的 case 数量统计
    print("\n" + "="*80)
    print("Case 数量统计")
    print("="*80)
    total_all_cases = 0
    for project_name, stats in sorted(project_statistics.items()):
        total_cases = stats["total_cases"]
        total_all_cases += total_cases
        print(f"\n项目: {project_name}")
        print(f"  总 case 数: {total_cases}")
    
    print(f"\n{'='*80}")
    print(f"所有项目处理的 case 总数: {total_all_cases}")
    print(f"{'='*80}")
    
    if results["success"]:
        print(f"\n✓ 成功的项目 ({len(results['success'])}):")
        for project in results["success"]:
            case_count = project_statistics.get(project, {}).get("total_cases", 0)
            print(f"  - {project} ({case_count} 个 case)")
    
    if results["failed"]:
        print(f"\n✗ 失败的项目 ({len(results['failed'])}):")
        for item in results["failed"]:
            print(f"  - {item['project']} (步骤: {item['step']}): {item['error']}")
    
    if results["skipped"]:
        print(f"\n⚠ 跳过的项目 ({len(results['skipped'])}):")
        for item in results["skipped"]:
            print(f"  - {item['project']}: {item['reason']}")
    
    # 保存结果到文件
    result_file = f"full_process_results_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    with open(result_file, 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2, ensure_ascii=False)
    print(f"\n详细结果已保存到: {result_file}")
    
    # 如果有失败，返回非零退出码
    if results["failed"]:
        sys.exit(1)


if __name__ == "__main__":
    main()

