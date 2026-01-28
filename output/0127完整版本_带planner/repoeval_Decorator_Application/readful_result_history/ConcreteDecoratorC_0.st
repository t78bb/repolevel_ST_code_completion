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
    // Local variable to store the enhanced description
    sEnhancedDescription : STRING;
    // Local variable to store the enhanced value
    rEnhancedValue : REAL;
END_VAR

tempComponent := tempInputComponent; // Step 1: Pass the reference to the parent class

sDescription := tempComponent.sDescription; // Step 2: Execute existing functionality
rValue := tempComponent.rValue;

sEnhancedDescription := CONCAT(sDescription, ' - Enhanced by ConcreteDecoratorC'); // Step 3: Add specific enhancement
rEnhancedValue := rValue * 1.1; // Example of extending functionality by modifying the value

sDescription := sEnhancedDescription; // Step 4: Update the description with enhanced value
rValue := rEnhancedValue; // Update the value with enhanced value
END_FUNCTION_BLOCK
