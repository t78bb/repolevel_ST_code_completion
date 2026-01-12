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
	ePreviousMode	:	MODES := MODES.Manual;	// 上一次模式
END_VAR

IF bSetToAuto AND (ePreviousMode <> MODES.Auto) THEN
	eCurrentMode := MODES.Auto;
	bModeChanged := TRUE;
	ePreviousMode := eCurrentMode;
ELSIF bSetToManual AND (ePreviousMode <> MODES.Manual) THEN
	eCurrentMode := MODES.Manual;
	bModeChanged := TRUE;
	ePreviousMode := eCurrentMode;
ELSE
	bModeChanged := FALSE;
END_IF;

END_FUNCTION_BLOCK
