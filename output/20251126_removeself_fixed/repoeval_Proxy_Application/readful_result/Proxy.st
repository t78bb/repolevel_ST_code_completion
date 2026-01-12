{attribute 'enable_dynamic_creation'}
FUNCTION_BLOCK Proxy IMPLEMENTS  Subject_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR

VAR
    // Pointer to the RealSubject instance
    refToRealSubject : POINTER TO Realsubject;
    // Temporary password entered by the client
    iTempPassword : INT;
    // Value to be set if the request is a WRITE request
    iSetValue : INT;
    // Boolean indicating if the request is a WRITE or READ request
    bReadWrite : BOOL;
END_VAR
VAR_STAT
    // Default password value for the request to be accepted
    iRealPassword : INT := 1234;
END_VAR

// Method to initialize the Proxy function block
METHOD fb_init
VAR_INPUT
    bInitRetains : BOOL; // TRUE: the Retain-variables are initialized (reset warm / reset cold)
    bInCopyCode : BOOL;  // TRUE: the instance will be copied to the copy-code afterward (online change)
    ptrToRealSubject : POINTER TO Realsubject; // Pointer to the RealSubject instance
    iTempPassword : INT; // Password passed by the client
    iSetValue : INT; // Value to be set if the request is accepted
    bReadWrite : BOOL; // Boolean indicating if the request is a WRITE or READ request
END_VAR
VAR_OUTPUT
END_VAR
VAR
    // Pointer to store the reference to the subject being protected
    refToRealSubject : POINTER TO Realsubject;
    // Last value of password entered by the client in the visualization element
    iTempPassword : INT;
END_VAR
VAR_STAT
    // Default password value for the request to be accepted
    iRealPassword : INT := 1234;
END_VAR

// Method to handle the Get request
METHOD Get_Method : INT
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    // Local variable to store the result of the Get request
    iResult : INT;
END_VAR

// Implementation of the Get_Method
iResult := refToRealSubject^.iProp;
RETURN iResult;

// Method to handle the Set request
METHOD Set_Method
VAR_INPUT
    num : INT; // Value to be set passed as an argument
END_VAR
VAR_OUTPUT
END_VAR
VAR
    // Local variable to store the result of the Set request
    bSuccess : BOOL;
END_VAR

// Implementation of the Set_Method
IF iTempPassword = iRealPassword THEN
    refToRealSubject^.iProp := num;
    bSuccess := TRUE;
ELSE
    bSuccess := FALSE;
END_IF
RETURN bSuccess;