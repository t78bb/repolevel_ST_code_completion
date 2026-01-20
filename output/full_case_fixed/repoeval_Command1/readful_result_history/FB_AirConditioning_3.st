FUNCTION_BLOCK PUBLIC FB_AirConditioning
VAR_OUTPUT
 bActive			: BOOL;
 lrTemperature	: LREAL;
END_VAR
VAR
 lrDefaultTemperature : LREAL := 22.0;
END_VAR

IF NOT bActive THEN
 lrTemperature := lrDefaultTemperature; // Explicitly set the output variable
ELSE
 lrTemperature := lrTemperature;        // Keep its value (already initialized externally if active) 
END_IF

END_FUNCTION_BLOCK