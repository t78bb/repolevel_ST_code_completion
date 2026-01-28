# 原地修复模式快速参考

## 🎯 核心改动

**一句话总结**：不再创建 `_fixed` 目录，所有操作在一个时间戳目录中完成。

## 📁 目录结构

```
output/[timestamp]/[project_name]/
├── readful_result/                # ✅ 修复后的最终代码
├── readful_result_before_fix/     # 🆕 修复前的备份（自动创建）
├── readful_result_no_provide/     # 🆕 不含 provide_code 的版本
├── readful_result_history/        # 📜 修复过程的历史记录
├── generations_*.json
└── results.jsonl
```

## 🚀 使用方式

### 运行流程（无需改变）

```bash
# 完整流程
python full_process.py --project readwriteFile

# 跳过修复
python full_process.py --project readwriteFile --skip_fix

# 跳过生成
python full_process.py --project readwriteFile --skip_generation
```

### 评估流程（路径更新）

```bash
# ❌ 旧方式（不再适用）
python evaluate_output.py --dir output/20260121_195204_fixed

# ✅ 新方式
python evaluate_output.py --dir output/20260121_195204
```

## 📊 各目录说明

| 目录 | 内容 | 何时创建 | 用途 |
|------|------|----------|------|
| `readful_result` | 修复后的最终代码 | 生成阶段 | 最终结果，用于评估 |
| `readful_result_before_fix` | 修复前的原始代码 | 修复阶段 | 备份，对比差异 |
| `readful_result_no_provide` | 去除定义的代码 | 生成阶段 | 评估实现部分 |
| `readful_result_history` | 修复过程的版本 | 修复阶段 | 调试修复过程 |

## ⚠️ 重要提示

1. **`readful_result_before_fix` 会被覆盖**：每次修复时重新创建
2. **路径变化**：所有评估脚本的路径不再需要 `_fixed` 后缀
3. **空间节省**：不再产生重复的 `_fixed` 目录

## 🔍 文件对比

```bash
# 查看修复前后的差异
diff output/[timestamp]/[project]/readful_result_before_fix/ReadFile.st \
     output/[timestamp]/[project]/readful_result/ReadFile.st
```

## 📝 修改的文件

- ✅ `full_process.py` - 主流程（已修改）
- ✅ `generator/process_generations.py` - 生成阶段（支持 no_provide）
- 📋 `evaluate_output.py` - 评估脚本（路径已适配）
- 📋 `evaluate_single_project.py` - 单项目评估（路径已适配）

## 💡 快速检查

运行后检查目录结构：

```bash
# Windows
dir /s output\20260121_195204\repoeval_readwriteFile\readful*

# Linux/Mac
ls -R output/20260121_195204/repoeval_readwriteFile/readful*
```

应该看到：
- `readful_result/` - 修复后的代码
- `readful_result_before_fix/` - 修复前的备份
- `readful_result_no_provide/` - 不含 provide_code
- `readful_result_history/` - 修复历史


