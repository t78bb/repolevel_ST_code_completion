FUNCTION_BLOCK PUBLIC FB_LampSetLevelCommand IMPLEMENTS I_Command

VAR
    refLamp : REFERENCE TO FB_Lamp;
    byNewLevel : BYTE;
END_VAR

METHOD Execute : BOOL
VAR
    bSuccess : BOOL;
END_VAR

bSuccess := FALSE;

IF (__ISVALIDREF(refLamp)) THEN
    refLamp.SetLevel(byNewLevel);
    bSuccess := TRUE;
END_IF;

Execute := bSuccess;

END_FUNCTION_BLOCK
