FUNCTION_BLOCK PUBLIC FB_AirConditioning
VAR_OUTPUT
	bActive			: BOOL;
	lrTemperature	: LREAL;
END_VAR

VAR
    fbStandbyCommand : FB_AirConStandbyCommand;
    fbComfortCommand : FB_AirConComfortCommand;
END_VAR

METHOD PUBLIC Activate : BOOL
VAR_OUTPUT
    bActive : BOOL;
END_VAR
bActive := TRUE;
RETURN bActive;

METHOD PUBLIC Deactivate : BOOL
VAR_OUTPUT
    bActive : BOOL;
END_VAR
bActive := FALSE;
RETURN bActive;

METHOD PUBLIC SetTemperature : BOOL
VAR_INPUT
    lrNewTemperature : LREAL;
END_VAR
VAR_OUTPUT
    lrTemperature : LREAL;
END_VAR
lrTemperature := lrNewTemperature;
RETURN TRUE;

METHOD PUBLIC ExecuteStandbyCommand : BOOL
VAR
    bResult : BOOL;
END_VAR
fbStandbyCommand.refAirConditioning := THIS^;
bResult := fbStandbyCommand.Execute();
RETURN bResult;

METHOD PUBLIC ExecuteComfortCommand : BOOL
VAR
    bResult : BOOL;
END_VAR
fbComfortCommand.refAirConditioning := THIS^;
bResult := fbComfortCommand.Execute();
RETURN bResult;

METHOD PUBLIC GetStatus : STRING
VAR
    sStatus : STRING;
END_VAR
IF bActive THEN
    sStatus := CONCAT('Active, Temperature: ', REAL_TO_STRING(lrTemperature));
ELSE
    sStatus := 'Inactive';
END_IF
RETURN sStatus;
END_FUNCTION_BLOCK