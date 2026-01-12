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
	prevBaseClamped: BOOL := FALSE;
	prevLidClamped: BOOL := FALSE;
END_VAR

IF Reset THEN
 LidPicked := FALSE;
 LidPlaced := FALSE;
 prevBaseClamped := FALSE;
 prevLidClamped := FALSE;
 RETURN;
END_IF

// Explicitly reset the outputs when conditions are not met
LidPicked := FALSE;
LidPlaced := FALSE;

IF NOT prevLidClamped AND LidClamped THEN
 LidPicked := TRUE;
END_IF

IF prevBaseClamped AND NOT BaseClamped THEN
 LidPlaced := TRUE;
END_IF

// Update the previous clamped states
prevBaseClamped := BaseClamped;
prevLidClamped := LidClamped;

END_FUNCTION_BLOCK