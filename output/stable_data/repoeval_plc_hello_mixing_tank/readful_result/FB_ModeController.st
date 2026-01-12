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