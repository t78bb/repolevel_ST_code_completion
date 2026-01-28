{attribute 'enable_dynamic_creation'}
//This class acts as a decorating class. It adds responsibilities and functionality to the component
FUNCTION_BLOCK ConcreteDecoratorA EXTENDS Decorator
VAR_INPUT
	//Reference to store the component to be decorated
	tempInputComponent : Component_Interface;
END_VAR
VAR_OUTPUT
END_VAR
VAR
	bIsValidComponent : BOOL;
END_VAR

IF tempInputComponent <> 0 THEN
	bIsValidComponent := TRUE;
ELSE
	bIsValidComponent := FALSE;
	RETURN;
END_IF

// Initialize the base class logic
tempComponent := tempInputComponent;

// Execute the core logic of the base component
tempComponent^.Execute();

// Add additional functionality specific to ConcreteDecoratorA
sDescription := CONCAT(tempComponent^.sDescription, ' + DecoratorA');
rValue := tempComponent^.rValue + 10.0;

// Return the updated state or result
RETURN;
END_FUNCTION_BLOCK
