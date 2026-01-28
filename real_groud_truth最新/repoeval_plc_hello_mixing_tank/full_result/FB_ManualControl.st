FUNCTION_BLOCK FB_ManualControl
VAR_INPUT
	// HMI命令输入
	bMixerRunCmd		:	BOOL;
	bMixerStopCmd		:	BOOL;
	bMedium1OpenCmd		:	BOOL;
	bMedium1CloseCmd	:	BOOL;
	bMedium2OpenCmd		:	BOOL;
	bMedium2CloseCmd	:	BOOL;
	bDrainOpenCmd		:	BOOL;
	bDrainCloseCmd		:	BOOL;
	
	// 设备反馈输入
	bMixerRunning		:	BOOL;
	bMedium1Opened		:	BOOL;
	bMedium2Opened		:	BOOL;
	bDrainOpened		:	BOOL;
END_VAR
VAR_OUTPUT
	// 设备控制输出
	bMixerRunCmdOut		:	BOOL;
	bMedium1OpenCmdOut	:	BOOL;
	bMedium2OpenCmdOut	:	BOOL;
	bDrainOpenCmdOut	:	BOOL;
END_VAR

VAR
	// 内部变量
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

// 输出命令逻辑
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
END_FUNCTION_BLOCK