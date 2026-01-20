{attribute 'enable_dynamic_creation'}
FUNCTION_BLOCK Realsubject IMPLEMENTS  Subject_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    //Variable to get and set values
    iProp: INT;
END_VAR

METHOD Set_Method
VAR_INPUT
  num : INT; //Value to be set on the iProp variable
END_VAR
iProp := num; // Assign directly, no need for a qualified reference

METHOD PUBLIC Get_Method : INT
VAR
END_VAR
RETURN iProp; // Return the value explicitly
END_FUNCTION_BLOCK