FUNCTION F_ClearFloorStop
VAR_INPUT
  nFloor			:	USINT;		//楼层号
  bClearUpStop	:	BOOL;		//是否清除上升停靠标志
  bClearDownStop	:	BOOL;		//是否清除下降停靠标志
  bClearStopFloor	:	BOOL;		//是否清除楼层停靠标志
END_VAR

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

// Assign the result to the function name variable
F_ClearFloorStop := bResult;

// Return to exit the function
RETURN;

END_FUNCTION