VAR
	i : INT;	// 循环变量
END_VAR

// 注册呼叫到目标楼层数组
FOR i := 0 TO 3 DO
	CASE i OF
		0: 
			IF CallGround THEN
				TargetFloors[i] := TRUE;
			END_IF;
		1: 
			IF CallFloor1 THEN
				TargetFloors[i] := TRUE;
			END_IF;
		2: 
			IF CallFloor2 THEN
				TargetFloors[i] := TRUE;
			END_IF;
		3: 
			IF CallFloor3 THEN
				TargetFloors[i] := TRUE;
			END_IF;
	END_CASE;
END_FOR;

RETURN;