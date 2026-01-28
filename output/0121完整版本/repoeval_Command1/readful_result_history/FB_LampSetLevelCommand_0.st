FUNCTION_BLOCK PUBLIC FB_LampSetLevelCommand IMPLEMENTS I_Command
VAR
	refLamp		: REFERENCE TO FB_Lamp;
	byNewLevel	: BYTE;
END_VAR

METHOD Execute : BOOL
VAR
	isSuccessful : BOOL;
END_VAR

IF __ISVALIDREF(refLamp) THEN
	isSuccessful := refLamp.SetLevel(byNewLevel);
	Execute := isSuccessful;
ELSE
	Execute := FALSE;
END_IF
END_FUNCTION_BLOCK
