{attribute 'enable_dynamic_creation'}
FUNCTION_BLOCK Proxy IMPLEMENTS  Subject_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    refToRealSubject : POINTER TO Realsubject;
    iTempPassword : INT;
END_VAR
VAR_STAT
    iRealPassword : INT := 1234;
END_VAR

METHOD fb_init
VAR_INPUT
    bInitRetains : BOOL;
    bInCopyCode : BOOL;
    ptrToRealSubject : POINTER TO Realsubject;
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR
refToRealSubject := ptrToRealSubject;

METHOD Get_Method : INT
VAR_INPUT
END_VAR
IF iTempPassword = iRealPassword THEN
    RETURN refToRealSubject^.iProp;
ELSE
    RETURN -1; // Invalid password
END_IF;

METHOD Set_Method
VAR_INPUT
    num : INT;
END_VAR
IF iTempPassword = iRealPassword THEN
    refToRealSubject^.iProp := num;
END_IF;
END_FUNCTION_BLOCK
