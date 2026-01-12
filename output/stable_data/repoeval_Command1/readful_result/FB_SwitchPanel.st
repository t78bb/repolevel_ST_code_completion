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
	aiCommand[nIndex] := 0;
END_FOR
RETURN TRUE;

METHOD PUBLIC SetCommand : BOOL
VAR_INPUT
	nPosition		: INT;
	iCommand		: I_Command;
END_VAR

IF ((nPosition >= 1) AND (nPosition <= 8) AND (iCommand <> 0)) THEN
	aiCommand[nPosition] := iCommand;
	RETURN TRUE;
ELSE
	RETURN FALSE;
END_IF

METHOD PUBLIC On
bActive := TRUE;

METHOD PUBLIC Off
bActive := FALSE;