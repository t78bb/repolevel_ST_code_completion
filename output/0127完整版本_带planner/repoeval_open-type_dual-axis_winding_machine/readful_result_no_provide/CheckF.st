VAR
END_VAR

IF lH <> 0 THEN
    lF := 9.8 * lM / (2 * COS(ATAN(lL / lH)));
ELSE
    lF := 0;
END_IF;
END_FUNCTION_BLOCK
