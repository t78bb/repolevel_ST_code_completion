VAR
	NewFloor	:	INT := -1;		// 临时变量，用于存储检测到的楼层
END_VAR

// 检测各楼层传感器状态
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
	F_DetectCurrentFloor := NewFloor;
ELSE
	// 如果没有检测到新的楼层，保持当前楼层
	F_DetectCurrentFloor := CurrentFloor;
END_IF