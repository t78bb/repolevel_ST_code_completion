VAR
	lRange : LREAL;
END_VAR

lRange := lH - lL;

IF lRange <> 0 THEN
	lF := (lM - lL) / lRange;
ELSE
	lF := 0;
END_IF;