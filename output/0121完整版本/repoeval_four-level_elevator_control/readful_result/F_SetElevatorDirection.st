FUNCTION F_SetElevatorDirection
VAR_INPUT
  nCurrentFloor	:	USINT;		//当前楼层
  nTargetFloor	:	USINT;		//目标楼层
END_VAR
VAR
  bDirectionSet	:	BOOL;		//方向是否已设置
END_VAR

bDirectionSet := FALSE;

IF nTargetFloor > nCurrentFloor THEN
  // 目标楼层高于当前楼层，电梯上升
  bDirectionSet := TRUE;
ELSIF nTargetFloor < nCurrentFloor THEN
  // 目标楼层低于当前楼层，电梯下降
  bDirectionSet := TRUE;
END_IF

RETURN;
END_FUNCTION