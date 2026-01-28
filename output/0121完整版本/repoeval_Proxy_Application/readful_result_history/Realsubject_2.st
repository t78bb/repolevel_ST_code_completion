{attribute 'enable_dynamic_creation'}
FUNCTION_BLOCK Realsubject IMPLEMENTS  Subject_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    // Variable to get and set values
    iProp: INT;
END_VAR

VAR_STAT
    // No static variables required for this implementation
END_VAR

// Declaration of public methods before starting the implementation part

// Declare and implement methods properly

 METHOD Get_Method : INT
 // Implementation of Get_Method
 Get_Method := iProp; // Assign the value of iProp directly
 END_METHOD

 METHOD Set_Method
 VAR_INPUT
  num : INT; // Value to be set on the iProp variable
 END_VAR
 // Implementation of Set_Method
 iProp := num; // Assign num value to iProp directly
 END_METHOD
END_FUNCTION_BLOCK