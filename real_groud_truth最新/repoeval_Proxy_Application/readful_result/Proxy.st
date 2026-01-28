VAR
    // Pointer to store the reference to the subject being protected
    refToRealSubject : POINTER TO Realsubject;
    // Last value of password entered by the client in the visualization element
    iTempPassword : INT;
    // Local variable to be used in WRITE request, it is the value to be set if the request is accepted
    iSetValue : INT;
    // Boolean value that specifies if the request is a WRITE or READ request
    bReadWrite : BOOL;
END_VAR
VAR_STAT
    // Default password value for the request to be accepted
    iRealPassword : INT := 1234;
END_VAR

METHOD fb_init
VAR_INPUT
    // These boolean values are required for an automatic constructor
    bInitRetains : BOOL; // TRUE: the Retain-variables are initialized (reset warm / reset cold)
    bInCopyCode : BOOL;  // TRUE: the instance will be copied to the copy-code afterward (online change)
    // Pointer to the RealSubject instance
    ptrToRealSubject : POINTER TO Realsubject;
END_VAR
VAR_OUTPUT
END_VAR
VAR
    // Initialize the reference to the RealSubject
    refToRealSubject := ptrToRealSubject;
END_VAR

METHOD Get_Method : INT
VAR_INPUT
END_VAR
VAR
    // Check if the request is a READ request
    IF bReadWrite = FALSE THEN
        // Return the property value from the RealSubject
        RETURN refToRealSubject^.iProp;
    ELSE
        // Invalid request type
        RETURN -1;
    END_IF
END_VAR

METHOD Set_Method
VAR_INPUT
    // Value to be set passed as an argument
    num : INT;
END_VAR
VAR
    // Check if the request is a WRITE request and password matches
    IF bReadWrite = TRUE AND iTempPassword = iRealPassword THEN
        // Set the property value in the RealSubject
        refToRealSubject^.iProp := num;
    ELSE
        // Invalid request or password mismatch
        // Handle error or log the issue
    END_IF
END_VAR