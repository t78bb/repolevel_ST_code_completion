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

// 门控制逻辑
IF bArrivedAtTarget THEN
	// 如果到达目标楼层，且门未打开，则发送开门命令
	IF NOT bDoorOpen THEN
		bOpenDoor := TRUE;
		bCloseDoor := FALSE;
		bDoorOpening := TRUE;
		bDoorClosing := FALSE;
		fbDoorTimer(IN := TRUE, PT := T#5S); // 开门延时
	END_IF
ELSE
	// 如果未到达目标楼层，且门已打开，则发送关门命令
	IF bDoorOpen THEN
		bOpenDoor := FALSE;
		bCloseDoor := TRUE;
		bDoorOpening := FALSE;
		bDoorClosing := TRUE;
		fbDoorTimer(IN := TRUE, PT := T#5S); // 关门延时
	END_IF
END_IF

// 定时器完成后更新门状态
IF fbDoorTimer.Q THEN
	IF bDoorOpening THEN
		bDoorOpen := TRUE;
		bDoorReady := TRUE; // 门准备好，电梯可以移动
		bDoorOpening := FALSE;
	ELSEIF bDoorClosing THEN
		bDoorOpen := FALSE;
		bDoorReady := FALSE; // 门未准备好，电梯不能移动
		bDoorClosing := FALSE;
	END_IF
	fbDoorTimer(IN := FALSE); // 停止定时器
END_IF
END_FUNCTION_BLOCK