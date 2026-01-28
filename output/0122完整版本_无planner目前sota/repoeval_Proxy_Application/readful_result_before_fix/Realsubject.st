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
END_VAR

METHOD PUBLIC Get_Method : INT
VAR
END_VAR
Get_Method := THIS^.iProp;

METHOD Set_Method
VAR_INPUT
    num : INT;
END_VAR
THIS^.iProp := num;
END_FUNCTION_BLOCK
