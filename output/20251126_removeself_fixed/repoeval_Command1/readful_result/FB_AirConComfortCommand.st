FUNCTION_BLOCK PUBLIC FB_AirConComfortCommand IMPLEMENTS I_Command

VAR
    refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

METHOD Execute
VAR
    refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

IF (__ISVALIDREF(THIS^.refAirConditioning)) THEN
    THIS^.refAirConditioning.Activate();
    THIS^.refAirConditioning.SetTemperature(22.0); // Set a comfortable temperature
END_IF