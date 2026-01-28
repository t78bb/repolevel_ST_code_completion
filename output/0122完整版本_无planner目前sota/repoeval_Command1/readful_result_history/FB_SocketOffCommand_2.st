FUNCTION_BLOCK PUBLIC FB_SocketOffCommand IMPLEMENTS I_Command
VAR
 refSocket : REFERENCE TO FB_Socket;
END_VAR

VAR
 bIsValidRef : BOOL;
END_VAR

// Check if the reference is valid
bIsValidRef := __ISVALIDREF(refSocket); // Update bIsValidRef based on reference validity

IF bIsValidRef THEN
 refSocket.Off(); // Call the Off method of the referenced instance if valid
END_IF

END_FUNCTION_BLOCK