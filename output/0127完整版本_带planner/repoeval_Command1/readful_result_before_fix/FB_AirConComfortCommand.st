FUNCTION_BLOCK PUBLIC FB_AirConComfortCommand IMPLEMENTS I_Command
VAR
    targetTemperature : LREAL;
    targetFanSpeed    : INT;
    targetMode        : INT;
    bCommandExecuted  : BOOL;
END_VAR

VAR CONSTANT
    MODE_COOL : INT := 1;
    MODE_HEAT : INT := 2;
    MODE_FAN  : INT := 3;
END_VAR

VAR
    bIsOperable : BOOL;
END_VAR

// Initialize control parameters
targetTemperature := 22.0; // Default target temperature
targetFanSpeed := 2;       // Default fan speed
targetMode := MODE_COOL;   // Default mode

// Check if the air conditioning system is operable
IF __ISVALIDREF(refAirConditioning) THEN
    bIsOperable := refAirConditioning.bActive;
ELSE
    bIsOperable := FALSE;
END_IF

// Execute comfort command if operable
IF bIsOperable THEN
    refAirConditioning.SetTemperature(targetTemperature);
    refAirConditioning.SetFanSpeed(targetFanSpeed);
    CASE targetMode OF
        MODE_COOL: refAirConditioning.SetModeCool();
        MODE_HEAT: refAirConditioning.SetModeHeat();
        MODE_FAN:  refAirConditioning.SetModeFan();
    END_CASE;

    // Trigger hardware update
    refAirConditioning.Activate();
    bCommandExecuted := TRUE;
ELSE
    bCommandExecuted := FALSE;
END_IF

// Return execution result
RETURN;
END_FUNCTION_BLOCK
