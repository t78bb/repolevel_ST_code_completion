FUNCTION F_SetElevatorDirection
VAR_INPUT
	nCurrentFloor	:	USINT;		//当前楼层
	nTargetFloor	:	USINT;		//目标楼层
END_VAR

VAR_OUTPUT
	bDirectionUp	:	BOOL;		//TRUE=向上，FALSE=向下
END_VAR
VAR
	bSameFloor		:	BOOL;		//是否在同一楼层
END_VAR

// 判断当前楼层和目标楼层是否相同
bSameFloor := (nCurrentFloor = nTargetFloor);

// 如果在同一楼层，不需要设置方向
IF bSameFloor THEN
	bDirectionUp := FALSE; // 默认方向为向下
	RETURN;
END_IF

// 如果目标楼层高于当前楼层，设置方向为向上
IF nTargetFloor > nCurrentFloor THEN
	bDirectionUp := TRUE;
ELSE
	// 如果目标楼层低于当前楼层，设置方向为向下
	bDirectionUp := FALSE;
END_IF