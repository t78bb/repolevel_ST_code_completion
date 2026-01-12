VAR
	i					:	INT;				// 循环索引
	TargetFloor			:	INT;				// 当前目标楼层
	bTargetFound		:	BOOL;				// 是否找到目标楼层
END_VAR

// 初始化输出信号
bMovingUp := FALSE;
bMovingDown := FALSE;
bArrivedAtTarget := FALSE;

// 检查是否门已准备好
IF bDoorReady THEN
	// 查找目标楼层
	bTargetFound := FALSE;
	FOR i := 0 TO 3 DO
		IF TargetFloors[i] THEN
			TargetFloor := i;
			bTargetFound := TRUE;
			EXIT;
		END_IF
	END_FOR
	
	// 如果找到目标楼层
	IF bTargetFound THEN
		// 判断当前楼层与目标楼层的关系
		IF TargetFloor > CurrentFloor THEN
			bMovingUp := TRUE;
		ELSIF TargetFloor < CurrentFloor THEN
			bMovingDown := TRUE;
		ELSE
			// 当前楼层即为目标楼层
			bArrivedAtTarget := TRUE;
			TargetFloors[TargetFloor] := FALSE; // 清除目标楼层
		END_IF
	END_IF
END_IF;