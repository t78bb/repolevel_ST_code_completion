VAR_OUTPUT
END_VAR
VAR
	//Variable to save the state of the concrete component to be decorated
	tempComponent : Component_Interface;
	//String variable to save the Description of the component
	sDescription : STRING;
	//Real variable to save the Value of the component
	rValue : REAL;
END_VAR

// Check if the input component is valid
IF tempInputComponent <> 0 THEN
	// Assign the input component to the temporary component
	THIS^.tempComponent := tempInputComponent;

	// Concatenate the description of the input component with the decorator's description
	getDescription := CONCAT(THIS^.tempComponent.getDescription(), THIS^.sDescription);
ELSE
	// If no valid input component is provided, return only the decorator's description
	getDescription := THIS^.sDescription;
END_IF;