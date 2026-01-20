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
END_VAR

METHOD CreateObject : BOOL
VAR
  bSuccess : BOOL;
END_VAR

// Initialize bSuccess to FALSE
bSuccess := FALSE;

// Check for default string assignment conditions
IF sDescription = '' THEN
  sDescription := 'Default Description';
END_IF;

// Assign default real value
IF rValue = 0.0 THEN
  rValue := 1.0;
END_IF;

// Set bSuccess to TRUE after successful execution
bSuccess := TRUE;

// Return the result of the method
RETURN;
END_FUNCTION_BLOCK