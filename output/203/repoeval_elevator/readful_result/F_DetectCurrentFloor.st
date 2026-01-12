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