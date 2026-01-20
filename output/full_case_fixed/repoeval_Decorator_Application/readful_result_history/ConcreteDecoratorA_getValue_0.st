//Illustrative method of the pattern
METHOD getValue : REAL
VAR_INPUT
	//Reference to store the component to be decorated
	tempInputComponent : Component_Interface;
END_VAR
VAR_OUTPUT
END_VAR
VAR
	//Variable to save the state of the concrete component to be decorated
	tempComponent : Component_Interface;
	//Real variable to save the decoration value
	rDecorationValue : REAL := 0.5; // Example fixed value for decoration
END_VAR

// Assign the input component to the temporary component variable
tempComponent := tempInputComponent;

// Outputs the decorated value by obtaining the value of the component to be decorated
// and adding the fixed decoration value
getValue := tempComponent.getValue() + rDecorationValue;
RETURN;
END_OTHER
