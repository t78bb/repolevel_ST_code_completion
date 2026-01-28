FUNCTION F_RegisterCalls
VAR_INPUT
	CallGround		:	BOOL;		// 0楼呼叫
	CallFloor1		:	BOOL;		// 1楼呼叫
	CallFloor2		:	BOOL;		// 2楼呼叫
	CallFloor3		:	BOOL;		// 3楼呼叫
END_VAR
VAR_IN_OUT
	TargetFloors	:	ARRAY[0..3] OF BOOL;	// 目标楼层数组
END_VAR

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