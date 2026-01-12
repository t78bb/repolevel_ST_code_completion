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
	END_IF;
END_IF;

// 如果门已打开且未关闭传感器触发，则准备关门
IF bDoorOpen AND NOT bDoorClosed THEN
	bCloseDoor := TRUE;
	bDoorClosing := TRUE;
	fbDoorTimer(IN := TRUE, PT := T#5S); // 关门延时5秒
	IF fbDoorTimer.Q THEN
		bDoorOpen := FALSE;
		bDoorClosing := FALSE;
		bCloseDoor := FALSE;
		bDoorReady := TRUE; // 门已关闭且准备好
	END_IF;
END_IF;

// 如果门已关闭传感器触发，则门准备好
IF bDoorClosed THEN
	bDoorReady := TRUE;
END_IF;