//***************************************************************
//* Continue defining the internal variables and logic for the PID controller
//***************************************************************
VAR
    err: REAL; // Error (SP - PV)
    prev_err: REAL := 0; // Previous error
    integral: REAL := 0; // Integral accumulator
    derivative: REAL := 0; // Derivative term
    prev_PV: REAL := 0; // Previous process variable
    last_time: TIME := T#0ms; // Last execution time
END_VAR

//***************************************************************
//* Initialization logic
//***************************************************************
IF last_time = T#0ms THEN
    last_time := TIME(); // Initialize the last execution time
END_IF

//***************************************************************
//* Main PID calculation logic
//***************************************************************
err := SP - PV; // Calculate error

// Proportional term
CO_P := Kc * err;

// Integral term
integral := integral + (err * TO_REAL(SampleTime) / TO_REAL(millis));
CO_I := Kc * (integral / Ti);

// Derivative term
IF SampleTime > T#0ms THEN
    derivative := (PV - prev_PV) / TO_REAL(SampleTime);
END_IF
CO_D := -Kc * Td * derivative;

// Calculate the total controller output
CO := CO_P + CO_I + CO_D;

// Apply output limits
IF CO > UpperLimit THEN
    CO := UpperLimit;
ELSIF CO < LowerLimit THEN
    CO := LowerLimit;
END_IF

// Update previous values for the next iteration
prev_err := err;
prev_PV := PV;
last_time := TIME();