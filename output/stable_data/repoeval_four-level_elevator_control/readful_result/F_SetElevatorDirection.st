VAR
	bDirectionUp	:	BOOL;		//电梯方向，TRUE=向上，FALSE=向下
END_VAR

// 判断目标楼层与当前楼层的关系，设置电梯方向
IF nTargetFloor > nCurrentFloor THEN
	bDirectionUp := TRUE;	// 目标楼层在当前楼层之上，向上
ELSIF nTargetFloor < nCurrentFloor THEN
	bDirectionUp := FALSE;	// 目标楼层在当前楼层之下，向下
ELSE
	// 当前楼层等于目标楼层，不需要移动
	RETURN;
END_IF;

// 根据方向设置电梯的运行状态
IF bDirectionUp THEN
	Tar_Dir.Direction := 1;	// 设置电梯向上运行
ELSE
	Tar_Dir.Direction := -1;	// 设置电梯向下运行
END_IF;

RETURN;