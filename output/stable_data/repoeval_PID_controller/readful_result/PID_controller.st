VAR
    Error: REAL;
    PrevError: REAL := 0;
    Integral: REAL := 0;
    Derivative: REAL;
    DeltaTime: REAL;
    PrevPV: REAL := 0;
END_VAR

DeltaTime := TO_REAL(SampleTime) / TO_REAL(millis);

Error := SP - PV;

// Proportional term
CO_P := Kc * Error;

// Integral term
Integral := Integral + (Error * DeltaTime);
CO_I := (Kc / Ti) * Integral;

// Derivative term
Derivative := -(PV - PrevPV) / DeltaTime;
CO_D := Kc * Td * Derivative;

// Calculate Controller Output
CO := CO_P + CO_I + CO_D;

// Apply output limits
IF CO > UpperLimit THEN
    CO := UpperLimit;
ELSIF CO < LowerLimit THEN
    CO := LowerLimit;
END_IF;

// Update previous values
PrevError := Error;
PrevPV := PV;