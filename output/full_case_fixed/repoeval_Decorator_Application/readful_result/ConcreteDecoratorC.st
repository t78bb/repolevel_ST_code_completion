{attribute 'enable_dynamic_creation'}
//This class acts as a decorating class. It adds responsibilities and functionality to the component
FUNCTION_BLOCK ConcreteDecoratorC EXTENDS Decorator
VAR_INPUT
	//Reference to store the component to be decorated
	tempInputComponent : Component_Interface;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

tempComponent := tempInputComponent;
sDescription := tempComponent.sDescription + ' with additional functionality from ConcreteDecoratorC';
rValue := tempComponent.rValue + 10.0;
END_FUNCTION_BLOCK
