VAR_OUTPUT
END_VAR
VAR
	//Variable to save the state of the concrete component to be decorated
	tempComponent : Component_Interface;
	//String variable to save the Description of the component
	sDescription : STRING;
END_VAR

//Outputs the decorated description of the component by obtaining the description of the component
// to be decorated stored in tempComponent.getDescription() and then concatenates the decoration
// description (' Decorator' as example)
tempComponent := THIS^.tempInputComponent;
sDescription := ' Decorator';
getDescription := CONCAT(tempComponent.getDescription(), sDescription);