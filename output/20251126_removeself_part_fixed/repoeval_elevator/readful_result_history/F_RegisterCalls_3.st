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

// Ensure all target floors are initialized to FALSE
FOR i := 0 TO 3 DO
  TargetFloors[i] := FALSE;
END_FOR;

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

END_FUNCTION