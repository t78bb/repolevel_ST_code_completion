{attribute 'enable_dynamic_creation'}
FUNCTION_BLOCK Realsubject IMPLEMENTS  Subject_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR

structured-text
{attribute 'enable_dynamic_creation'}
FUNCTION_BLOCK Proxy IMPLEMENTS Subject_Interface
VAR_INPUT
    // Input variable to receive the password from the client
    iClientPassword : INT;
    // Input variable to specify the value to be set in case of a WRITE request
    iClientSetValue : INT;
    // Input variable to specify if the request is a READ or WRITE request
    bClientReadWrite : BOOL; // TRUE for READ, FALSE for WRITE
END_VAR
VAR_OUTPUT
    // Output variable to return the value of the protected resource in case of a READ request
    iClientReadValue : INT;
    // Output variable to indicate if the request was successful
    bRequestAccepted : BOOL;
END_VAR
VAR
    // Pointer to store the reference to the RealSubject being protected
    refToRealSubject : POINTER TO Realsubject;
    // Temporary variable to store the password entered by the client
    iTempPassword : INT;
END_VAR
VAR_STAT
    // Default password value for the request to be accepted
    iRealPassword : INT := 1234;
END_VAR

// Implementation of the Proxy logic
METHOD fb_init
VAR_INPUT
    bInitRetains : BOOL;
    bInCopyCode : BOOL;
    ptrToRealSubject : POINTER TO Realsubject;
END_VAR
BEGIN
    // Initialize the reference to the RealSubject
    refToRealSubject := ptrToRealSubject;
END_METHOD

METHOD PUBLIC ExecuteRequest
BEGIN
    // Check if the client's password matches the real password
    IF iClientPassword = iRealPassword THEN
        bRequestAccepted := TRUE;

        // Handle READ request
        IF bClientReadWrite THEN
            iClientReadValue := refToRealSubject^.Get_Method();
        ELSE
            // Handle WRITE request
            refToRealSubject^.Set_Method(iClientSetValue);
        END_IF;
    ELSE
        // Reject the request if the password is incorrect
        bRequestAccepted := FALSE;
    END_IF;
END_METHOD