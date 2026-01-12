VAR
	i				:	INT;		// 循环变量
END_VAR

// 根据呼叫按钮设置目标楼层
IF CallGround THEN
	TargetFloors[0] := TRUE;
END_IF;

IF CallFloor1 THEN
	TargetFloors[1] := TRUE;
END_IF;

IF CallFloor2 THEN
	TargetFloors[2] := TRUE;
END_IF;

IF CallFloor3 THEN
	TargetFloors[3] := TRUE;
END_IF;

// 确保目标楼层数组的有效性
FOR i := 0 TO 3 DO
	IF TargetFloors[i] THEN
		EXIT; // 如果有目标楼层，退出循环
	END_IF;
END_FOR;