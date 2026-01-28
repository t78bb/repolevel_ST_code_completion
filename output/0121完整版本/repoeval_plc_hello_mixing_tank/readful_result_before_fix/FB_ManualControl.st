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
	bMedium1Latch		:	BOOL;
	bMedium2Latch		:	BOOL;
	bDrainLatch			:	BOOL;
END_VAR

// 混合电机控制
bMixerRunCmdOut := (bMixerRunCmd OR bMixerRunning) AND NOT bMixerStopCmd;

// 介质阀1控制
bMedium1Latch := (bMedium1OpenCmd OR bMedium1Opened) AND NOT bMedium1CloseCmd;
bMedium1OpenCmdOut := bMedium1Latch;

// 介质阀2控制
bMedium2Latch := (bMedium2OpenCmd OR bMedium2Opened) AND NOT bMedium2CloseCmd;
bMedium2OpenCmdOut := bMedium2Latch;

// 排放阀控制
bDrainLatch := (bDrainOpenCmd OR bDrainOpened) AND NOT bDrainCloseCmd;
bDrainOpenCmdOut := bDrainLatch;
END_FUNCTION_BLOCK
