{attribute 'enable_dynamic_creation'}
//This class acts as a decorating class. It adds responsibilities and functionality to the component
FUNCTION_BLOCK ConcreteDecoratorB EXTENDS Decorator
VAR_INPUT
	//Reference to store the component to be decorated
	tempInputComponent : Component_Interface;
END_VAR
VAR_OUTPUT
END_VAR
VAR
	// Local variable to track the state of the decorator
	bDecoratorExecuted : BOOL := FALSE;
END_VAR

IF tempInputComponent <> 0 THEN
	// Call the base functionality of the Decorator
	tempComponent := tempInputComponent;

	// Perform additional processing to extend or modify the behavior of the component
	sDescription := CONCAT(tempComponent.sDescription, ' + DecoratorB');
	rValue := tempComponent.rValue + 10.0;

	// Update the decorator state to indicate additional functionality has been executed
	bDecoratorExecuted := TRUE;

	// Pass the extended component data to the next decorator in the chain, if any
	IF tempComponent IS Component_Interface THEN
		tempComponent := tempComponent;
	END_IF;
END_IF;
END_FUNCTION_BLOCK
