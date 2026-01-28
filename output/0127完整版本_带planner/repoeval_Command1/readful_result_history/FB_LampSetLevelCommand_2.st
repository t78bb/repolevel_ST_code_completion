FUNCTION_BLOCK PUBLIC FB_LampSetLevelCommand IMPLEMENTS I_Command
VAR
	refLamp		: REFERENCE TO FB_Lamp;
	byNewLevel	: BYTE;
	bResult		: BOOL;
END_VAR

IF (__ISVALIDREF(refLamp)) THEN
  IF (byNewLevel > 100) THEN
    byNewLevel := 100; // Set to maximum allowed value if out of range
  END_IF
  
  // BYTE data type cannot be less than 0, the check is removed here.

  bResult := refLamp.SetLevel(byNewLevel); // Update brightness level in hardware
  
  IF bResult THEN
    RETURN; // Command executed successfully
  END_IF
END_IF

bResult := FALSE; // Command execution failed
RETURN;
END_FUNCTION_BLOCK