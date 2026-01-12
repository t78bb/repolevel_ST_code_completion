FUNCTION_BLOCK FB_ModeController
VAR_INPUT
	bSetToAuto		:	BOOL;	// 切换到自动模式命令
	bSetToManual	:	BOOL;	// 切换到手动模式命令
END_VAR
VAR_OUTPUT
	eCurrentMode	:	MODES;	// 当前模式
	bModeChanged	:	BOOL;	// 模式改变标志
END_VAR

VAR
	ePreviousMode	:	MODES;	// 之前的模式
END_VAR

// 定义模式枚举类型
TYPE MODES :
(
	MANUAL,		// 手动模式
	AUTO		// 自动模式
);
END_TYPE

// 初始化模式控制逻辑
IF bSetToAuto THEN
	eCurrentMode := AUTO;
ELSIF bSetToManual THEN
	eCurrentMode := MANUAL;
END_IF

// 检查模式是否改变
IF eCurrentMode <> ePreviousMode THEN
	bModeChanged := TRUE;
	ePreviousMode := eCurrentMode;
ELSE
	bModeChanged := FALSE;
END_IF