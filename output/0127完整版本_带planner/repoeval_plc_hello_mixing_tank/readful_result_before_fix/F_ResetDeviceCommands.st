FUNCTION F_ResetDeviceCommands : BOOL
VAR_IN_OUT
	// HMI命令标志（需要复位）
	bMixerRunCmd		:	BOOL;
	bMixerStopCmd		:	BOOL;
	bMedium1OpenCmd		:	BOOL;
	bMedium1CloseCmd	:	BOOL;
	bMedium2OpenCmd		:	BOOL;
	bMedium2CloseCmd	:	BOOL;
	bDrainOpenCmd		:	BOOL;
	bDrainCloseCmd		:	BOOL;
END_VAR
VAR_INPUT
	// 设备状态反馈
	bMixerRunning		:	BOOL;
	bMedium1Opened		:	BOOL;
	bMedium2Opened		:	BOOL;
	bDrainOpened		:	BOOL;
END_VAR
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
