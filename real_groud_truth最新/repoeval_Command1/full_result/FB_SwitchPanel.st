FUNCTION_BLOCK PUBLIC FB_SwitchPanel
VAR_INPUT
	arrSwitch		: ARRAY[1..8] OF BOOL;
END_VAR

VAR
	aiCommand		: ARRAY[1..8] OF I_Command;
	arrRtrig		: ARRAY[1..8] OF R_TRIG;
	nIndex			: INT;
END_VAR

METHOD PUBLIC FB_init : BOOL
VAR_INPUT
	bInitRetains	: BOOL; // if TRUE, the retain variables are initialized (warm start / cold start)
	bInCopyCode		: BOOL; // if TRUE, the instance afterwards gets moved into the copy code (online change)
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

METHOD PUBLIC ExecuteCommands : BOOL
VAR
	nIndex			: INT;
END_VAR

FOR nIndex := 1 TO 8 DO
	IF arrSwitch[nIndex] THEN
		IF aiCommand[nIndex] <> 0 THEN
			aiCommand[nIndex](); // Execute the command
		END_IF
	END_IF
END_FOR

RETURN TRUE;

METHOD PUBLIC ResetCommands : BOOL
VAR
	nIndex			: INT;
END_VAR

FOR nIndex := 1 TO 8 DO
	aiCommand[nIndex] := 0;
END_FOR

RETURN TRUE;
END_FUNCTION_BLOCK