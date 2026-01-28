# 离线模型配置指南（Windows）

## 🎯 目标

1. ✅ 使用国内镜像站下载 HuggingFace 模型
2. ✅ 下载后自动离线使用，无需联网
3. ✅ 提升下载速度和稳定性

## 📋 配置步骤

### 第一步：配置镜像站（永久生效）

#### 方法 1: 使用 PowerShell（推荐）

```powershell
# 1. 以管理员身份打开 PowerShell

# 2. 设置镜像站环境变量（永久）
[Environment]::SetEnvironmentVariable("HF_ENDPOINT", "https://hf-mirror.com", "User")

# 3. 验证设置
[Environment]::GetEnvironmentVariable("HF_ENDPOINT", "User")
# 应该输出: https://hf-mirror.com

# 4. 重启终端使其生效
```

#### 方法 2: 使用图形界面

1. **打开环境变量设置**
   - 右键"此电脑" → "属性"
   - 点击"高级系统设置"
   - 点击"环境变量"按钮

2. **添加用户变量**
   - 在"用户变量"区域点击"新建"
   - 变量名：`HF_ENDPOINT`
   - 变量值：`https://hf-mirror.com`
   - 点击"确定"

3. **重启应用**
   - 关闭所有命令行窗口
   - 重新打开以使设置生效

### 第二步：首次下载模型

#### 选项 A: 通过完整流程下载

```powershell
# 第一次运行会自动从镜像站下载模型
python full_process.py --project readwriteFile
```

#### 选项 B: 单独下载模型（推荐）

```python
# 创建一个测试脚本 download_model.py
import os
os.environ['HF_ENDPOINT'] = 'https://hf-mirror.com'

from sentence_transformers import SentenceTransformer

print("开始下载模型...")
model = SentenceTransformer('BAAI/bge-base-en-v1.5')
print("模型下载完成！")
print(f"模型保存位置: {model._model_card_vars.get('model_path', '~/.cache/huggingface')}")
```

运行：
```powershell
python download_model.py
```

### 第三步：验证离线模式

```powershell
# 1. 断开网络（可选，用于测试）

# 2. 设置离线模式
$env:OFFLINE_MODE="1"

# 3. 运行程序（应该成功，不需要网络）
python full_process.py --project readwriteFile

# 或者，程序会自动检测模型是否已缓存，自动启用离线模式
python full_process.py --project readwriteFile
```

## 📁 模型存储位置

### Windows 默认缓存路径

```
C:\Users\<你的用户名>\.cache\huggingface\hub\
└── models--BAAI--bge-base-en-v1.5\
    ├── snapshots\
    ├── refs\
    └── blobs\
```

### 检查模型是否已下载

```powershell
# PowerShell
dir $env:USERPROFILE\.cache\huggingface\hub\ | Select-String "bge-base-en-v1.5"

# 命令提示符
dir %USERPROFILE%\.cache\huggingface\hub\ | findstr "bge-base-en-v1.5"
```

如果看到 `models--BAAI--bge-base-en-v1.5` 目录，说明模型已下载。

## 🚀 使用方式

### 正常使用（自动模式）

```powershell
# 程序会自动：
# 1. 检查模型是否已缓存
# 2. 如果已缓存，使用离线模式
# 3. 如果未缓存，从镜像站下载
python full_process.py --project readwriteFile
```

### 强制离线模式

```powershell
# 如果你想确保不联网
$env:OFFLINE_MODE="1"
python full_process.py --project readwriteFile
```

### 跳过检索（不使用模型）

```powershell
# 如果不需要检索功能
python full_process.py --project readwriteFile --skip_retrieve
```

## 🔧 智能离线模式说明

代码已修改为**智能离线模式**，工作流程：

```
启动程序
    ↓
检查模型缓存
    ↓
┌─────────────┬─────────────┐
│  已缓存      │   未缓存     │
│  ↓          │   ↓         │
│ 离线模式     │  下载模式    │
│  ↓          │   ↓         │
│ 本地加载     │  镜像下载    │
│  ↓          │   ↓         │
│ 运行成功     │  缓存模型    │
│             │   ↓         │
│             │  运行成功    │
└─────────────┴─────────────┘
```

### 关键特性

1. **自动检测**: 自动检查模型是否已下载
2. **智能切换**: 已下载则离线，未下载则从镜像下载
3. **一次下载**: 首次下载后，以后都是离线使用
4. **无需手动**: 不需要手动设置离线模式

