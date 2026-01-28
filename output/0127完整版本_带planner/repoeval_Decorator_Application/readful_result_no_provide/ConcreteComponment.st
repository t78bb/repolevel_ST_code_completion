VAR
  // Internal variables for description and value
  sDescription : STRING := ''; // Holds the description
  rValue : REAL := 0.0;        // Holds the value
END_VAR

METHOD SetDescription : BOOL
VAR_INPUT
newDescription : STRING;  // Input: New description value
END_VAR
// Correctly assign new description to the internal variable
sDescription := newDescription;
SetDescription := TRUE;   // Return TRUE for success
END_METHOD

METHOD SetValue : BOOL
VAR_INPUT
newValue : REAL;   // Input: New value
END_VAR
// Properly assign new value to the existing internal variable
rValue := newValue;
SetValue := TRUE;   // Return TRUE for success
END_METHOD

METHOD GetInfo : STRING
VAR
combinedInfo : STRING;  // Temporary string for combined output
END_VAR
// Correctly concatenate description and value
combinedInfo := CONCAT(CONCAT(sDescription, ' - '), REAL_TO_STRING(rValue));
GetInfo := combinedInfo;  // Return the combined string
END_METHOD

METHOD InterfaceMethod : BOOL
// Properly return TRUE as confirmation of compatibility with Component_Interface
InterfaceMethod := TRUE;
END_METHOD
END_FUNCTION_BLOCK