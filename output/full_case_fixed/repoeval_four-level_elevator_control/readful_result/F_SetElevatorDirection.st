FUNCTION F_SetElevatorDirection
VAR_INPUT
	nCurrentFloor	:	USINT;		//当前楼层
	nTargetFloor	:	USINT;		//目标楼层
END_VAR
VAR
	bDirectionSet   :   BOOL;       //标志是否已设置方向
END_VAR

bDirectionSet := FALSE;

// 根据当前楼层和目标楼层设定电梯运行方向
IF nTargetFloor > nCurrentFloor THEN
	// 目标楼层高于当前楼层，电梯上升
	Tar_Dir.IsPositive := TRUE;
	Tar_Dir.IsNegative := FALSE;
	bDirectionSet := TRUE;
ELSIF nTargetFloor < nCurrentFloor THEN
	// 目标楼层低于当前楼层，电梯下降
	Tar_Dir.IsPositive := FALSE;
	Tar_Dir.IsNegative := TRUE;
	bDirectionSet := TRUE;
END_IF;

// 如果目标楼层等于当前楼层，不改变方向
IF NOT bDirectionSet THEN
	Tar_Dir.IsPositive := FALSE;
	Tar_Dir.IsNegative := FALSE;
END_IF;

RETURN;
END_FUNCTION
