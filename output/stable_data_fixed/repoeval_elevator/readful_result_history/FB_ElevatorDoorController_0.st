FUNCTION_BLOCK FB_ElevatorDoorController
VAR_INPUT
	bArrivedAtTarget	:	BOOL;		// 到达目标楼层
	bDoorClosed			:	BOOL;		// 门已关闭传感器
END_VAR
VAR_OUTPUT
	bOpenDoor			:	BOOL;		// 开门命令
	bCloseDoor			:	BOOL;		// 关门命令
	bDoorOpen			:	BOOL;		// 门打开状态
	bDoorReady			:	BOOL;		// 门准备好（可以移动）
END_VAR

VAR
	fbDoorTimer			:	TON;		// 门操作定时器
	bDoorOpening		:	BOOL;		// 门正在打开
	bDoorClosing		:	BOOL;		// 门正在关闭
END_VAR

// 初始化输出
bOpenDoor := FALSE;
bCloseDoor := FALSE;
bDoorOpen := FALSE;
bDoorReady := FALSE;

// 如果到达目标楼层且门未打开，则开始开门
IF bArrivedAtTarget AND NOT bDoorOpen THEN
	bOpenDoor := TRUE;
	bDoorOpening := TRUE;
	fbDoorTimer(IN := TRUE, PT := T#5S); // 开门延时5秒
	IF fbDoorTimer.Q THEN
		bDoorOpen := TRUE;
		bDoorOpening := FALSE;
		bOpenDoor := FALSE;
		fbDoorTimer(IN := FALSE);
	END_IF;
END_IF;

// 如果门已打开且未关闭，则准备好
IF bDoorOpen AND NOT bDoorClosed THEN
	bDoorReady := TRUE;
END_IF;

// 如果门关闭传感器触发，则门关闭
IF bDoorClosed THEN
	bDoorOpen := FALSE;
	bDoorReady := FALSE;
	bCloseDoor := FALSE;
	bDoorClosing := FALSE;
END_IF;

// 如果门准备好且需要关闭，则开始关门
IF bDoorReady AND NOT bDoorClosed THEN
	bCloseDoor := TRUE;
	bDoorClosing := TRUE;
	fbDoorTimer(IN := TRUE, PT := T#5S); // 关门延时5秒
	IF fbDoorTimer.Q THEN
		bDoorClosed := TRUE;
		bDoorClosing := FALSE;
		bCloseDoor := FALSE;
		fbDoorTimer(IN := FALSE);
	END_IF;
END_IF;

END_FUNCTION_BLOCK
