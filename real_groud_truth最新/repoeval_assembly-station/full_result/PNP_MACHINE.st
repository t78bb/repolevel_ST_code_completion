FUNCTION_BLOCK PUBLIC PNP_MACHINE
VAR_INPUT
	BaseClamped: BOOL;
	LidClamped: BOOL;
	Reset: BOOL := FALSE;
END_VAR

VAR_OUTPUT
	LidPicked: BOOL := FALSE;
	LidPlaced: BOOL := FALSE;
END_VAR

VAR
	InternalState: INT := 0;
END_VAR

METHOD ResetMachine
VAR_INPUT
	ResetSignal: BOOL;
END_VAR

VAR_OUTPUT
	ResetComplete: BOOL := FALSE;
END_VAR

IF ResetSignal THEN
	InternalState := 0;
	LidPicked := FALSE;
	LidPlaced := FALSE;
	ResetComplete := TRUE;
ELSE
	ResetComplete := FALSE;
END_IF

METHOD Execute
VAR_INPUT
	BaseDetected: BOOL;
	LidDetected: BOOL;
END_VAR

CASE InternalState OF
	0: // Initial state
		IF BaseDetected THEN
			BaseClamped := TRUE;
			InternalState := 1;
		END_IF
	1: // Base clamped, waiting for lid
		IF LidDetected THEN
			LidClamped := TRUE;
			LidPicked := TRUE;
			InternalState := 2;
		END_IF
	2: // Lid picked, waiting for placement
		IF NOT LidDetected THEN
			LidPlaced := TRUE;
			BaseClamped := FALSE;
			InternalState := 0; // Reset to initial state
		END_IF
END_CASE

END_METHOD
END_FUNCTION_BLOCK