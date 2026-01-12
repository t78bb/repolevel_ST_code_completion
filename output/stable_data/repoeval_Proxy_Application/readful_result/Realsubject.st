VAR
    // Variable to store a property value
    iProp : INT;
END_VAR

METHOD PUBLIC Set_Method
VAR_INPUT
    num : INT; // Value to set on iProp
END_VAR
iProp := num;

METHOD PUBLIC Get_Method : INT
Get_Method := iProp;