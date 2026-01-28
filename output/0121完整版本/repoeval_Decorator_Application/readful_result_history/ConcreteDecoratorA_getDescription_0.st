//Illustrative method of the pattern
METHOD getDescription : STRING
VAR_INPUT
	//Reference to store the component to be decorated
	tempInputComponent : Component_Interface;
END_VAR
VAR
	//Variable to save the state of the concrete component to be decorated
	tempComponent : Component_Interface;
	//String variable to save the Description of the component
	sDescription : STRING;
END_VAR

tempComponent := tempInputComponent;
sDescription := ' Decorator Description';
getDescription := CONCAT(tempComponent.getDescription(), sDescription);
END_OTHER
