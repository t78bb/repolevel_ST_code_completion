# HuggingFace 离线模型设置脚本（Windows PowerShell）
# 用途：配置镜像站并下载模型

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "HuggingFace 离线模型设置向导" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 第一步：配置镜像站
Write-Host "[步骤 1/3] 配置 HuggingFace 镜像站..." -ForegroundColor Yellow
Write-Host ""

$currentEndpoint = [Environment]::GetEnvironmentVariable("HF_ENDPOINT", "User")

if ($currentEndpoint) {
    Write-Host "✓ 已设置镜像站: $currentEndpoint" -ForegroundColor Green
    $confirm = Read-Host "是否更改镜像站？(y/N)"
    if ($confirm -eq 'y' -or $confirm -eq 'Y') {
        [Environment]::SetEnvironmentVariable("HF_ENDPOINT", "https://hf-mirror.com", "User")
        Write-Host "✓ 已更新镜像站为: https://hf-mirror.com" -ForegroundColor Green
    }
} else {
    [Environment]::SetEnvironmentVariable("HF_ENDPOINT", "https://hf-mirror.com", "User")
    Write-Host "✓ 已设置镜像站为: https://hf-mirror.com" -ForegroundColor Green
}

# 刷新当前会话的环境变量
$env:HF_ENDPOINT = "https://hf-mirror.com"

Write-Host ""

# 第二步：检查模型缓存
Write-Host "[步骤 2/3] 检查模型缓存..." -ForegroundColor Yellow
Write-Host ""

$cacheDir = "$env:USERPROFILE\.cache\huggingface\hub"
$modelDir = Join-Path $cacheDir "models--BAAI--bge-base-en-v1.5"

if (Test-Path $modelDir) {
    Write-Host "✓ 模型已下载" -ForegroundColor Green
    Write-Host "  位置: $modelDir" -ForegroundColor Gray
    $needDownload = $false
} else {
    Write-Host "⚠ 模型未下载" -ForegroundColor Yellow
    Write-Host "  将从镜像站下载（约 400MB）" -ForegroundColor Gray
    $needDownload = $true
}

Write-Host ""

# 第三步：下载模型（如果需要）
if ($needDownload) {
    Write-Host "[步骤 3/3] 下载模型..." -ForegroundColor Yellow
    Write-Host ""
    
    $confirm = Read-Host "是否现在下载模型？(Y/n)"
    if ($confirm -ne 'n' -and $confirm -ne 'N') {
        Write-Host "开始下载模型..." -ForegroundColor Cyan
        Write-Host ""
        
        # 创建临时 Python 脚本
        $tempScript = @"
import os
os.environ['HF_ENDPOINT'] = 'https://hf-mirror.com'

from sentence_transformers import SentenceTransformer
import sys

print("正在下载模型: BAAI/bge-base-en-v1.5")
print("这可能需要几分钟时间，请耐心等待...")
print("")

try:
    model = SentenceTransformer('BAAI/bge-base-en-v1.5')
    print("")
    print("✓ 模型下载完成！")
    print(f"保存位置: {os.path.expanduser('~/.cache/huggingface/hub/')}")
except Exception as e:
    print(f"✗ 下载失败: {e}")
    sys.exit(1)
"@
        
        $tempScript | Out-File -FilePath "temp_download_model.py" -Encoding utf8
        
        # 运行下载脚本
        python temp_download_model.py
        
        # 清理临时文件
        Remove-Item "temp_download_model.py" -ErrorAction SilentlyContinue
        
        Write-Host ""
    } else {
        Write-Host "跳过下载。可以稍后运行程序时自动下载。" -ForegroundColor Gray
    }
} else {
    Write-Host "[步骤 3/3] 验证配置..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "✓ 所有配置已完成" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "配置完成！" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 显示配置摘要
Write-Host "配置摘要:" -ForegroundColor White
Write-Host "  镜像站: https://hf-mirror.com" -ForegroundColor Gray
Write-Host "  模型缓存: $cacheDir" -ForegroundColor Gray

if (Test-Path $modelDir) {
    Write-Host "  模型状态: ✓ 已下载" -ForegroundColor Green
} else {
    Write-Host "  模型状态: ⚠ 未下载（首次运行时自动下载）" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "现在可以运行程序了：" -ForegroundColor White
Write-Host "  python full_process.py --project readwriteFile" -ForegroundColor Cyan
Write-Host ""
Write-Host "注意：如果是首次配置，请重启终端使环境变量生效。" -ForegroundColor Yellow
Write-Host ""

# 询问是否测试
$test = Read-Host "是否测试配置？(y/N)"
if ($test -eq 'y' -or $test -eq 'Y') {
    Write-Host ""
    Write-Host "测试配置..." -ForegroundColor Cyan
    
    Write-Host "  检查环境变量..." -ForegroundColor Gray
    $endpoint = $env:HF_ENDPOINT
    if ($endpoint) {
        Write-Host "  ✓ HF_ENDPOINT = $endpoint" -ForegroundColor Green
    } else {
        Write-Host "  ✗ HF_ENDPOINT 未设置" -ForegroundColor Red
        Write-Host "  请重启终端后再试" -ForegroundColor Yellow
    }
    
    Write-Host "  检查模型缓存..." -ForegroundColor Gray
    if (Test-Path $modelDir) {
        Write-Host "  ✓ 模型已缓存" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ 模型未缓存（首次运行时会下载）" -ForegroundColor Yellow
    }
    
    Write-Host ""
    Write-Host "测试完成！" -ForegroundColor Green
}

Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")


