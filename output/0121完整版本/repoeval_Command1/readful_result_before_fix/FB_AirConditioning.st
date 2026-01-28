FUNCTION_BLOCK PUBLIC FB_AirConditioning
VAR_OUTPUT
	bActive			: BOOL;
	lrTemperature	: LREAL;
END_VAR
VAR
    bIsInitialized : BOOL := FALSE;
    lrDefaultTemperature : LREAL := 22.0;
END_VAR

IF NOT bIsInitialized THEN
    bActive := FALSE;
    lrTemperature := lrDefaultTemperature;
    bIsInitialized := TRUE;
END_IF;

IF bActive THEN
    (* Logic for active air conditioning can be added here if needed *)
ELSE
    (* Logic for inactive air conditioning can be added here if needed *)
END_IF;
END_FUNCTION_BLOCK
