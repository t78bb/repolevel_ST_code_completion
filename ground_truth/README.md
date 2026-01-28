# Ground Truth 数据处理

此目录用于存放和处理 ground truth（参考）数据。

## 📁 目录结构

```
ground_truth/
├── repoevalreadwriteFile/
│   ├── generations_repoeval-function_repoeval-function.json  # 生成的代码
│   ├── results.jsonl                                          # 元数据
│   ├── outputs.json                                           # 输出结果
│   ├── evaluation_results.json                                # 评估结果
│   └── readful_result/                                        # ⭐ 处理后的 ST 文件
│       ├── ReadFile.st
│       └── WriteFile.st
└── README.md
```

## 🚀 使用方法

### 方法 1: 处理单个项目

处理指定的 ground_truth 子目录：

```bash
python process_ground_truth.py --dir ground_truth/repoevalreadwriteFile
```

### 方法 2: 处理所有项目

处理 ground_truth 下的所有子目录：

```bash
python process_ground_truth.py --all
```

### 方法 3: 使用默认参数

默认处理 `ground_truth/repoevalreadwriteFile`：

```bash
python process_ground_truth.py
```

## 📝 处理流程

脚本会自动执行以下操作：

1. **检查必要文件**
   - `generations_repoeval-function_repoeval-function.json`
   - `results.jsonl`

2. **调用 process_project**
   - 从 `generator/process_generations.py` 导入处理函数
   - 读取 generations 和 results 文件
   - 提取代码并添加定义部分（prefix）

3. **生成 readful_result 目录**
   - 创建 `readful_result/` 子目录
   - 将处理后的代码保存为 `.st` 文件
   - 每个文件包含：定义部分 + 生成的实现部分

4. **添加 provide_code 到文件头部** ⭐ 新增
   - 从 `dataset/query/[项目名]/[函数名].json` 读取 `provide_code` 字段
   - 将 `provide_code` 添加到每个 ST 文件的头部
   - 格式：`provide_code` + 空行 + 原内容

## 📊 输出示例

```
================================================================================
处理 Ground Truth 目录: repoevalreadwriteFile
================================================================================
  ✓ 找到 generations 文件: generations_repoeval-function_repoeval-function.json
  ✓ 找到 results 文件: results.jsonl

  开始处理生成结果，转换为 ST 文件...

  ✅ 成功生成 readful_result 目录
     包含 2 个 ST 文件:
       - ReadFile.st
       - WriteFile.st

  添加 provide_code 到文件头部...
  Query 目录: repoeval_readwriteFile
    ✅ ReadFile.st: 已添加 provide_code (112 字符)
    ✅ WriteFile.st: 已添加 provide_code (109 字符)

  完成: 2/2 个文件已添加 provide_code

  ✅ 处理完成
```

## 🔧 处理逻辑

### 第一步：生成 readful_result（与 `full_process.py` 一致）

1. **读取 generations.json**
   - 获取生成的代码字符串
   - 去除 markdown 代码块标记

2. **读取 results.jsonl**
   - 获取函数名、文件名等元数据
   - 确定输出文件名

3. **获取 prefix（定义部分）**
   - 从 `dataset/query/[项目名]/[函数名].json` 读取
   - 包含函数签名、变量声明等

4. **拼接并保存**
   - 拼接：定义部分 + 生成的实现部分
   - 保存到 `readful_result/[函数名].st`

### 第二步：添加 provide_code 到头部 ⭐ 新增

1. **查找对应的 JSON 文件**
   - 根据 ST 文件名在 `dataset/query/[项目名]/` 下查找
   - 例如：`ReadFile.st` → `ReadFile.json`

2. **读取 provide_code 字段**
   - 包含函数块声明和输入变量定义
   - 例如：`FUNCTION_BLOCK ReadFile\nVAR_INPUT\n...`

3. **添加到文件头部**
   - 格式：`provide_code` + 空行 + 原文件内容
   - 形成完整的 ST 文件结构

### 最终文件结构

```st
FUNCTION_BLOCK ReadFile              ← provide_code
VAR_INPUT
    bExec    :    BOOL;              ← provide_code
    fileName :    STRING;            ← provide_code
END_VAR                              ← provide_code
                                     ← 空行
VAR                                  ← 原 readful_result 内容
    nState   :    BYTE;              ← 原 readful_result 内容
    ...
```

## ⚠️ 注意事项

1. **必需文件**: 必须包含 `generations_xxx.json` 和 `results.jsonl`
2. **项目名称**: 目录名应与 `dataset/query/` 中的项目名对应
3. **覆盖提示**: 如果 `readful_result/` 已存在，会覆盖其中的文件

## 🎯 使用场景

- 处理从其他来源获取的 generation 数据
- 重新处理历史生成结果
- 批量生成标准格式的 ST 文件
- 为评估准备参考数据

## 📊 CodeBLEU 评估

处理完成后，可以使用 `evaluate_ground_truth.py` 评估 CodeBLEU 分数。

### 评估命令

```bash
# 评估所有项目
python evaluate_ground_truth.py --all

# 评估指定项目
python evaluate_ground_truth.py --dir repoevalreadwriteFile

# 指定编程语言
python evaluate_ground_truth.py --dir repoevalreadwriteFile --lang python
```

### 评估输出

```
================================================================================
评估项目: repoevalreadwriteFile
================================================================================
  ✓ 找到 2 个 ST 文件

  📊 找到 2 个样本，开始评估...
    [1/2] 评估 ReadFile.st... ✅ CodeBLEU=0.6234
    [2/2] 评估 WriteFile.st... ✅ CodeBLEU=0.7123

  ✅ 评估完成:
     成功评估: 2/2 个文件
     平均 CodeBLEU: 0.6679
     ...

  💾 结果已保存: ground_truth/repoevalreadwriteFile/codebleu_evaluation.json
```

**注意**: 评估时参考代码来自 `dataset/generation_context_ground_truth/[项目名]/` 目录

### 评估结果文件

每个项目会生成：
- `codebleu_evaluation.json` - 详细评估结果
- `evaluation_summary_[时间戳].json` - 总结报告（在 ground_truth 目录下）

