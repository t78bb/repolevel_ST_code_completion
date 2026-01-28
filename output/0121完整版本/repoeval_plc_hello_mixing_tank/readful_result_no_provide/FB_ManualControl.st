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
