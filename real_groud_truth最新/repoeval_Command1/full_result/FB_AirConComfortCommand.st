FUNCTION_BLOCK PUBLIC FB_AirConComfortCommand IMPLEMENTS I_Command

VAR
    refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

METHOD PUBLIC Execute
VAR
    bIsValid : BOOL;
END_VAR

// Check if the reference to the air conditioning system is valid
bIsValid := __ISVALIDREF(refAirConditioning);

IF bIsValid THEN
    // Activate the air conditioning system
    refAirConditioning.Activate();
    
    // Set the air conditioning system to comfort mode with a temperature of 22.0 degrees
    refAirConditioning.SetTemperature(22.0);
END_IF
END_FUNCTION_BLOCK