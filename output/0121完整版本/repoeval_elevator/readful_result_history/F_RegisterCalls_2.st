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
IF CallGround THEN 
  TargetFloors[0] := TRUE; // Assign TRUE to the 0th index if CallGround is triggered
END_IF;

IF CallFloor1 THEN 
  TargetFloors[1] := TRUE; // Assign TRUE to the 1st index if CallFloor1 is triggered
END_IF;

IF CallFloor2 THEN 
  TargetFloors[2] := TRUE; // Assign TRUE to the 2nd index if CallFloor2 is triggered
END_IF;

IF CallFloor3 THEN 
  TargetFloors[3] := TRUE; // Assign TRUE to the 3rd index if CallFloor3 is triggered
END_IF;

RETURN; // Ensure RETURN is correctly placed at the end of the FUNCTION
END_FUNCTION