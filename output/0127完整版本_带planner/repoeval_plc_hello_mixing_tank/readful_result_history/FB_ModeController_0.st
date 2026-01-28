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
	eLastMode		:	MODES;	// 上次模式
END_VAR

// 模式切换逻辑
IF bSetToAuto AND (eCurrentMode <> MODES.AUTO) THEN
	eCurrentMode := MODES.AUTO;
	bModeChanged := TRUE;
ELSIF bSetToManual AND (eCurrentMode <> MODES.MANUAL) THEN
	eCurrentMode := MODES.MANUAL;
	bModeChanged := TRUE;
ELSE
	bModeChanged := FALSE;
END_IF

// 更新上次模式
eLastMode := eCurrentMode;
END_FUNCTION_BLOCK
