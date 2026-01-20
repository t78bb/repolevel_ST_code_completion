FUNCTION_BLOCK PUBLIC FB_LampSetLevelCommand IMPLEMENTS I_Command
VAR
refLamp		: REFERENCE TO FB_Lamp;
byNewLevel	: BYTE;
END_VAR

IF __ISVALIDREF(refLamp) THEN
refLamp.SetLevel(byNewLevel); // Check SetLevel implementation and refLamp initialization
END_IF
END_FUNCTION_BLOCK