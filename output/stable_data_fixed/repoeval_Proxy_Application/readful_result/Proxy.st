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
    // Default password for validation
    iRealPassword : INT := 1234;
END_VAR

METHOD fb_init
VAR_INPUT
    bInitRetains : BOOL;
    bInCopyCode : BOOL;
    ptrToRealSubject : POINTER TO Realsubject;
    iTempPassword : INT;
    iSetValue : INT;
    bReadWrite : BOOL;
END_VAR
VAR
    bAccessGranted : BOOL;
END_VAR

// Initialize the reference to the RealSubject
refToRealSubject := ptrToRealSubject;

// Validate the password
IF iTempPassword = iRealPassword THEN
    bAccessGranted := TRUE;
ELSE
    bAccessGranted := FALSE;
END_IF

// Handle READ or WRITE request based on bReadWrite
IF bAccessGranted THEN
    IF bReadWrite THEN
        // WRITE request: Set the value in RealSubject
        refToRealSubject^.iProp := iSetValue;
    ELSE
        // READ request: Retrieve the value from RealSubject
        iSetValue := refToRealSubject^.iProp;
    END_IF
END_IF

RETURN;

METHOD Get_Method : INT
VAR
    iValue : INT;
END_VAR

// Retrieve the value from RealSubject
iValue := refToRealSubject^.iProp;
Get_Method := iValue;

METHOD Set_Method
VAR_INPUT
    num : INT;
END_VAR

// Set the value in RealSubject
refToRealSubject^.iProp := num;
RETURN;
