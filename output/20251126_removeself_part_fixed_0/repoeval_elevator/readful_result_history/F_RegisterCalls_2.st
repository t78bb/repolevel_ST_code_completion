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
// The FOR loop is removed entirely as it serves no purpose in this context.

END_FUNCTION