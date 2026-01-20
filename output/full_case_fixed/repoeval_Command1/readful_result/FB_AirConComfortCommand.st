FUNCTION_BLOCK PUBLIC FB_AirConComfortCommand IMPLEMENTS I_Command
VAR
	refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

METHOD Execute : BOOL
VAR
  isValidRef : BOOL;
END_VAR

isValidRef := __ISVALIDREF(refAirConditioning);

IF isValidRef THEN
  refAirConditioning.Activate(); // Ensure this method exists in FB_AirConditioning
  refAirConditioning.SetTemperature(20.0); // Ensure SetTemperature(REAL) is defined in FB_AirConditioning
  Execute := TRUE;
ELSE
  Execute := FALSE;
END_IF
END_FUNCTION_BLOCK