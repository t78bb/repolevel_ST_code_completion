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
END_VAR

METHOD PUBLIC Decorate : BOOL
VAR
    bResult : BOOL;
END_VAR
    // Assign the input component to the internal component reference
// Ensure the input component's description and value are updated directly
  tempInputComponent.sDescription := CONCAT(tempInputComponent.sDescription, ' + FeatureA');
  tempInputComponent.rValue := tempInputComponent.rValue + 10.0;

  // Indicate successful decoration
  bResult := TRUE;
  Decorate := bResult;
END_METHOD
END_FUNCTION_BLOCK