{attribute 'enable_dynamic_creation'}
FUNCTION_BLOCK Realsubject IMPLEMENTS  Subject_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR

VAR
    // Property variable to store the value set by the client
    iProp : INT;
END_VAR

METHOD PUBLIC Set_Method
VAR_INPUT
    // Value to be set on the iProp variable
    num : INT;
END_VAR
// Assign the input value to the property variable
THIS^.iProp := num;

METHOD PUBLIC Get_Method : INT
VAR
    // Temporary variable to hold the property value
    tempProp : INT;
END_VAR
// Retrieve the value of the property variable
tempProp := THIS^.iProp;
Get_Method := tempProp;

METHOD fb_init
VAR_INPUT
    // Boolean values for initialization
    bInitRetains : BOOL; // TRUE: Retain-variables are initialized
    bInCopyCode : BOOL;  // TRUE: Instance will be copied to copy-code afterward
END_VAR
VAR_OUTPUT
END_VAR
VAR
    // Initialization logic for the RealSubject instance
    iProp := 0; // Default value for the property variable
END_VAR
END_FUNCTION_BLOCK