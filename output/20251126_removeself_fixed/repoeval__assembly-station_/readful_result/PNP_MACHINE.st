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

pascal
VAR
	InternalState: INT := 0;
END_VAR

METHOD PUBLIC Execute
VAR_INPUT
	CLK: BOOL;
END_VAR

BEGIN
	IF Reset THEN
		InternalState := 0;
		LidPicked := FALSE;
		LidPlaced := FALSE;
		RETURN;
	END_IF

	CASE InternalState OF
		0: // Initial state
			IF BaseClamped AND LidClamped THEN
				InternalState := 1;
			END_IF

		1: // Lid picked state
			LidPicked := TRUE;
			InternalState := 2;

		2: // Lid placed state
			IF NOT LidClamped THEN
				LidPlaced := TRUE;
				InternalState := 3;
			END_IF

		3: // Reset state
			LidPicked := FALSE;
			LidPlaced := FALSE;
			InternalState := 0;

	ELSE
		// Default case to handle unexpected states
		InternalState := 0;
	END_CASE
END_METHOD