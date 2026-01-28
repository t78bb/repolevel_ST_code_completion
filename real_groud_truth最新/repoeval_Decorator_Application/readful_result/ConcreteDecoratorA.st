VAR
	//Variable to save the state of the concrete component to be decorated
	tempComponent : Component_Interface;
	//String variable to save the Description of the component
	sDescription : STRING := 'Decorator A';
	//Real variable to save the Value of the component
	rValue : REAL;
END_VAR

METHOD getDescription : STRING
VAR_INPUT
END_VAR

//Outputs the decorated description of the component by obtaining the description of the component
// to be decorated stored in tempComponent.getDescription() and then concatenates the decoration
// description ('Decorator A' as example)
getDescription := CONCAT(THIS^.tempComponent.getDescription(), THIS^.sDescription);

METHOD getValue : REAL
VAR_INPUT
END_VAR

//Outputs the decorated value of the component by obtaining the value of the component
// to be decorated stored in tempComponent.getValue() and then adds the decoration value
getValue := THIS^.tempComponent.getValue() + THIS^.rValue;