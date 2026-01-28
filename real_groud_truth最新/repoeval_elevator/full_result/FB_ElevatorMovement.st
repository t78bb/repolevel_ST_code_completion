FUNCTION_BLOCK FB_ElevatorMovement
VAR_INPUT
	CurrentFloor		:	INT;				// 当前楼层
	bDoorReady			:	BOOL;				// 门准备好
END_VAR
VAR_IN_OUT
	TargetFloors		:	ARRAY[0..3] OF BOOL;	// 目标楼层数组
END_VAR
VAR_OUTPUT
	bMovingUp			:	BOOL;				// 向上移动
	bMovingDown			:	BOOL;				// 向下移动
	bArrivedAtTarget	:	BOOL;				// 到达目标楼层
END_VAR

VAR
	nTargetFloor		:	INT;				// 当前目标楼层
	nState				:	INT;				// 状态机
END_VAR

CASE nState OF
	0: // 空闲状态
		bMovingUp := FALSE;
		bMovingDown := FALSE;
		bArrivedAtTarget := FALSE;

		// 检查是否有目标楼层
		FOR i := 0 TO 3 DO
			IF TargetFloors[i] THEN
				nTargetFloor := i;
				nState := 1; // 开始移动流程
				EXIT;
			END_IF
		END_FOR

	1: // 移动到目标楼层
		IF CurrentFloor < nTargetFloor THEN
			bMovingUp := TRUE;
			bMovingDown := FALSE;
		ELSIF CurrentFloor > nTargetFloor THEN
			bMovingUp := FALSE;
			bMovingDown := TRUE;
		ELSE
			bMovingUp := FALSE;
			bMovingDown := FALSE;
			bArrivedAtTarget := TRUE;
			TargetFloors[nTargetFloor] := FALSE; // 清除目标楼层
			nState := 2; // 到达目标楼层
		END_IF

	2: // 等待门准备好
		IF bDoorReady THEN
			nState := 0; // 返回空闲状态
		END_IF
END_CASE
END_FUNCTION_BLOCK