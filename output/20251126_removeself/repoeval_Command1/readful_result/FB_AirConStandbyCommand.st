VAR
    refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR
VAR_INPUT
    bInitRetains : BOOL; // if TRUE, the retain variables are initialized (warm start / cold start)
    bInCopyCode : BOOL;  // if TRUE, the instance afterwards gets moved into the copy code (online change)
    refNewAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

// Initialization logic for the air conditioning reference
IF (__ISVALIDREF(refNewAirConditioning)) THEN
    THIS^.refAirConditioning REF= refNewAirConditioning;
ELSE
    THIS^.refAirConditioning REF= 0;
END_IF

// Additional logic for standby mode
IF (__ISVALIDREF(refAirConditioning)) THEN
    refAirConditioning.bActive := FALSE; // Set air conditioning to inactive
    refAirConditioning.lrTemperature := 25.0; // Set a default standby temperature
END_IF