VAR
    e: REAL; // Error
    deltaPV: REAL; // Change in process variable
    SampleTimeSec: REAL; // Sample time in seconds
    CO_temp: REAL; // Temporary control output
END_VAR

// Convert SampleTime from TIME to seconds
SampleTimeSec := TIME_TO_REAL(SampleTime) / millis;

// Step 1: Calculate error
e := SP - PV;

// Step 2: Calculate proportional term
CO_P := Kc * e;

// Step 3: Update and limit integral term
CO_I := CO_I + (Kc * e * (SampleTimeSec / Ti));
IF CO_I > UpperLimit THEN
    CO_I := UpperLimit;
ELSIF CO_I < LowerLimit THEN
    CO_I := LowerLimit;
END_IF

// Step 4: Calculate derivative term
deltaPV := 0; // As 'lastTime' is not defined, no valid derivative can be computed
CO_D := 0;    // Set derivative term to 0

// Step 5: Calculate total control output and limit it
CO_temp := CO_P + CO_I + CO_D;
IF CO_temp > UpperLimit THEN
    CO := UpperLimit;
ELSIF CO_temp < LowerLimit THEN
    CO := LowerLimit;
ELSE
    CO := CO_temp;
END_IF

// Step 6: Save current PV for next cycle
// Removed assignment to undefined variable 'lastTime'
END_FUNCTION_BLOCK