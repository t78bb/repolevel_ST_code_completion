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
    //Local variables to store intermediate values
    sTempDescription : STRING;
    rTempValue : REAL;
END_VAR

tempComponent := tempInputComponent; //Assign the input component to the decorator's component reference

//Retrieve and modify the description
sTempDescription := tempComponent.GetDescription();
sDescription := CONCAT(sTempDescription, ' + DecoratorA');

//Retrieve and modify the value
rTempValue := tempComponent.GetValue();
rValue := rTempValue + 10.0; //Add specific functionality by increasing the value

RETURN;
END_FUNCTION_BLOCK
