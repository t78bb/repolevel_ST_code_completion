{attribute 'enable_dynamic_creation'}
//This class creates the most basic object well called. This object is to be decorated
FUNCTION_BLOCK ConcreteComponent IMPLEMENTS Component_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
  // Internal variables for description and value
  sDescription : STRING := ''; // Holds the description
  rValue : REAL := 0.0;        // Holds the value
END_VAR

METHOD SetDescription : BOOL
VAR_INPUT
  newDescription : STRING;  // Input: New description value
END_VAR
  // Update internal description variable
  sDescription := newDescription;
  SetDescription := TRUE;   // Return success status
END_METHOD

METHOD SetValue : BOOL
VAR_INPUT
  newValue : REAL;   // Input: New value
END_VAR
  // Update internal value variable
  rValue := newValue;
  SetValue := TRUE;   // Return success status
END_METHOD

METHOD GetInfo : STRING
VAR
  combinedInfo : STRING;  // Temporary string for combined output
END_VAR
  // Concatenate description and value for output; ensure type casting
  combinedInfo := CONCAT(CONCAT(sDescription, ' - '), REAL_TO_STRING(rValue));
  GetInfo := combinedInfo;  // Return the combined string
END_METHOD

METHOD InterfaceMethod : BOOL
  // Ensure compatibility with Component_Interface by always returning TRUE
  InterfaceMethod := TRUE;
END_METHOD
END_FUNCTION_BLOCK