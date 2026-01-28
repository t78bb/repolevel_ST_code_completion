FUNCTION_BLOCK PUBLIC FB_AirConditioning
VAR_OUTPUT
	bActive			: BOOL;
	lrTemperature	: LREAL;
END_VAR
VAR
    lrDefaultTemperature : LREAL := 0.0;
    lrCalculatedTemperature : LREAL;
END_VAR

IF bActive THEN
    (* Calculate the current environment temperature based on control logic *)
    lrCalculatedTemperature := (* Insert temperature calculation logic here *);
    lrTemperature := lrCalculatedTemperature;
ELSE
    (* Set temperature to default value when inactive *)
    lrTemperature := lrDefaultTemperature;
END_IF;
END_FUNCTION_BLOCK
