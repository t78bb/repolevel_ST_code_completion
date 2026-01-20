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
arrRtrig[nIndex].CLK := arrSwitch[nIndex]; // Proper syntax for assigning the `CLK` input of the R_TRIG function block.
  IF arrRtrig[nIndex].Q THEN
    IF aiCommand[nIndex].Valid THEN // Proper indentation and nested IF statement formatting.
      aiCommand[nIndex].Execute();
    END_IF
  END_IF
END_FOR
END_FUNCTION_BLOCK