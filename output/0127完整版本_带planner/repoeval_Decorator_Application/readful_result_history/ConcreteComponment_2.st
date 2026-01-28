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
 // Assign the new description to the internal variable
 sDescription := newDescription;
 SetDescription := TRUE;   // Indicate success
END_METHOD

METHOD SetValue : BOOL
VAR_INPUT
 newValue : REAL;   // Input: New value
END_VAR
 // Assign the new value to the internal variable
 rValue := newValue;
 SetValue := TRUE;   // Indicate success
END_METHOD

METHOD GetInfo : STRING
VAR
 combinedInfo : STRING;  // Temporary string for combining output
END_VAR
 // Create combined information of description and value
 combinedInfo := CONCAT(CONCAT(sDescription, ' - '), REAL_TO_STRING(rValue));
 GetInfo := combinedInfo;  // Indicate result
END_METHOD

METHOD InterfaceMethod : BOOL
 // Return TRUE as compatibility confirmation with Component_Interface
 InterfaceMethod := TRUE;
END_METHOD
END_FUNCTION_BLOCK