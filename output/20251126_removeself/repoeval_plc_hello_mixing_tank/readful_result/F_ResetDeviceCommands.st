VAR_OUTPUT
	// 复位状态输出
	bResetComplete		:	BOOL;
END_VAR

// 功能描述：复位所有HMI命令标志，当设备状态反馈为已完成时
// 复位逻辑：如果设备状态反馈为已完成，则将对应的HMI命令标志复位为FALSE
bResetComplete := TRUE;

// 混合电机命令复位
IF NOT bMixerRunning THEN
	bMixerRunCmd := FALSE;
	bMixerStopCmd := FALSE;
ELSE
	bResetComplete := FALSE;
END_IF;

// Medium1命令复位
IF NOT bMedium1Opened THEN
	bMedium1OpenCmd := FALSE;
	bMedium1CloseCmd := FALSE;
ELSE
	bResetComplete := FALSE;
END_IF;

// Medium2命令复位
IF NOT bMedium2Opened THEN
	bMedium2OpenCmd := FALSE;
	bMedium2CloseCmd := FALSE;
ELSE
	bResetComplete := FALSE;
END_IF;

// Drain命令复位
IF NOT bDrainOpened THEN
	bDrainOpenCmd := FALSE;
	bDrainCloseCmd := FALSE;
ELSE
	bResetComplete := FALSE;
END_IF;

// 返回复位完成状态
F_ResetDeviceCommands := bResetComplete;