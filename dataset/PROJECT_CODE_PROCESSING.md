# Project Code 处理说明

## 📋 功能说明

`process_project_code_fun.py` 脚本用于从 `project_code` 目录下提取 FUN 子目录中的 ST 文件，并移除头部的声明部分，只保留实现代码。

## 🔧 处理规则

### 规则 1: 有 VAR 定义的文件

如果文件中有 `VAR` 定义（不是 `VAR_INPUT`/`VAR_OUTPUT`），删除从文件开头到第一个 `VAR` 之前的所有内容。

**示例：FB_DualAxisPower.st**

原文件：
```st
FUNCTION_BLOCK FB_DualAxisPower
VAR_INPUT
    Axis1    :    AXIS_REF;
    bPowerOn :    BOOL;
END_VAR
VAR_OUTPUT
    bPowerDone  :  BOOL;
    bError      :  BOOL;
END_VAR
VAR
    fbPower1  :  MC_Power;    ← 从这里开始保留
    fbPower2  :  MC_Power;
END_VAR

// 执行轴1电源控制
fbPower1(
    Axis := Axis1,
    ...
);
```

处理后：
```st
VAR
    fbPower1  :  MC_Power;
    fbPower2  :  MC_Power;
END_VAR

// 执行轴1电源控制
fbPower1(
    Axis := Axis1,
    ...
);
```

### 规则 2: 没有 VAR 定义的文件

如果文件中没有 `VAR` 定义，找到最后一个 `END_VAR`，从其下一行开始保留。

**示例：F_AxisStatusToString.st**

原文件：
```st
FUNCTION F_AxisStatusToString : STRING
VAR_INPUT
    fbReadStatus  :  MC_ReadStatus;
END_VAR                           ← 最后一个 END_VAR

// 根据轴状态返回对应的字符串描述  ← 从这里开始保留
IF fbReadStatus.Errorstop THEN
    F_AxisStatusToString := 'Errorstop';
    RETURN;
END_IF
...
```

处理后：
```st
// 根据轴状态返回对应的字符串描述
IF fbReadStatus.Errorstop THEN
    F_AxisStatusToString := 'Errorstop';
    RETURN;
END_IF
...
```

## 📁 目录结构变化

### 原目录结构
```
dataset/project_code/
├── electronic_cam_motion/
│   ├── FUN/
│   │   ├── FB_DualAxisPower.st
│   │   └── F_AxisStatusToString.st
│   ├── PRG/
│   └── global/
├── readwriteFile/
│   ├── FUN/
│   │   ├── ReadFile.st
│   │   └── WriteFile.st
│   └── PRG/
└── ...
```

### 新目录结构
```
dataset/project_code_processed/
├── electronic_cam_motion/
│   ├── FB_DualAxisPower.st         ← 直接在项目目录下，已处理
│   └── F_AxisStatusToString.st     ← 直接在项目目录下，已处理
├── readwriteFile/
│   ├── ReadFile.st                 ← 直接在项目目录下，已处理
│   └── WriteFile.st                ← 直接在项目目录下，已处理
└── ...
```

## 🚀 使用方法

### 基本用法

```bash
# 使用默认路径
python process_project_code_fun.py

# 输入: dataset/project_code
# 输出: dataset/project_code_processed
```

### 指定输入输出路径

```bash
python process_project_code_fun.py \
    --input dataset/project_code \
    --output dataset/project_code_processed
```

## 📊 输出示例

```
================================================================================
处理 project_code 目录
================================================================================
源目录: d:\...\repo_gen_project\dataset\project_code
目标目录: d:\...\repo_gen_project\dataset\project_code_processed

找到 30 个项目

  📁 electronic_cam_motion
     找到 4 个 ST 文件
     ✅ FB_DualAxisPower.st: 删除前 12 行
     ✅ F_AxisStatusToString.st: 删除前 4 行
     ✅ FB_ElectronicCamControl.st: 删除前 15 行
     ✅ FB_CamTableManager.st: 删除前 18 行

  📁 readwriteFile
     找到 2 个 ST 文件
     ✅ ReadFile.st: 删除前 6 行
     ✅ WriteFile.st: 删除前 6 行

  ...

================================================================================
处理完成
================================================================================
总项目数: 30
总文件数: 150
处理文件数: 150
总删除行数: 1250
平均每文件删除: 8.3 行

✅ 处理完成！
结果保存在: dataset/project_code_processed
```

## ⚠️ 注意事项

1. **不修改原文件**: 脚本不会对 `project_code` 中的原始文件进行任何修改
2. **输出目录检查**: 如果输出目录已存在，会提示是否删除并重新创建
3. **只处理 FUN 目录**: 只处理 FUN 子目录中的 .st 文件，其他目录（PRG、global 等）不处理
4. **保留实现代码**: 删除的是函数/功能块的声明和输入输出变量定义，保留的是内部变量定义和实现逻辑

## 🎯 使用场景

- 提取函数/功能块的实现部分用于代码生成训练
- 创建只包含逻辑代码的数据集
- 移除冗余的声明部分，简化代码结构

## 📝 处理的变量类型

### 会被删除的部分（如果在 VAR 之前）:
- `FUNCTION` 声明
- `FUNCTION_BLOCK` 声明
- `VAR_INPUT` 块
- `VAR_OUTPUT` 块
- `VAR_IN_OUT` 块

### 会被保留的部分:
- `VAR` 块（内部变量）
- 所有实现代码
- 注释
- 结束标记（如果有）



