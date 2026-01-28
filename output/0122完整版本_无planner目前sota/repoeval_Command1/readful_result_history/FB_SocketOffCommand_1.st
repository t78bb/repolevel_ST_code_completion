FUNCTION_BLOCK PUBLIC FB_SocketOffCommand IMPLEMENTS I_Command
VAR
  refSocket : REFERENCE TO FB_Socket;
END_VAR

VAR
  bIsValidRef : BOOL;
END_VAR

// Check if the reference is valid
IF __ISVALIDREF(refSocket) THEN
  bIsValidRef := TRUE;
  refSocket.Off(); // Call the Off method of the referenced instance
ELSE
  bIsValidRef := FALSE; // The reference is invalid
END_IF

END_FUNCTION_BLOCK