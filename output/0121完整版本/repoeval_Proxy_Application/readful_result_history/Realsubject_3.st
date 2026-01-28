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

// Proper separation of method declarations and implementations
 
 METHOD Get_Method : INT
 // Declaration of method Get_Method
 END_METHOD

 METHOD IMPLEMENTATION Get_Method
 // Implementation of Get_Method
 Get_Method := iProp; // Return the value of iProp
 END_METHOD

 METHOD Set_Method
 VAR_INPUT
  num : INT; // Value to be set on the iProp variable
 END_VAR
 // Declaration of method Set_Method
 END_METHOD

 METHOD IMPLEMENTATION Set_Method
 // Implementation of Set_Method
 iProp := num; // Assign the value of num to iProp
 END_METHOD
END_FUNCTION_BLOCK