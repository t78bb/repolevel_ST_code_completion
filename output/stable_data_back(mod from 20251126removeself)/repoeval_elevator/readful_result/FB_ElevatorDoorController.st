VAR
	fbDoorTimer			:	TON;		// 门操作定时器
	bDoorOpening		:	BOOL;		// 门正在打开
	bDoorClosing		:	BOOL;		// 门正在关闭
END_VAR

// 门控制逻辑
IF bArrivedAtTarget THEN
	// 如果到达目标楼层且门未打开，则发出开门命令
	IF NOT bDoorOpen THEN
		bOpenDoor := TRUE;
		bCloseDoor := FALSE;
		bDoorOpening := TRUE;
		fbDoorTimer(IN:=TRUE, PT:=T#5S); // 开门延时5秒
		IF fbDoorTimer.Q THEN
			bDoorOpen := TRUE;
			bDoorOpening := FALSE;
			bDoorReady := FALSE;
		END_IF
	END_IF
ELSE
	// 如果未到达目标楼层且门已打开，则发出关门命令
	IF bDoorOpen THEN
		bCloseDoor := TRUE;
		bOpenDoor := FALSE;
		bDoorClosing := TRUE;
		fbDoorTimer(IN:=TRUE, PT:=T#5S); // 关门延时5秒
		IF fbDoorTimer.Q THEN
			bDoorOpen := FALSE;
			bDoorClosing := FALSE;
			bDoorReady := TRUE;
		END_IF
	END_IF
END_IF

// 如果门已关闭传感器触发，更新门状态
IF bDoorClosed THEN
	bDoorOpen := FALSE;
	bDoorReady := TRUE;
	bCloseDoor := FALSE;
	bDoorClosing := FALSE;
END_IF