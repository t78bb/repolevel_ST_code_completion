// 清除楼层停靠标志
// 清除楼层停靠标志
// Simplified logic by removing redundant check (nFloor >= 0) as nFloor is of type USINT
IF bClearUpStop THEN
 Tar_Dir.IsUpStop[nFloor] := FALSE;
 QFloorUpLed[nFloor] := FALSE;
END_IF;

IF bClearDownStop AND (nFloor >= 2) THEN
 Tar_Dir.IsDownStop[nFloor] := FALSE;
 QFloorDownLed[nFloor] := FALSE;
END_IF;

IF bClearStopFloor THEN
 Tar_Dir.IsStopFloor[nFloor] := FALSE;
 QGoFloorLed[nFloor] := FALSE;
END_IF;

	RETURN;
END_FUNCTION