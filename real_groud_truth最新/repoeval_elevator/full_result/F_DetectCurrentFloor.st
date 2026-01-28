FUNCTION F_DetectCurrentFloor : INT
VAR_INPUT
	FloorSensor0	:	BOOL;		// 0楼传感器
	FloorSensor1	:	BOOL;		// 1楼传感器
	FloorSensor2	:	BOOL;		// 2楼传感器
	FloorSensor3	:	BOOL;		// 3楼传感器
	CurrentFloor	:	INT;		// 当前楼层（用于保持状态）
END_VAR

VAR_OUTPUT
	DetectedFloor	:	INT;		// 检测到的楼层
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
ELSE
	DetectedFloor := CurrentFloor; // 如果没有传感器触发，保持当前楼层
END_IF

RETURN DetectedFloor;
END_FUNCTION

// --------------------------------------------------
// Continue PLC_PRG logic
// --------------------------------------------------

// 更新当前楼层
CurrentFloor := F_DetectCurrentFloor(
	FloorSensor0 := FloorSensor0,
	FloorSensor1 := FloorSensor1,
	FloorSensor2 := FloorSensor2,
	FloorSensor3 := FloorSensor3,
	CurrentFloor := CurrentFloor
);

// ========== 呼叫处理 ==========
F_RegisterCalls(
	CallGround := CallGround,
	CallFloor1 := CallFloor1,
	CallFloor2 := CallFloor2,
	CallFloor3 := CallFloor3,
	TargetFloors := TargetFloors
);

// ========== 门控制逻辑 ==========
fbDoorController(
	bArrivedAtTarget := TargetFloors[CurrentFloor],
	bDoorClosed := DoorClosed
);
OpenDoor := fbDoorController.OpenDoor;
CloseDoor := fbDoorController.CloseDoor;

// ========== 电梯移动逻辑 ==========
fbMovementController(
	CurrentFloor := CurrentFloor,
	bDoorReady := DoorClosed,
	TargetFloors := TargetFloors
);

// 动画更新
aniDoor0 := fbDoorController.aniDoor0;
aniDoor1 := fbDoorController.aniDoor1;
aniDoor2 := fbDoorController.aniDoor2;
aniDoor3 := fbDoorController.aniDoor3;

// END PROGRAM PLC_PRG
END_FUNCTION