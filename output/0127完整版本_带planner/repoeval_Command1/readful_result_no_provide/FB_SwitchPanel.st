VAR
	aiCommand		: ARRAY[1..8] OF I_Command;	
	arrRtrig		: ARRAY[1..8] OF R_TRIG;
	nIndex			: INT;
END_VAR

FOR nIndex := 1 TO 8 DO
	arrRtrig[nIndex](CLK := arrSwitch[nIndex]);
	IF arrRtrig[nIndex].Q THEN
IF aiCommand[nIndex].Valid THEN // Assuming 'Valid' is a method or property to check usability
   aiCommand[nIndex](Execute := TRUE);
END_IF
	END_IF
END_FOR
END_FUNCTION_BLOCK