# 修复历史评估工具

## 📋 功能说明

`evaluate_history.py` 用于评估 `readful_result_history` 目录中每个历史版本的 CodeBLEU 分数，分析修复过程中代码质量的变化趋势。

## 🎯 用途

- ✅ 评估修复过程中每次迭代的代码质量
- ✅ 分析修复趋势（改进/下降/不变）
- ✅ 对比首次版本和最终版本的差异
- ✅ 识别修复过程中的关键改进点

## 🚀 使用方法

### 基本命令

```bash
cd analysis_script
python evaluate_history.py --timestamp <时间戳> --project <项目名>
```

### 参数说明

| 参数 | 必需 | 说明 | 示例 |
|------|------|------|------|
| `--timestamp` | ✅ | 时间戳目录 | `20260122_163745` |
| `--project` | ✅ | 项目名称 | `repoeval_readwriteFile` |
| `--lang` | ❌ | 编程语言（默认 python） | `python` |
| `--use_project_code_gt` | ❌ | 使用 project_code/FUN 作为参考 | - |
| `--output` | ❌ | 输出文件路径 | `my_result.json` |

## 💡 使用示例

### 示例 1: 基本评估

```bash
python evaluate_history.py --timestamp 20260122_163745 --project repoeval_readwriteFile
```

### 示例 2: 使用完整代码作为参考

```bash
python evaluate_history.py \
    --timestamp 20260122_163745 \
    --project repoeval_readwriteFile \
    --use_project_code_gt
```

### 示例 3: 指定输出文件

```bash
python evaluate_history.py \
    --timestamp 20260122_163745 \
    --project repoeval_readwriteFile \
    --output results/readwriteFile_history.json
```

## 📊 输出示例

### 控制台输出

```
================================================================================
评估修复历史版本
================================================================================
时间戳目录: 20260122_163745
项目名称:   repoeval_readwriteFile
历史目录:   output/20260122_163745/repoeval_readwriteFile/readful_result_history
================================================================================

📂 历史目录: output/20260122_163745/repoeval_readwriteFile/readful_result_history
   找到 5 个历史版本文件
   参考代码来源: generation_context_ground_truth

  📄 评估 ReadFile.st 的 3 个版本...
    Ground truth: dataset/generation_context_ground_truth/readwriteFile/ReadFile.st
    评估版本 0... ✓ CodeBLEU: 0.4523
    评估版本 1... ✓ CodeBLEU: 0.5234
    评估版本 2... ✓ CodeBLEU: 0.5678
    📈 改进: 0.4523 → 0.5678 (+0.1155, +25.53%)

  📄 评估 WriteFile.st 的 2 个版本...
    Ground truth: dataset/generation_context_ground_truth/readwriteFile/WriteFile.st
    评估版本 0... ✓ CodeBLEU: 0.4123
    评估版本 1... ✓ CodeBLEU: 0.4567
    📈 改进: 0.4123 → 0.4567 (+0.0444, +10.77%)

💾 保存结果到: analysis_script/history_evaluation_20260122_164530.json
✓ 保存成功

================================================================================
评估总结
================================================================================
总文件数:     5
成功评估:     5
失败:         0
成功率:       100.00%

改进趋势:
--------------------------------------------------------------------------------
  📈 ReadFile.st                   : 0.4523 → 0.5678 (+0.1155, +25.53%)
  📈 WriteFile.st                  : 0.4123 → 0.4567 (+0.0444, +10.77%)
================================================================================
```

### JSON 输出结构

```json
{
  "project_name": "repoeval_readwriteFile",
  "history_dir": "output/20260122_163745/repoeval_readwriteFile/readful_result_history",
  "total_files": 5,
  "files_by_function": {
    "ReadFile.st": {
      "versions": [
        {
          "filename": "ReadFile_0.st",
          "version": 0,
          "codebleu": 0.4523,
          "ngram_match_score": 0.3456,
          "weighted_ngram_match_score": 0.4234,
          "syntax_match_score": 0.5678,
          "dataflow_match_score": 0.4756,
          "success": true
        },
        {
          "filename": "ReadFile_1.st",
          "version": 1,
          "codebleu": 0.5234,
          ...
        },
        {
          "filename": "ReadFile_2.st",
          "version": 2,
          "codebleu": 0.5678,
          ...
        }
      ],
      "total_versions": 3,
      "first_version_score": 0.4523,
      "last_version_score": 0.5678,
      "improvement": 0.1155,
      "improvement_percent": 25.53
    },
    "WriteFile.st": {
      ...
    }
  },
  "summary": {
    "total_evaluated": 5,
    "total_failed": 0,
    "success_rate": 1.0
  },
  "metadata": {
    "timestamp": "2026-01-22T16:45:30.123456",
    "args": {
      "timestamp": "20260122_163745",
      "project": "repoeval_readwriteFile",
      ...
    }
  }
}
```

## 📈 分析改进趋势

### 改进符号说明

- 📈 **改进**: CodeBLEU 分数提升
- 📉 **下降**: CodeBLEU 分数下降
- ➡️ **不变**: CodeBLEU 分数基本不变

### 改进百分比计算

```python
improvement_percent = (last_score - first_score) / first_score × 100%
```

### 示例分析

```
📈 ReadFile.st: 0.4523 → 0.5678 (+0.1155, +25.53%)
```

**解读**：
- 首次版本（version 0）的 CodeBLEU 是 0.4523
- 最终版本（version 2）的 CodeBLEU 是 0.5678
- 绝对提升：+0.1155
- 相对提升：+25.53%（显著改进！）

