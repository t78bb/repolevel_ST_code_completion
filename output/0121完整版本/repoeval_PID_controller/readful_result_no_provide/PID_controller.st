VAR
	lastErr: REAL := 0; //Previous error
	integral: REAL := 0; //Integral accumulator
	deltaTime: REAL := 0; //Time difference in seconds
	deltaPV: REAL := 0; //Change in process variable
END_VAR

// Removed 'now' and 'lastTime' since they are undefined. Time difference logic is adjusted accordingly.
// Removed 'err' and directly calculated SP - PV in expressions where needed.

deltaTime := TO_REAL(SampleTime) / TO_REAL(millis); // Assuming SampleTime is used for time difference

// Use SP - PV directly instead of 'err'
// Proportional term
CO_P := Kc * (SP - PV);

// Integral term with anti-windup
integral := integral + ((SP - PV) * deltaTime);
IF integral > UpperLimit THEN
  integral := UpperLimit;
ELSIF integral < LowerLimit THEN
  integral := LowerLimit;
END_IF;
CO_I := (Kc / Ti) * integral;

// Derivative term
deltaPV := PV - lastErr;
CO_D := (-Kc * Td) * (deltaPV / deltaTime);

// Calculate total controller output
CO := CO_P + CO_I + CO_D;

// Apply output limits
IF CO > UpperLimit THEN
  CO := UpperLimit;
ELSIF CO < LowerLimit THEN
  CO := LowerLimit;
END_IF;

// Update previous values
lastErr := PV;

// Replaced 'err' with (SP - PV) inline calculation. Removed references to undefined 'lastTime' and 'now'.

// Proportional term
CO_P := Kc * (SP - PV);

// Integral term with anti-windup
integral := integral + ((SP - PV) * deltaTime);
IF integral > UpperLimit THEN
  integral := UpperLimit;
ELSIF integral < LowerLimit THEN
  integral := LowerLimit;
END_IF;
CO_I := (Kc / Ti) * integral;

// Derivative term
deltaPV := PV - lastErr;
CO_D := (-Kc * Td) * (deltaPV / deltaTime);

// Calculate total controller output
CO := CO_P + CO_I + CO_D;

// Apply output limits
IF CO > UpperLimit THEN
  CO := UpperLimit;
ELSIF CO < LowerLimit THEN
  CO := LowerLimit;
END_IF;

// Update previous values
lastErr := PV; // Removed reference to 'lastTime' for simplicity
END_FUNCTION_BLOCK