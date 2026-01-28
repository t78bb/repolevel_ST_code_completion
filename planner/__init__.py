"""
planner 包

用于放置与上下文规划、功能规划相关的辅助模块：
- context_window: 负责在 project_code 中收集函数/函数块的调用上下文窗口
- planner_agent: 负责根据 requirement / provide_code / 上下文构造 prompt 并调用 LLM 生成功能规划

该文件目前仅用于将 planner 目录标记为一个 Python 包，便于使用
`from planner.context_window import ...` 这类导入语句。
"""


