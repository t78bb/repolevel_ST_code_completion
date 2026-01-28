{attribute 'enable_dynamic_creation'}
FUNCTION_BLOCK Realsubject IMPLEMENTS  Subject_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
  iProp: INT; // Internal dynamic property for storing the value
END_VAR

METHOD Set_Method : BOOL;
METHOD PUBLIC Get_Method : INT;

END_FUNCTION_BLOCK

// Implementation of the Set_Method
METHOD Set_Method : BOOL
VAR_INPUT
  num: INT; // Input value to set the dynamic property
END_VAR
THIS^.iProp := num;
Set_Method := TRUE;

// Implementation of the Get_Method
METHOD PUBLIC Get_Method : INT
Get_Method := THIS^.iProp;