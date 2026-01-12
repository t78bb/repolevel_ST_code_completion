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

// Verify that __ISVALIDREF is a valid intrinsic function. If not, alternative validity checks should be used.

IF __ISVALIDREF(refLamp) THEN
 refLamp.SetLevel(byNewLevel); // Ensure SetLevel exists in FB_Lamp
 bSuccess := TRUE;
END_IF;

Execute := bSuccess;

END_FUNCTION_BLOCK