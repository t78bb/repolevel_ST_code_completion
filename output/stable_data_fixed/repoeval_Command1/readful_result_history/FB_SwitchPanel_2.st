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
 aiCommand[nIndex] := I_Command(); // Assign an initial value if `I_Command` is a default-initializable type.
END_FOR
RETURN TRUE;

METHOD PUBLIC SetCommand : BOOL
VAR_INPUT
	nPosition		: INT;
	iCommand		: I_Command;
END_VAR

IF ((nPosition >= 1) AND (nPosition <= 8)) THEN // Remove reliance on the non-existent `IsValid` method.
 aiCommand[nPosition] := iCommand;
 RETURN TRUE;
ELSE
 RETURN FALSE;
END_IF

METHOD PUBLIC On
bActive := TRUE;

METHOD PUBLIC Off
bActive := FALSE;

END_FUNCTION_BLOCK