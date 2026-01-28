FUNCTION_BLOCK PUBLIC FB_SwitchPanel
VAR_INPUT
	arrSwitch		: ARRAY[1..8] OF BOOL;
END_VAR
VAR
	aiCommand		: ARRAY[1..8] OF I_Command;	
	arrRtrig		: ARRAY[1..8] OF R_TRIG;
	nIndex			: INT;
END_VAR

FOR nIndex := 1 TO 8 DO
arrRtrig[nIndex](CLK := arrSwitch[nIndex]); // Trigger rising edge detection
IF arrRtrig[nIndex].Q THEN
 IF aiCommand[nIndex].Execute <> 0 THEN // Ensure the function block instance is valid
 aiCommand[nIndex](Execute := TRUE); // Invoke the Execute input of the function block
 END_IF
END_IF
END_FOR
END_FUNCTION_BLOCK