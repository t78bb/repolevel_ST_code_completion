FUNCTION F_DetectCurrentFloor : INT
VAR_INPUT
	FloorSensor0	:	BOOL;		// 0楼传感器
	FloorSensor1	:	BOOL;		// 1楼传感器
	FloorSensor2	:	BOOL;		// 2楼传感器
	FloorSensor3	:	BOOL;		// 3楼传感器
	CurrentFloor	:	INT;		// 当前楼层（用于保持状态）
END_VAR

VAR
	DetectedFloor	:	INT := -1;	// 检测到的楼层，初始值为-1表示未检测到
END_VAR

// 检测当前楼层
IF FloorSensor0 THEN
	DetectedFloor := 0;
ELSIF FloorSensor1 THEN
	DetectedFloor := 1;
ELSIF FloorSensor2 THEN
	DetectedFloor := 2;
ELSIF FloorSensor3 THEN
	DetectedFloor := 3;
END_IF

// 返回检测到的楼层，如果未检测到则返回当前楼层
IF DetectedFloor <> -1 THEN
	RETURN DetectedFloor;
ELSE
	RETURN CurrentFloor;
END_IF
```

This function `F_DetectCurrentFloor` checks which floor sensor is active and returns the corresponding floor number. If no sensor is active, it returns the current floor as a fallback.