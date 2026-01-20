FUNCTION F_ClearFloorStop
VAR_INPUT
 nFloor			:	USINT;		//楼层号
 bClearUpStop	:	BOOL;		//是否清除上升停靠标志
 bClearDownStop	:	BOOL;		//是否清除下降停靠标志
 bClearStopFloor	:	BOOL;		//是否清除楼层停靠标志
END_VAR
// Assuming a known fixed limit for the number of floors, replace MaxNumFloor with an explicit value (e.g., 10).
IF bClearUpStop AND (nFloor <= 9) THEN // Substitute MaxNumFloor - 1 with 9
 IF nFloor >= 1 THEN // Ensure that nFloor is within valid bounds for the IsUpStop array
  Tar_Dir.IsUpStop[nFloor] := FALSE;
  QFloorUpLed[nFloor] := FALSE;
 END_IF;
END_IF;

IF bClearDownStop AND (nFloor >= 2) THEN
 IF nFloor <= 10 THEN // Substitute MaxNumFloor with 10
  Tar_Dir.IsDownStop[nFloor] := FALSE;
  QFloorDownLed[nFloor] := FALSE;
 END_IF;
END_IF;

IF bClearStopFloor THEN
 IF nFloor >= 1 AND nFloor <= 10 THEN // Substitute MaxNumFloor with 10
  Tar_Dir.IsStopFloor[nFloor] := FALSE;
  QGoFloorLed[nFloor] := FALSE;
 END_IF;
END_IF;

RETURN;
END_FUNCTION