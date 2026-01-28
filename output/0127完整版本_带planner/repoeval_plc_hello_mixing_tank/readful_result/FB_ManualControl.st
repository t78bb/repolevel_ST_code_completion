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
bMixerRunCmdOut := (bMixerRunCmd OR bMixerRunning) AND NOT bMixerStopCmd;

bMedium1OpenCmdOut := (bMedium1OpenCmd OR bMedium1Opened) AND NOT bMedium1CloseCmd;

bMedium2OpenCmdOut := (bMedium2OpenCmd OR bMedium2Opened) AND NOT bMedium2CloseCmd;

bDrainOpenCmdOut := (bDrainOpenCmd OR bDrainOpened) AND NOT bDrainCloseCmd;
END_FUNCTION_BLOCK
