FUNCTION F_SetElevatorDirection
VAR_INPUT
 nCurrentFloor	:	USINT;		//当前楼层
 nTargetFloor	:	USINT;		//目标楼层
END_VAR
VAR
 elevatorDirection : STRING[10]; // 电梯运动方向 with specified length
END_VAR

IF nTargetFloor > nCurrentFloor THEN
 // 目标楼层高于当前楼层，电梯上升
 elevatorDirection := 'UP';
ELSIF nTargetFloor < nCurrentFloor THEN
 // 目标楼层低于当前楼层，电梯下降
 elevatorDirection := 'DOWN';
ELSE
 // 目标楼层等于当前楼层，电梯保持静止
 elevatorDirection := 'STOP';
END_IF;

// Assign the return value to the function's name
F_SetElevatorDirection := elevatorDirection;

RETURN; // Correct return statement without a variable or value
END_FUNCTION