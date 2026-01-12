VAR
	nTargetFloor		:	INT;				// 当前目标楼层
	i					:	INT;				// 循环索引
	bTargetFound		:	BOOL;				// 是否找到目标楼层
END_VAR

// 初始化输出信号
bMovingUp := FALSE;
bMovingDown := FALSE;
bArrivedAtTarget := FALSE;

// 检查是否有目标楼层
bTargetFound := FALSE;
FOR i := 0 TO 3 DO
	IF TargetFloors[i] THEN
		nTargetFloor := i;
		bTargetFound := TRUE;
		EXIT;
	END_IF
END_FOR

// 如果没有目标楼层，保持静止
IF NOT bTargetFound THEN
	RETURN;
END_IF

// 检查是否到达目标楼层
IF CurrentFloor = nTargetFloor THEN
	TargetFloors[nTargetFloor] := FALSE; // 清除目标楼层
	bArrivedAtTarget := TRUE;
	RETURN;
END_IF

// 如果门准备好，移动电梯
IF bDoorReady THEN
	IF CurrentFloor < nTargetFloor THEN
		bMovingUp := TRUE;
	ELSIF CurrentFloor > nTargetFloor THEN
		bMovingDown := TRUE;
	END_IF
END_IF