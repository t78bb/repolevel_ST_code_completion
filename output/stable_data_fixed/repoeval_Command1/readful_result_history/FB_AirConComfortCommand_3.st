FUNCTION_BLOCK PUBLIC FB_AirConComfortCommand IMPLEMENTS I_Command

VAR
    refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

METHOD Execute : BOOL
VAR
bSuccess : BOOL;
END_VAR

bSuccess := FALSE;

IF (__ISVALIDREF(refAirConditioning)) THEN
refAirConditioning.Activate();
refAirConditioning.SetTemperature(20.0);
bSuccess := TRUE;
END_IF;

RETURN bSuccess;

END_FUNCTION_BLOCK