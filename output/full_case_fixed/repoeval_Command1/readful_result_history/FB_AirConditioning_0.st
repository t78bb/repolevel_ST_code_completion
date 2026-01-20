FUNCTION_BLOCK PUBLIC FB_AirConditioning
VAR_OUTPUT
	bActive			: BOOL;
	lrTemperature	: LREAL;
END_VAR
VAR
    lrDefaultTemperature : LREAL := 22.0;
END_VAR

IF NOT bActive THEN
    lrTemperature := lrDefaultTemperature;
END_IF

RETURN;
END_FUNCTION_BLOCK
