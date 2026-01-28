{attribute 'enable_dynamic_creation'}
FUNCTION_BLOCK Proxy IMPLEMENTS  Subject_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    // Pointer to store the reference to the subject being protected
    refToRealSubject : POINTER TO Realsubject;
    // Last value of password entered by the client in the visualization element
    iTempPassword : INT;
    // Variable to store the result of the last access attempt
    bLastAccessSuccess : BOOL;
END_VAR
VAR_STAT
    // Default password value for the request to be accepted
    iRealPassword : INT := 1234;
END_VAR

METHOD fb_init
VAR_INPUT
    bInitRetains : BOOL;
    bInCopyCode : BOOL;
    ptrToRealSubject : POINTER TO Realsubject;
END_VAR
refToRealSubject := ptrToRealSubject;

METHOD Get_Method : INT
IF iTempPassword = iRealPassword THEN
    bLastAccessSuccess := TRUE;
    IF refToRealSubject <> 0 THEN
        RETURN refToRealSubject^.iProp;
    END_IF
ELSE
    bLastAccessSuccess := FALSE;
    RETURN -1; // Error code for unauthorized access
END_IF

METHOD Set_Method
VAR_INPUT
    num : INT;
END_VAR
IF iTempPassword = iRealPassword THEN
    bLastAccessSuccess := TRUE;
    IF refToRealSubject <> 0 THEN
        refToRealSubject^.iProp := num;
    END_IF
ELSE
    bLastAccessSuccess := FALSE;
END_IF

METHOD UpdatePassword
VAR_INPUT
    newPassword : INT;
END_VAR
iRealPassword := newPassword;
END_FUNCTION_BLOCK
