VAR
END_VAR

IF lM >= lL AND lM <= lH THEN
    lF := lM;
ELSE
    IF lM < lL THEN
        lF := lL;
    ELSE
        lF := lH;
    END_IF
END_IF