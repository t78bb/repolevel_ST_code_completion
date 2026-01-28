VAR_OUTPUT
END_VAR
VAR
	// Variable to store the value of the component to be decorated
	rComponentValue : REAL;
	// Fixed value to be added as decoration
	rDecorationValue : REAL := 0.5;
END_VAR

// Obtain the value of the component to be decorated
rComponentValue := tempInputComponent.getValue();

// Add the decoration value to the component's value
getValue := rComponentValue + rDecorationValue;
END_OTHER
