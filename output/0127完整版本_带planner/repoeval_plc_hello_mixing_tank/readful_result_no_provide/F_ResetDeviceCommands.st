VAR
	bAllCommandsReset : BOOL := TRUE;
END_VAR

// 混合电机命令复位
IF bMixerRunning THEN
	bMixerRunCmd := FALSE;
	bMixerStopCmd := FALSE;
ELSE
	bAllCommandsReset := FALSE;
END_IF

// 介质1阀门命令复位
IF bMedium1Opened THEN
	bMedium1OpenCmd := FALSE;
	bMedium1CloseCmd := FALSE;
ELSE
	bAllCommandsReset := FALSE;
END_IF

// 介质2阀门命令复位
IF bMedium2Opened THEN
	bMedium2OpenCmd := FALSE;
	bMedium2CloseCmd := FALSE;
ELSE
	bAllCommandsReset := FALSE;
END_IF

// 排水阀门命令复位
IF bDrainOpened THEN
	bDrainOpenCmd := FALSE;
	bDrainCloseCmd := FALSE;
ELSE
	bAllCommandsReset := FALSE;
END_IF

// 返回所有命令是否已复位
F_ResetDeviceCommands := bAllCommandsReset;
RETURN;
END_FUNCTION