## 📊 下载进度

首次下载时会看到类似输出：

```
使用镜像站: https://hf-mirror.com
从 https://hf-mirror.com 下载模型: BAAI/bge-base-en-v1.5
Downloading: 100%|████████████████| 438M/438M [02:15<00:00, 3.23MB/s]
模型下载完成
```

第二次及以后会看到：

```
使用离线模式加载模型: BAAI/bge-base-en-v1.5
模型加载完成（离线）
```

## ⚙️ 环境变量说明

| 变量名 | 值 | 作用 | 优先级 |
|--------|-------|------|--------|
| `HF_ENDPOINT` | `https://hf-mirror.com` | 设置下载镜像站 | 必需 |
| `OFFLINE_MODE` | `1` | 强制离线模式 | 可选 |
| `TRANSFORMERS_OFFLINE` | `1` | transformers 离线 | 自动设置 |
| `HF_HUB_OFFLINE` | `1` | huggingface_hub 离线 | 自动设置 |

## 🔍 故障排查

### 问题 1: 仍然连接 huggingface.co

**检查环境变量**：
```powershell
$env:HF_ENDPOINT
# 应该输出: https://hf-mirror.com
```

**解决方案**：
```powershell
# 临时设置（当前会话）
$env:HF_ENDPOINT="https://hf-mirror.com"

# 永久设置
[Environment]::SetEnvironmentVariable("HF_ENDPOINT", "https://hf-mirror.com", "User")

# 重启终端
```

### 问题 2: 离线模式下仍然尝试联网

**检查缓存**：
```powershell
dir $env:USERPROFILE\.cache\huggingface\hub\models--BAAI--bge-base-en-v1.5
```

**解决方案**：
- 如果目录不存在，模型未下载，需要先下载
- 如果目录存在但损坏，删除后重新下载

### 问题 3: 下载速度慢

**切换镜像站**：
```powershell
# 尝试其他镜像
$env:HF_ENDPOINT="https://hf-mirror.com"
# 或
$env:HF_ENDPOINT="https://mirror.ghproxy.com/https://huggingface.co"
```

### 问题 4: 模型下载失败

**手动下载**：
1. 访问 https://hf-mirror.com/BAAI/bge-base-en-v1.5
2. 下载所有文件
3. 放到 `C:\Users\<用户名>\.cache\huggingface\hub\models--BAAI--bge-base-en-v1.5\snapshots\<version>\`

## 💡 最佳实践

### 1. 首次使用（联网）

```powershell
# 1. 配置镜像（一次性）
[Environment]::SetEnvironmentVariable("HF_ENDPOINT", "https://hf-mirror.com", "User")

# 2. 重启终端

# 3. 运行程序（会自动下载）
python full_process.py --project readwriteFile
```

### 2. 日常使用（可离线）

```powershell
# 直接运行即可，自动离线
python full_process.py --project readwriteFile
```

### 3. 服务器部署（完全离线）

```powershell
# 1. 在有网络的机器上下载模型
python download_model.py

# 2. 复制整个缓存目录到服务器
# 源: C:\Users\<用户名>\.cache\huggingface\
# 目标: 服务器上相同路径

# 3. 在服务器上设置离线模式
$env:OFFLINE_MODE="1"
python full_process.py --project readwriteFile
```

## 📝 验证清单

完成配置后，验证以下项目：

- [ ] `$env:HF_ENDPOINT` 输出 `https://hf-mirror.com`
- [ ] 首次运行能够从镜像站下载模型
- [ ] 模型缓存目录存在（`~/.cache/huggingface/hub/models--BAAI--bge-base-en-v1.5`）
- [ ] 第二次运行显示"使用离线模式"
- [ ] 断网后仍然可以运行（可选测试）

## 🎓 总结

✅ **配置镜像站**：永久设置 `HF_ENDPOINT` 环境变量
✅ **自动下载**：首次运行自动从镜像站下载
✅ **智能离线**：下载后自动检测并使用离线模式
✅ **无需干预**：一次配置，终身受益

## 🔗 相关链接

- HuggingFace 镜像站: https://hf-mirror.com
- BGE 模型主页: https://hf-mirror.com/BAAI/bge-base-en-v1.5
- Sentence Transformers 文档: https://www.sbert.net

## 📞 需要帮助？

如果遇到问题，请检查：
1. 环境变量是否正确设置
2. 模型缓存目录是否存在
3. 网络是否可以访问镜像站（首次下载时）


