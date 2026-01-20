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
	fbMoveDelayTimer	:	TON;				// 移动延时定时器
	i					:	INT;				// 循环变量
	bHasUpperRequest	:	BOOL;				// 有更高楼层请求
	bHasLowerRequest	:	BOOL;				// 有更低楼层请求
END_VAR

// 检查是否到达目标楼层
IF (CurrentFloor >= 0) AND (CurrentFloor <= 3) THEN // 添加边界检查以避免数组越界
  IF TargetFloors[CurrentFloor] THEN
    bArrivedAtTarget := TRUE;
    TargetFloors[CurrentFloor] := FALSE; // 清除请求
    bMovingUp := FALSE;
    bMovingDown := FALSE;
  ELSE
    bArrivedAtTarget := FALSE;
  END_IF
END_IF

// 检查是否有更高或更低楼层的请求
bHasUpperRequest := FALSE;
bHasLowerRequest := FALSE;

FOR i := 0 TO 3 DO
IF (i >= 0) AND (i <= 3) THEN // 确保循环变量 i 不会导致数组越界
    IF TargetFloors[i] THEN
      IF i > CurrentFloor THEN
        bHasUpperRequest := TRUE;
      ELSIF i < CurrentFloor THEN
        bHasLowerRequest := TRUE;
      END_IF
    END_IF
  END_IF
END_FOR

// 控制电梯移动方向
IF bDoorReady THEN
	IF bHasUpperRequest AND NOT bHasLowerRequest THEN
		bMovingUp := TRUE;
		bMovingDown := FALSE;
	ELSIF bHasLowerRequest AND NOT bHasUpperRequest THEN
		bMovingUp := FALSE;
		bMovingDown := TRUE;
	ELSIF bHasUpperRequest AND bHasLowerRequest THEN
		IF bMovingUp THEN
			// 如果当前向上移动，继续向上移动
			bMovingUp := TRUE;
			bMovingDown := FALSE;
		ELSIF bMovingDown THEN
			// 如果当前向下移动，继续向下移动
			bMovingUp := FALSE;
			bMovingDown := TRUE;
		END_IF
	ELSE
		// 没有请求时停止移动
		bMovingUp := FALSE;
		bMovingDown := FALSE;
	END_IF
END_IF
END_FUNCTION_BLOCK