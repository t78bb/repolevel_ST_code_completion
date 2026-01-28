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
	//Real variable to save the Value of the component
	rValue : REAL := 0.5; // Fixed decoration value
END_VAR

// Assign the input component to the temporary component variable
tempComponent := tempInputComponent;

// Outputs the decorated cost of the component by obtaining the cost of the component to be decorated 
// stored in tempComponent.getValue() and then adds the decoration value (0.5 as example)
getValue := tempComponent.getValue() + rValue;
END_OTHER
