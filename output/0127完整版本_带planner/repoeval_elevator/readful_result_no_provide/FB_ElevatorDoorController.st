VAR
	fbDoorTimer			:	TON;		// 开门延时定时器
	fbCloseDoorTimer	:	TON;		// 关门延时定时器
	nState				:	INT;		// 状态机
	bEmergencyStop		:	BOOL;		// 紧急停止信号
END_VAR

CASE nState OF
	0: // 空闲状态
		bOpenDoor := FALSE;
		bCloseDoor := FALSE;
		bDoorOpen := FALSE;
		bDoorReady := TRUE;

		IF bArrivedAtTarget THEN
			nState := 1; // 开始开门流程
		END_IF

	1: // 开门延时
		bCloseDoor := FALSE;
		bDoorReady := FALSE;
		bOpenDoor := TRUE;
		fbDoorTimer(IN := TRUE, PT := T#2S);

		IF fbDoorTimer.Q THEN
			fbDoorTimer(IN := FALSE);
			nState := 2; // 门打开状态
		END_IF

	2: // 门打开状态
		bDoorOpen := TRUE;
		bOpenDoor := FALSE;

		IF NOT bArrivedAtTarget THEN
			nState := 3; // 开始关门流程
		END_IF

	3: // 关门延时
		bOpenDoor := FALSE;
		bDoorOpen := FALSE;
		bCloseDoor := TRUE;
		fbCloseDoorTimer(IN := TRUE, PT := T#2S);

		IF fbCloseDoorTimer.Q THEN
			fbCloseDoorTimer(IN := FALSE);
			nState := 4; // 检查门关闭状态
		END_IF

	4: // 检查门关闭状态
		bCloseDoor := FALSE;

		IF bDoorClosed THEN
			bDoorReady := TRUE;
			nState := 0; // 返回空闲状态
		END_IF

ELSE
	// 异常处理
	bOpenDoor := FALSE;
	bCloseDoor := FALSE;
	bDoorOpen := FALSE;
	bDoorReady := FALSE;
	nState := 0; // 返回空闲状态
END_CASE
END_FUNCTION_BLOCK
