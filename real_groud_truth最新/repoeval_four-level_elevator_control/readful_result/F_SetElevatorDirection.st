VAR_OUTPUT
	bDirectionUp	:	BOOL;		//TRUE=向上，FALSE=向下
END_VAR
VAR
	bSameFloor		:	BOOL;		//是否在同一楼层
END_VAR

// 判断当前楼层和目标楼层是否相同
bSameFloor := (nCurrentFloor = nTargetFloor);

// 如果当前楼层和目标楼层相同，则不需要移动电梯
IF bSameFloor THEN
	bDirectionUp := FALSE; // 默认方向为向下（或可根据需求设置为其他值）
	RETURN;
END_IF

// 如果目标楼层高于当前楼层，则设置方向为向上
IF nTargetFloor > nCurrentFloor THEN
	bDirectionUp := TRUE;
ELSE
	// 如果目标楼层低于当前楼层，则设置方向为向下
	bDirectionUp := FALSE;
END_IF