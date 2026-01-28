VAR
	_rT: LREAL;
	_rY: LREAL;
END_VAR

_rT := TIME_TO_REAL(tT) / 10.0;  // Convert time constant to real and adjust for sampling period

IF _rT = 0.0 THEN
	rOutput := rInput;  // Initialize output if time constant is zero
ELSIF ABS(rOutput - rInput) < 1E-6 THEN
	rOutput := rInput;  // Prevent division by zero for small differences
ELSIF _rT > 0.0 THEN
	rOutput := (rK / _rT) * rInput + (1.0 - (1.0 / _rT)) * _rY;  // Apply PT1 filter formula
ELSE
	rOutput := rInput;  // Output equals input if time constant is less than or equal to zero
END_IF

_rY := rOutput;  // Update internal state
END_FUNCTION_BLOCK
