VAR
END_VAR

IF lM < lL THEN
    lF := lL;
ELSIF lM > lH THEN
    lF := lH;
ELSE
    lF := lM;
END_IF;