FUNCTION_BLOCK PUBLIC FB_LampSetLevelCommand IMPLEMENTS I_Command
VAR
  refLamp		: REFERENCE TO FB_Lamp;   // Lamp reference
  byNewLevel	: BYTE;                  // New level to be set
  isExecuted : BOOL := FALSE;          // Execution status
END_VAR

IF __ISVALIDREF(refLamp) THEN
  refLamp.SetLevel(byNewLevel);        // Set the lamp level
  isExecuted := TRUE;                 // Mark command as executed
END_IF
END_FUNCTION_BLOCK