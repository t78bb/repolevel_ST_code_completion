FUNCTION F_DetectCurrentFloor : INT
VAR_INPUT
	FloorSensor0	:	BOOL;		// 0楼传感器
	FloorSensor1	:	BOOL;		// 1楼传感器
	FloorSensor2	:	BOOL;		// 2楼传感器
	FloorSensor3	:	BOOL;		// 3楼传感器
	CurrentFloor	:	INT;		// 当前楼层（用于保持状态）
END_VAR

VAR
	NewFloor	:	INT := -1;		// 新检测到的楼层
END_VAR

// 检测楼层传感器状态
IF FloorSensor0 THEN
	NewFloor := 0;
ELSIF FloorSensor1 THEN
	NewFloor := 1;
ELSIF FloorSensor2 THEN
	NewFloor := 2;
ELSIF FloorSensor3 THEN
	NewFloor := 3;
END_IF

// 如果检测到新的楼层，则更新当前楼层
IF NewFloor <> -1 THEN
	CurrentFloor := NewFloor;
END_IF

F_DetectCurrentFloor := CurrentFloor; // Assign the value to the function name
RETURN; // Correctly terminate the function

END_FUNCTION