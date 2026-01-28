# CodeBLEU 评估快速参考

## 🎛️ Ground Truth 来源开关

### 默认方式（generation_context_ground_truth）

```bash
python full_process.py --project readwriteFile
```

参考代码：`dataset/generation_context_ground_truth/readwriteFile/*.st`

### 开启 project_code 方式

```bash
python full_process.py --project readwriteFile --use_project_code_gt
```

参考代码：`dataset/project_code/readwriteFile/FUN/*.st`

---

## 📋 完整命令速查

| 场景 | 命令 | GT 来源 |
|------|------|---------|
| 完整流程（默认GT） | `python full_process.py --project XXX` | generation_context_ground_truth |
| 完整流程（project_code GT） | `python full_process.py --project XXX --use_project_code_gt` | project_code/FUN |
| 跳过评估 | `python full_process.py --project XXX --skip_evaluate` | - |
| 只生成不修复 | `python full_process.py --project XXX --skip_fix` | generation_context_ground_truth |

---

## 📂 目录对应关系

| 生成代码 | 参考代码（默认） | 参考代码（开启开关） |
|----------|------------------|---------------------|
| `output/XXX_fixed/repoeval_YYY/readful_result/*.st` | `dataset/generation_context_ground_truth/YYY/*.st` | `dataset/project_code/YYY/FUN/*.st` |

---

## 详细文档

- 📖 [Ground Truth 开关详细说明](evaluate/GROUND_TRUTH_SWITCH.md)
- 📖 [评估模块使用说明](evaluate/README.md)
- 📖 [参考代码来源说明](evaluate/GROUND_TRUTH_REFERENCE.md)



