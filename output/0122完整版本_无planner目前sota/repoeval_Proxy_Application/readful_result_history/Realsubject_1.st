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
THIS^.iProp := THIS^.iProp; // Correct implementation
RETURN; // Use RETURN as method conclusion
END_METHOD

METHOD Set_Method : INT
num := THIS^.iProp; // Correct assignment
RETURN; // Use RETURN as exit
END_METHOD
END_FUNCTION_BLOCK