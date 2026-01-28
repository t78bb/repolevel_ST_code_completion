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
  // Check if the SetLevel method is callable and valid
  IF refLamp.SetLevel(byNewLevel) THEN
    isSuccessful := TRUE;
    Execute := isSuccessful;
  ELSE
    isSuccessful := FALSE;
    Execute := isSuccessful;
  END_IF;
ELSE
  Execute := FALSE;
END_IF
END_FUNCTION_BLOCK