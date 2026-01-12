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

// Replace __ISVALIDREF with an alternative validity check if it is not supported in the environment.
// Example: Check refLamp.ISVALID instead of using __ISVALIDREF.

IF __ISVALIDREF(refLamp) THEN
refLamp.SetLevel(byNewLevel); // Ensure SetLevel exists in FB_Lamp
bSuccess := TRUE;
END_IF;

Execute := bSuccess;

END_FUNCTION_BLOCK