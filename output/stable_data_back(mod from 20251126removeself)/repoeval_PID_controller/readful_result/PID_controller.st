VAR
	err: REAL; // Error (SP - PV)
	prev_err: REAL; // Previous error
	integral: REAL; // Integral accumulator
	derivative: REAL; // Derivative term
	prev_PV: REAL; // Previous process variable
	dt: REAL; // Time step in seconds
END_VAR

// Initialization
IF NOT IS_INITIALIZED THEN
	prev_err := 0.0;
	integral := 0.0;
	prev_PV := PV;
	dt := REAL_TO_TIME(SampleTime) / millis;
	IS_INITIALIZED := TRUE;
END_IF

// Calculate error
err := SP - PV;

// Proportional term
CO_P := Kc * err;

// Integral term
integral := integral + (err * dt);
CO_I := (Kc / Ti) * integral;

// Derivative term
derivative := -(PV - prev_PV) / dt; // Derivative on measurement
CO_D := Kc * Td * derivative;

// Calculate controller output
CO := CO_P + CO_I + CO_D;

// Apply output limits
IF CO > UpperLimit THEN
	CO := UpperLimit;
ELSIF CO < LowerLimit THEN
	CO := LowerLimit;
END_IF

// Update previous values
prev_err := err;
prev_PV := PV;