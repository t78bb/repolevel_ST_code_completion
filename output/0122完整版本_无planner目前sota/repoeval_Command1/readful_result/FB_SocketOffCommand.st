FUNCTION_BLOCK PUBLIC FB_SocketOffCommand IMPLEMENTS I_Command
VAR
refSocket : REFERENCE TO FB_Socket;
END_VAR

VAR
bIsValidRef : BOOL;
END_VAR

// Check if the reference is valid
IF __ISVALIDREF(refSocket) THEN
refSocket.Off(); // Call the Off method of the referenced instance if valid
bIsValidRef := TRUE; // Set bIsValidRef to TRUE
ELSE
bIsValidRef := FALSE; // Set bIsValidRef to FALSE if reference is invalid
END_IF

END_FUNCTION_BLOCK