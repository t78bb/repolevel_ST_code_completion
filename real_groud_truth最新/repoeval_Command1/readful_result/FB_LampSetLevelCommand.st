VAR
    refLamp : REFERENCE TO FB_Lamp;
    byNewLevel : BYTE;
END_VAR

METHOD PUBLIC Execute : BOOL
VAR_OUTPUT
    bSuccess : BOOL;
END_VAR

bSuccess := FALSE;

IF (__ISVALIDREF(refLamp)) THEN
    refLamp.SetLevel(byNewLevel);
    bSuccess := TRUE;
END_IF

RETURN bSuccess;