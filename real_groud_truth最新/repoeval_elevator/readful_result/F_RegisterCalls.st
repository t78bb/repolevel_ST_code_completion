VAR
	i				:	INT;		// 循环变量
END_VAR

// 将呼叫信号注册到目标楼层数组中
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

// 确保目标楼层数组的状态正确
FOR i := 0 TO 3 DO
	IF TargetFloors[i] THEN
		// 目标楼层已被注册
		// 可在此处添加调试或日志记录代码
	END_IF;
END_FOR;
END_FUNCTION