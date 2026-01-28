VAR
	fbMoveDelayTimer	:	TON;				// 移动延时定时器
	i					:	INT;				// 循环变量
	bHasUpperRequest	:	BOOL;				// 有更高楼层请求
	bHasLowerRequest	:	BOOL;				// 有更低楼层请求
END_VAR

// 检查是否到达目标楼层
IF TargetFloors[CurrentFloor] THEN
	bArrivedAtTarget := TRUE;
	TargetFloors[CurrentFloor] := FALSE; // 清除请求
	bMovingUp := FALSE;
	bMovingDown := FALSE;
	RETURN;
ELSE
	bArrivedAtTarget := FALSE;
END_IF

// 检查是否有更高楼层请求
bHasUpperRequest := FALSE;
FOR i := CurrentFloor + 1 TO INT(UPPER_BOUND(TargetFloors, 1)) DO
  IF TargetFloors[i] THEN
    bHasUpperRequest := TRUE;
    EXIT;
  END_IF
END_FOR

// 检查是否有更低楼层请求
bHasLowerRequest := FALSE;
FOR i := CurrentFloor - 1 TO INT(LOWER_BOUND(TargetFloors, 1)) BY -1 DO
  IF TargetFloors[i] THEN
    bHasLowerRequest := TRUE;
    EXIT;
  END_IF
END_FOR

// 控制电梯移动逻辑
IF bDoorReady THEN
	IF bHasUpperRequest THEN
		bMovingUp := TRUE;
		bMovingDown := FALSE;
	ELSIF bHasLowerRequest THEN
		bMovingUp := FALSE;
		bMovingDown := TRUE;
	ELSE
		bMovingUp := FALSE;
		bMovingDown := FALSE;
	END_IF
END_IF
END_FUNCTION_BLOCK