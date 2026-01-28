FUNCTION_BLOCK PUBLIC FB_SocketOffCommand IMPLEMENTS I_Command
VAR
    refSocket : REFERENCE TO FB_Socket;
END_VAR

VAR
    bIsValidRef : BOOL;
END_VAR

bIsValidRef := __ISVALIDREF(refSocket);

IF bIsValidRef THEN
    refSocket.Off();
END_IF
END_FUNCTION_BLOCK
