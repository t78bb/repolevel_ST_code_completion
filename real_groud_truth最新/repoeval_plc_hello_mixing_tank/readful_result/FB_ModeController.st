VAR
	ePreviousMode	:	MODES;	// 上一次模式
END_VAR

// 定义模式类型
TYPE MODES : (MANUAL, AUTO);
END_TYPE

// 初始化
IF NOT eCurrentMode THEN
	eCurrentMode := MANUAL; // 默认模式为手动模式
	ePreviousMode := MANUAL;
	bModeChanged := FALSE;
END_IF

// 模式切换逻辑
IF bSetToAuto AND (eCurrentMode <> AUTO) THEN
	ePreviousMode := eCurrentMode;
	eCurrentMode := AUTO;
	bModeChanged := TRUE;
ELSIF bSetToManual AND (eCurrentMode <> MANUAL) THEN
	ePreviousMode := eCurrentMode;
	eCurrentMode := MANUAL;
	bModeChanged := TRUE;
ELSE
	bModeChanged := FALSE;
END_IF