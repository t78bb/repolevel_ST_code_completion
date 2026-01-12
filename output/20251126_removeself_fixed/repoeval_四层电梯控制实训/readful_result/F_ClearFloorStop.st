FUNCTION F_ClearFloorStop
VAR_INPUT
	nFloor			:	USINT;		//楼层号
	bClearUpStop	:	BOOL;		//是否清除上升停靠标志
	bClearDownStop	:	BOOL;		//是否清除下降停靠标志
	bClearStopFloor	:	BOOL;		//是否清除楼层停靠标志
END_VAR

structuredtext
# --------------------------------------------------
# Continuation of F_SetElevatorDirection
# --------------------------------------------------
ELSIF nTargetFloor < nCurrentFloor THEN
    // 目标楼层低于当前楼层，电梯下降
    Tar_Dir.IsPositive := FALSE;
    Tar_Dir.IsNegative := TRUE;
ELSE
    // 当前楼层与目标楼层相同，电梯停止
    Tar_Dir.IsPositive := FALSE;
    Tar_Dir.IsNegative := FALSE;
END_IF

# --------------------------------------------------
# Continuation of F_ClearFloorStop
# --------------------------------------------------
IF bClearUpStop THEN
    Tar_Dir.IsUpStop[nFloor] := FALSE; // 清除上升停靠标志
END_IF

IF bClearDownStop THEN
    Tar_Dir.IsDownStop[nFloor] := FALSE; // 清除下降停靠标志
END_IF

IF bClearStopFloor THEN
    Tar_Dir.IsStopFloor[nFloor] := FALSE; // 清除楼层停靠标志
END_IF