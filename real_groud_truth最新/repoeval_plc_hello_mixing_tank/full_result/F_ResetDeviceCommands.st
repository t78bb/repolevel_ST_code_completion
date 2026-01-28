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

VAR_OUTPUT
	// 复位完成标志
	bResetComplete		:	BOOL;
END_VAR

// 功能描述：复位所有HMI命令标志，当设备状态与命令一致时完成复位
bResetComplete := FALSE;

// 混合电机命令复位逻辑
IF NOT bMixerRunning AND bMixerRunCmd THEN
	bMixerRunCmd := FALSE;
END_IF;

IF bMixerRunning AND bMixerStopCmd THEN
	bMixerStopCmd := FALSE;
END_IF;

// Medium1命令复位逻辑
IF NOT bMedium1Opened AND bMedium1OpenCmd THEN
	bMedium1OpenCmd := FALSE;
END_IF;

IF bMedium1Opened AND bMedium1CloseCmd THEN
	bMedium1CloseCmd := FALSE;
END_IF;

// Medium2命令复位逻辑
IF NOT bMedium2Opened AND bMedium2OpenCmd THEN
	bMedium2OpenCmd := FALSE;
END_IF;

IF bMedium2Opened AND bMedium2CloseCmd THEN
	bMedium2CloseCmd := FALSE;
END_IF;

// Drain命令复位逻辑
IF NOT bDrainOpened AND bDrainOpenCmd THEN
	bDrainOpenCmd := FALSE;
END_IF;

IF bDrainOpened AND bDrainCloseCmd THEN
	bDrainCloseCmd := FALSE;
END_IF;

// 检查是否所有命令标志已复位
IF NOT bMixerRunCmd AND NOT bMixerStopCmd AND
   NOT bMedium1OpenCmd AND NOT bMedium1CloseCmd AND
   NOT bMedium2OpenCmd AND NOT bMedium2CloseCmd AND
   NOT bDrainOpenCmd AND NOT bDrainCloseCmd THEN
	bResetComplete := TRUE;
END_IF;

RETURN bResetComplete;
END_FUNCTION