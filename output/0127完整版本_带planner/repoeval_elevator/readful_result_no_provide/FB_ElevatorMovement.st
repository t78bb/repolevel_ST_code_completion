VAR
	i					:	INT;				// 循环变量
	bHasUpperRequest	:	BOOL;				// 有更高楼层请求
	bHasLowerRequest	:	BOOL;				// 有更低楼层请求
END_VAR

// 初始化状态变量
bHasUpperRequest := FALSE;
bHasLowerRequest := FALSE;

// 遍历目标楼层数组
FOR i := 0 TO 3 DO
	IF TargetFloors[i] THEN
		IF (i > CurrentFloor) AND bDoorReady THEN
			bHasUpperRequest := TRUE;
		ELSIF (i < CurrentFloor) AND bDoorReady THEN
			bHasLowerRequest := TRUE;
		END_IF;
	END_IF;
END_FOR

// 根据请求状态设置移动方向
IF bHasUpperRequest THEN
	bMovingUp := TRUE;
	bMovingDown := FALSE;
ELSIF bHasLowerRequest THEN
	bMovingDown := TRUE;
	bMovingUp := FALSE;
ELSE
	bMovingUp := FALSE;
	bMovingDown := FALSE;
END_IF

// 检查是否到达目标楼层
IF TargetFloors[CurrentFloor] THEN
	IF bDoorReady THEN
		bArrivedAtTarget := TRUE;
		TargetFloors[CurrentFloor] := FALSE; // 清除请求
		bMovingUp := FALSE;
		bMovingDown := FALSE;
	ELSE
		bArrivedAtTarget := FALSE;
	END_IF;
ELSE
	bArrivedAtTarget := FALSE;
END_IF
END_FUNCTION_BLOCK
