VAR
	// 内部状态变量
	bResetCommands		:	BOOL;
END_VAR

// 主程序逻辑
// 复位命令逻辑
bResetCommands := F_ResetDeviceCommands(
	bMixerRunCmd := bMixerRunCmd,
	bMixerStopCmd := bMixerStopCmd,
	bMedium1OpenCmd := bMedium1OpenCmd,
	bMedium1CloseCmd := bMedium1CloseCmd,
	bMedium2OpenCmd := bMedium2OpenCmd,
	bMedium2CloseCmd := bMedium2CloseCmd,
	bDrainOpenCmd := bDrainOpenCmd,
	bDrainCloseCmd := bDrainCloseCmd,
	bMixerRunning := bMixerRunning,
	bMedium1Opened := bMedium1Opened,
	bMedium2Opened := bMedium2Opened,
	bDrainOpened := bDrainOpened
);

// 输出逻辑
IF bMixerRunCmd AND NOT bMixerRunning THEN
	bMixerRunCmdOut := TRUE;	// 启动混合电机
ELSE
	bMixerRunCmdOut := FALSE;
END_IF

IF bMedium1OpenCmd AND NOT bMedium1Opened THEN
	bMedium1OpenCmdOut := TRUE;	// 打开介质1阀门
ELSE
	bMedium1OpenCmdOut := FALSE;
END_IF

IF bMedium2OpenCmd AND NOT bMedium2Opened THEN
	bMedium2OpenCmdOut := TRUE;	// 打开介质2阀门
ELSE
	bMedium2OpenCmdOut := FALSE;
END_IF

IF bDrainOpenCmd AND NOT bDrainOpened THEN
	bDrainOpenCmdOut := TRUE;	// 打开排空阀门
ELSE
	bDrainOpenCmdOut := FALSE;
END_IF