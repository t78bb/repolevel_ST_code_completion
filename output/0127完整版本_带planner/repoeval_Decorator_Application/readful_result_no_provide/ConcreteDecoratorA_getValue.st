VAR
	// Variable to store the original value of the component
	rOriginalValue : REAL;
	// Variable to store the fixed decoration value
	rDecorationValue : REAL := 0.5;
END_VAR

// Step 1: Get the original value from the component
rOriginalValue := tempInputComponent.getValue();

// Step 2: Add the fixed decoration value
getValue := rOriginalValue + rDecorationValue;

// Step 3: Return the new value
RETURN;
END_OTHER
