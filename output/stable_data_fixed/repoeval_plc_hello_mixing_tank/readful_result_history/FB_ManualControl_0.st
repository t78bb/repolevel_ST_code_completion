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
	bResetMixerCmd		:	BOOL;
	bResetMedium1Cmd	:	BOOL;
	bResetMedium2Cmd	:	BOOL;
	bResetDrainCmd		:	BOOL;
END_VAR

// 混合电机命令处理
IF bMixerRunning THEN
	bResetMixerCmd := TRUE;
	bMixerRunCmdOut := FALSE; // 已运行，复位运行命令
ELSE
	bResetMixerCmd := FALSE;
	bMixerRunCmdOut := bMixerRunCmd; // 未运行，输出运行命令
END_IF

// 介质1阀门命令处理
IF bMedium1Opened THEN
	bResetMedium1Cmd := TRUE;
	bMedium1OpenCmdOut := FALSE; // 已打开，复位打开命令
ELSE
	bResetMedium1Cmd := FALSE;
	bMedium1OpenCmdOut := bMedium1OpenCmd; // 未打开，输出打开命令
END_IF

// 介质2阀门命令处理
IF bMedium2Opened THEN
	bResetMedium2Cmd := TRUE;
	bMedium2OpenCmdOut := FALSE; // 已打开，复位打开命令
ELSE
	bResetMedium2Cmd := FALSE;
	bMedium2OpenCmdOut := bMedium2OpenCmd; // 未打开，输出打开命令
END_IF

// 排空阀门命令处理
IF bDrainOpened THEN
	bResetDrainCmd := TRUE;
	bDrainOpenCmdOut := FALSE; // 已打开，复位打开命令
ELSE
	bResetDrainCmd := FALSE;
	bDrainOpenCmdOut := bDrainOpenCmd; // 未打开，输出打开命令
END_IF

END_FUNCTION_BLOCK
