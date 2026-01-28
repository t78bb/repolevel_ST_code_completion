"""
测试 CodeBLEU 评估功能
"""

import sys
from pathlib import Path

# 添加父目录到路径
sys.path.insert(0, str(Path(__file__).parent.parent))

from evaluate import evaluate_and_save


def test_evaluation():
    """测试评估功能"""
    
    # 测试目录（根据实际情况修改）
    test_dir = Path("output/20260120_205101_fixed/repoeval_three-axis_CNC_motion")
    
    if not test_dir.exists():
        print(f"❌ 测试目录不存在: {test_dir}")
        print("\n请修改 test_dir 为实际存在的项目目录")
        return False
    
    print("🧪 开始测试 CodeBLEU 评估功能")
    print("="*80)
    
    # 执行评估
    success = evaluate_and_save(
        test_dir,
        output_filename="codebleu_evaluation_test.json",
        lang="python"
    )
    
    if success:
        print("\n✅ 测试成功！")
        
        # 读取并显示结果摘要
        result_file = test_dir / "codebleu_evaluation_test.json"
        if result_file.exists():
            import json
            with open(result_file, 'r', encoding='utf-8') as f:
                result = json.load(f)
            
            print("\n📊 评估结果摘要:")
            print(f"  项目: {result['project_name']}")
            print(f"  样本数: {result['num_cases']}")
            print(f"  平均 CodeBLEU: {result['average_scores']['codebleu']:.4f}")
    else:
        print("\n❌ 测试失败！")
    
    return success


if __name__ == "__main__":
    success = test_evaluation()
    sys.exit(0 if success else 1)



