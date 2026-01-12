FUNCTION_BLOCK PUBLIC FB_SwitchPanel
VAR_INPUT
	arrSwitch		: ARRAY[1..8] OF BOOL;
END_VAR

VAR
	aiCommand		: ARRAY[1..8] OF I_Command;
	arrRtrig		: ARRAY[1..8] OF R_TRIG;
	nIndex			: INT;
END_VAR

VAR_OUTPUT
	bActive			: BOOL;
END_VAR

METHOD PUBLIC FB_init : BOOL
VAR_INPUT
	bInitRetains	: BOOL;
	bInCopyCode		: BOOL;
END_VAR
VAR
	nIndex			: INT;
END_VAR

FOR nIndex := 1 TO 8 DO
// Assuming `aiCommand` refers to an array of function blocks,
// use the REFERENCE assignment to allocate or configure the elements as needed.
aiCommand[nIndex](enable := FALSE); // Replace this with the correct initialization logic for `I_Command`.
END_FOR
RETURN TRUE;

METHOD PUBLIC SetCommand : BOOL
VAR_INPUT
	nPosition		: INT;
	iCommand		: I_Command;
END_VAR

IF ((nPosition >= 1) AND (nPosition <= 8)) THEN
// Use the appropriate process to copy or map data from `iCommand` to `aiCommand[nPosition]`.
// Direct assignment might not work if `I_Command` is a complex type.
aiCommand[nPosition].CopyFrom(iCommand); // Replace with the applicable method for structured type management.
RETURN TRUE;
ELSE
RETURN FALSE;
END_IF

METHOD PUBLIC On
bActive := TRUE;

METHOD PUBLIC Off
bActive := FALSE;

END_FUNCTION_BLOCK