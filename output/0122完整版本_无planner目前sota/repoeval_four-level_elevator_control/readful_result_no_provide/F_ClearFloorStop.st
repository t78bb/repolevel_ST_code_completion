VAR
	MaxNumFloor : USINT := 4; // Maximum number of floors
END_VAR

// Clear upward stop indicator
IF bClearUpStop AND (nFloor >= 1 AND nFloor <= MaxNumFloor - 1) THEN
  Tar_Dir.IsUpStop[nFloor] := FALSE;
  QFloorUpLed[nFloor] := FALSE;
END_IF

// Clear downward stop indicator
IF bClearDownStop AND (nFloor >= 2 AND nFloor <= MaxNumFloor) THEN
  Tar_Dir.IsDownStop[nFloor] := FALSE;
  QFloorDownLed[nFloor] := FALSE;
END_IF

// Clear floor stop indicator
IF bClearStopFloor AND (nFloor >= 1 AND nFloor <= MaxNumFloor) THEN
  Tar_Dir.IsStopFloor[nFloor] := FALSE;
  QGoFloorLed[nFloor] := FALSE;
END_IF

RETURN;
END_FUNCTION