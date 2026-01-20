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
	fbDoorTimer			:	TON;		// 开门延时定时器
	fbCloseDoorTimer	:	TON;		// 关门延时定时器
	nState				:	INT;		// 状态机
END_VAR

CASE nState OF
	0: // 空闲状态
		bOpenDoor := FALSE;
		bCloseDoor := FALSE;
		bDoorReady := TRUE;
		
		IF bArrivedAtTarget THEN
			nState := 1; // 开始开门流程
		END_IF
		
	1: // 开门延时
		bCloseDoor := FALSE;
		bDoorReady := FALSE;
		fbDoorTimer(IN := TRUE, PT := T#2S);
		
		IF fbDoorTimer.Q THEN
			fbDoorTimer(IN := FALSE);
			nState := 2; // 开门命令
		END_IF
		
	2: // 开门命令
		bOpenDoor := TRUE;
		bDoorOpen := TRUE;
		bDoorReady := FALSE;
		
		IF NOT bArrivedAtTarget THEN
			nState := 3; // 开始关门流程
		END_IF
		
	3: // 关门延时
		bOpenDoor := FALSE;
		bDoorReady := FALSE;
		fbCloseDoorTimer(IN := TRUE, PT := T#2S);
		
		IF fbCloseDoorTimer.Q THEN
			fbCloseDoorTimer(IN := FALSE);
			nState := 4; // 关门命令
		END_IF
		
	4: // 关门命令
		bCloseDoor := TRUE;
		bDoorOpen := FALSE;
		
		IF bDoorClosed THEN
			bCloseDoor := FALSE;
			bDoorReady := TRUE;
			nState := 0; // 返回空闲状态
		END_IF
		
ELSE
	nState := 0; // 默认返回空闲状态
END_CASE
END_FUNCTION_BLOCK
