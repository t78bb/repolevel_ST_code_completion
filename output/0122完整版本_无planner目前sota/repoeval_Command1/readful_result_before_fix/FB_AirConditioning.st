FUNCTION_BLOCK PUBLIC FB_AirConditioning
VAR_OUTPUT
	bActive			: BOOL;
	lrTemperature	: LREAL;
END_VAR
VAR
    bInitialized : BOOL := FALSE;
END_VAR

IF NOT bInitialized THEN
    bActive := FALSE;
    lrTemperature := 22.0; // Default temperature
    bInitialized := TRUE;
END_IF;

IF bActive THEN
    // Logic for active air conditioning operation can be added here
ELSE
    // Logic for inactive air conditioning state can be added here
END_IF;
END_FUNCTION_BLOCK
