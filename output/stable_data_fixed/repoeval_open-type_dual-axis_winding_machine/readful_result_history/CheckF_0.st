FUNCTION_BLOCK CheckF
VAR_INPUT
	lM	:	LREAL;
	lL	:	LREAL;
	lH	:	LREAL;
END_VAR
VAR_OUTPUT
	lF	:	LREAL;
END_VAR

VAR
	lRange : LREAL;
END_VAR

lRange := lH - lL;

IF lRange <> 0 THEN
	lF := (lM - lL) / lRange;
ELSE
	lF := 0;
END_IF;

END_FUNCTION_BLOCK