## 🔍 目录结构

```
output/20260122_163745/repoeval_readwriteFile/
└── readful_result_history/          # ← 评估这个目录
    ├── ReadFile_0.st                # 第一次修复尝试
    ├── ReadFile_1.st                # 第二次修复尝试
    ├── ReadFile_2.st                # 第三次修复尝试（最终成功）
    ├── WriteFile_0.st               # 第一次修复尝试
    └── WriteFile_1.st               # 第二次修复尝试（最终成功）
```

## 📊 两种评估模式

### 模式 1: 实现逻辑评估（默认）

```bash
python evaluate_history.py --timestamp 20260122_163745 --project repoeval_readwriteFile
```

- **参考代码**: `dataset/generation_context_ground_truth/[项目名]/`
- **用途**: 评估实现逻辑的改进（不含 provide_code）

### 模式 2: 完整代码评估

```bash
python evaluate_history.py --timestamp 20260122_163745 --project repoeval_readwriteFile --use_project_code_gt
```

- **参考代码**: `dataset/project_code/[项目名]/FUN/`
- **用途**: 评估完整代码的改进（包含定义部分）

## 🎯 使用场景

### 场景 1: 分析修复效果

运行修复后，查看每次迭代的改进：

```bash
# 1. 运行修复
python full_process.py --project readwriteFile

# 2. 评估历史
cd analysis_script
python evaluate_history.py --timestamp 20260122_163745 --project repoeval_readwriteFile

# 3. 查看结果
code history_evaluation_*.json
```

### 场景 2: 对比不同修复策略

评估不同修复策略的效果：

```bash
# 评估策略 A 的结果
python evaluate_history.py --timestamp 20260122_163745 --project repoeval_readwriteFile --output strategy_a.json

# 评估策略 B 的结果
python evaluate_history.py --timestamp 20260122_164523 --project repoeval_readwriteFile --output strategy_b.json

# 对比两个结果
python -c "
import json
with open('strategy_a.json') as f: a = json.load(f)
with open('strategy_b.json') as f: b = json.load(f)
print(f'Strategy A improvement: {a[\"files_by_function\"][\"ReadFile.st\"][\"improvement\"]}')
print(f'Strategy B improvement: {b[\"files_by_function\"][\"ReadFile.st\"][\"improvement\"]}')
"
```

### 场景 3: 识别难以修复的文件

查看哪些文件经过多次迭代仍然改进不大：

```bash
python evaluate_history.py --timestamp 20260122_163745 --project repoeval_readwriteFile

# 查看 JSON 结果，找出 improvement < 0.01 的文件
```

## 💡 技巧

### 1. 快速查看改进最大的文件

```bash
python evaluate_history.py --timestamp 20260122_163745 --project repoeval_readwriteFile | grep "📈"
```

### 2. 导出为 CSV（便于 Excel 分析）

```python
# create export_to_csv.py
import json
import csv

with open('history_evaluation_20260122_164530.json') as f:
    data = json.load(f)

with open('history_analysis.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['File', 'Version', 'CodeBLEU', 'N-gram', 'Syntax', 'Dataflow'])
    
    for base_name, file_data in data['files_by_function'].items():
        for version in file_data['versions']:
            if version['success']:
                writer.writerow([
                    base_name,
                    version['version'],
                    version['codebleu'],
                    version['ngram_match_score'],
                    version['syntax_match_score'],
                    version['dataflow_match_score']
                ])
```

### 3. 可视化改进趋势

```python
# create plot_trend.py
import json
import matplotlib.pyplot as plt

with open('history_evaluation_20260122_164530.json') as f:
    data = json.load(f)

for base_name, file_data in data['files_by_function'].items():
    versions = []
    scores = []
    
    for v in file_data['versions']:
        if v['success']:
            versions.append(v['version'])
            scores.append(v['codebleu'])
    
    plt.plot(versions, scores, marker='o', label=base_name)

plt.xlabel('Version')
plt.ylabel('CodeBLEU')
plt.title('Code Quality Improvement During Fixing')
plt.legend()
plt.grid(True)
plt.savefig('improvement_trend.png')
```

## ⚠️ 注意事项

1. **版本号提取**: 文件名必须是 `basename_version.st` 格式（如 `ReadFile_0.st`）
2. **Ground Truth**: 确保对应的 ground truth 文件存在
3. **成功率**: 如果成功率很低，检查 ground truth 路径是否正确

## 🔗 相关工具

- `evaluate_output.py`: 评估最终修复结果
- `compare_evaluations.py`: 比较两次评估结果
- `full_process.py`: 生成和修复流程

## 📞 故障排查

### 问题 1: 找不到历史目录

```
❌ 历史目录不存在: output/20260122_163745/repoeval_readwriteFile/readful_result_history
```

**解决**: 检查时间戳和项目名是否正确

### 问题 2: 找不到 ground truth

```
⚠️  未找到 ground truth: ReadFile.st
```

**解决**: 
- 检查 `dataset/generation_context_ground_truth/` 或 `dataset/project_code/` 目录
- 确认项目名称是否正确

### 问题 3: 没有历史文件

```
⚠️  历史目录中没有 ST 文件
```

**原因**: 修复过程可能是一次成功，没有生成历史版本

## 📝 总结

使用此工具可以：
- ✅ 深入了解修复过程
- ✅ 识别关键改进点
- ✅ 评估修复策略效果
- ✅ 发现难以修复的代码模式


