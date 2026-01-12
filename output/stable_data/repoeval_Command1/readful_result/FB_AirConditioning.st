VAR
    bStandbyMode    : BOOL := FALSE;
    lrDefaultTemp   : LREAL := 22.0;
END_VAR

METHOD PUBLIC Activate
bActive := TRUE;

METHOD PUBLIC Deactivate
bActive := FALSE;

METHOD PUBLIC SetTemperature : BOOL
VAR_INPUT
    lrNewTemperature : LREAL;
END_VAR
lrTemperature := lrNewTemperature;
SetTemperature := TRUE;

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

METHOD PUBLIC IsStandbyMode : BOOL
IsStandbyMode := bStandbyMode;