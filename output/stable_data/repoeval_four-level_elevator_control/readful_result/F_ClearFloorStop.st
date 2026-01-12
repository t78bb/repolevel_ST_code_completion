VAR
    bResult : BOOL; // Local variable to store the result of the operation
END_VAR

// Clear the upward stop flag if requested
IF bClearUpStop THEN
    Tar_Dir.IsUpStop[nFloor] := FALSE;
END_IF

// Clear the downward stop flag if requested
IF bClearDownStop THEN
    Tar_Dir.IsDownStop[nFloor] := FALSE;
END_IF

// Clear the stop floor flag if requested
IF bClearStopFloor THEN
    Tar_Dir.IsStopFloor[nFloor] := FALSE;
END_IF

// Set the result to TRUE to indicate successful operation
bResult := TRUE;

// Return the result
RETURN bResult;