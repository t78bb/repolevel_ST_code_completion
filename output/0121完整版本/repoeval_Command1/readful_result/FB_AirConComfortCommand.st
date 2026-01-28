FUNCTION_BLOCK PUBLIC FB_AirConComfortCommand IMPLEMENTS I_Command
VAR
	refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

METHOD Execute : BOOL
VAR
	isValid : BOOL;
END_VAR

isValid := (refAirConditioning <> 0);

IF isValid THEN
refAirConditioning^.Activate();
refAirConditioning^.SetTemperature(20.0);
Execute := TRUE;
ELSE
Execute := FALSE;
END_IF
END_FUNCTION_BLOCK