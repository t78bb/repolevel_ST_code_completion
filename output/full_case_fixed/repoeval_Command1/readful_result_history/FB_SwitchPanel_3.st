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
  // Assign the `CLK` input of the R_TRIG function block
  arrRtrig[nIndex].CLK := arrSwitch[nIndex];
  IF arrRtrig[nIndex].Q THEN
    IF aiCommand[nIndex].Valid THEN
      aiCommand[nIndex].Execute();
    END_IF
  END_IF
END_FOR
END_FUNCTION_BLOCK