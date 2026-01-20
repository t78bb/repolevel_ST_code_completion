FUNCTION_BLOCK PUBLIC FB_LampSetLevelCommand IMPLEMENTS I_Command
VAR
  refLamp		: REFERENCE TO FB_Lamp;
  byNewLevel	: BYTE;
END_VAR

IF __ISVALIDREF(refLamp) THEN
  refLamp.SetLevel(byNewLevel);
END_IF
END_FUNCTION_BLOCK