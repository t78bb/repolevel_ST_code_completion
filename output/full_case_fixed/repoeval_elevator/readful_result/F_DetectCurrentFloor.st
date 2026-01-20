FUNCTION F_DetectCurrentFloor : INT
VAR_INPUT
FloorSensor0	:	BOOL;		// 0楼传感器
FloorSensor1	:	BOOL;		// 1楼传感器
FloorSensor2	:	BOOL;		// 2楼传感器
FloorSensor3	:	BOOL;		// 3楼传感器
CurrentFloor	:	INT;		// 当前楼层（用于保持状态）
END_VAR
IF FloorSensor0 THEN 
F_DetectCurrentFloor := 0;
ELSIF FloorSensor1 THEN 
F_DetectCurrentFloor := 1;
ELSIF FloorSensor2 THEN 
F_DetectCurrentFloor := 2;
ELSIF FloorSensor3 THEN 
F_DetectCurrentFloor := 3;
ELSE
F_DetectCurrentFloor := 0; // Default valid floor value if no sensors are active
END_IF;
RETURN;
END_FUNCTION