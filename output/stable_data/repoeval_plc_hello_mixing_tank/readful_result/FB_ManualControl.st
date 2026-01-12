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