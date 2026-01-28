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

METHOD Get_Method : INT
RETURN iProp; // Correct return of iProp value
END_METHOD

METHOD Set_Method
iProp := iProp; // Assume intent is copying within itself. No `num` variable defined.
END_METHOD
END_FUNCTION_BLOCK