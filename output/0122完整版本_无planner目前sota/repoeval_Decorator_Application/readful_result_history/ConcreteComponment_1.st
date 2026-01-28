{attribute 'enable_dynamic_creation'}
//This class creates the most basic object well called. This object is to be decorated
FUNCTION_BLOCK ConcreteComponent IMPLEMENTS Component_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
  sDescription : STRING;
  rValue : REAL;
  tempDescription : STRING; // Moved from invalid nested VAR block
  tempValue : REAL;         // Moved from invalid nested VAR block
END_VAR

// Replacing METHOD with simple implementation logic
tempDescription := 'Basic Object';
tempValue := 0.0;

sDescription := tempDescription;
rValue := tempValue;

RETURN;
END_FUNCTION_BLOCK