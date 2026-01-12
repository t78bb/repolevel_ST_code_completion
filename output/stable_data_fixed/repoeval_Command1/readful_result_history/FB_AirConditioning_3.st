FUNCTION_BLOCK PUBLIC FB_AirConditioning
VAR_OUTPUT
	bActive			: BOOL;
	lrTemperature	: LREAL;
END_VAR

VAR
    bStandbyMode    : BOOL := FALSE;
    lrDefaultTemp   : LREAL := 22.0;
END_VAR

METHOD PUBLIC Activate
bActive := TRUE;
END_METHOD

METHOD PUBLIC Deactivate
bActive := FALSE;
END_METHOD

METHOD PUBLIC SetTemperature : BOOL
VAR_INPUT
  lrNewTemperature : LREAL;
END_VAR
lrTemperature := lrNewTemperature;
SetTemperature := TRUE;
END_METHOD

METHOD PUBLIC SetStandbyMode : BOOL
VAR_INPUT
  bEnableStandby : BOOL;
END_VAR
IF bEnableStandby THEN
  bStandbyMode := TRUE;
  bActive := FALSE;
  lrTemperature := lrDefaultTemp;
ELSE
  bStandbyMode := FALSE;
END_IF
SetStandbyMode := TRUE;
END_METHOD

METHOD PUBLIC IsStandbyMode : BOOL
IsStandbyMode := bStandbyMode;
END_METHOD

END_FUNCTION_BLOCK