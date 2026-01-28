VAR
	bDirectionSet	:	BOOL;		//方向是否已设置
END_VAR

bDirectionSet := FALSE;

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
END_IF

RETURN;
END_FUNCTION
