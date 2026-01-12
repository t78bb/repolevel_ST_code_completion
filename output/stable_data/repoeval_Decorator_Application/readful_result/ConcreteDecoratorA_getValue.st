VAR_OUTPUT
END_VAR
VAR
	//Variable to save the state of the concrete component to be decorated
	tempComponent : Component_Interface;
	//Real variable to save the Value of the component
	rValue : REAL;
END_VAR

//Assign the input component to the temporary component
tempComponent := tempInputComponent;

//Outputs the decorated cost of the component by obtaining the cost of the component to be decorated
//stored in tempComponent.getValue() and then adds the decoration value (example value: 0.25)
getValue := tempComponent.getValue() + THIS^.rValue;