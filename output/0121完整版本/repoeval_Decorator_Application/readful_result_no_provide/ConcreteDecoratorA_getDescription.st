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
