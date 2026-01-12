FUNCTION_BLOCK FB_轴停止触发块
VAR_IN_OUT
	StopExecute: BOOL; (* Renamed for clarity *)
END_VAR

VAR_INPUT
	Enable: BOOL;
	CurrentPosition: REAL;
	StopPosition: REAL;
	Tolerance: REAL;
END_VAR

VAR_OUTPUT
	StopTriggered: BOOL;
END_VAR

VAR
	PositionDifference: REAL;
END_VAR

IF Enable THEN
	(* Calculate the difference between the current position and the stop position *)
	PositionDifference := ABS(CurrentPosition - StopPosition);

	(* Check if the position difference is within the tolerance range *)
	IF PositionDifference <= Tolerance THEN
		StopTriggered := TRUE;  (* Trigger the stop action *)
		StopExecute := TRUE;    (* Set the stop execution flag *)
	ELSE
		StopTriggered := FALSE; (* No stop action triggered *)
		StopExecute := FALSE;   (* Reset the stop execution flag *)
	END_IF;
ELSE
	(* If not enabled, reset all outputs *)
	StopTriggered := FALSE;
	StopExecute := FALSE;
END_IF;
END_FUNCTION_BLOCK