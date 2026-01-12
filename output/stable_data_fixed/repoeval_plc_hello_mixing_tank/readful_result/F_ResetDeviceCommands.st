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
	bAllCommandsReset : BOOL;
END_VAR

// Reset all HMI command flags if the corresponding device state indicates the action is complete
bMixerRunCmd := FALSE;
bMixerStopCmd := FALSE;

IF bMedium1Opened THEN
	bMedium1OpenCmd := FALSE;
	bMedium1CloseCmd := FALSE;
END_IF;

IF bMedium2Opened THEN
	bMedium2OpenCmd := FALSE;
	bMedium2CloseCmd := FALSE;
END_IF;

IF bDrainOpened THEN
	bDrainOpenCmd := FALSE;
	bDrainCloseCmd := FALSE;
END_IF;

// Check if all commands have been reset
bAllCommandsReset := NOT (bMixerRunCmd OR bMixerStopCmd OR bMedium1OpenCmd OR bMedium1CloseCmd OR bMedium2OpenCmd OR bMedium2CloseCmd OR bDrainOpenCmd OR bDrainCloseCmd);

F_ResetDeviceCommands := bAllCommandsReset;
RETURN;

END_FUNCTION
