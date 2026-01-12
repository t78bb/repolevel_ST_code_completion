FUNCTION_BLOCK PUBLIC FB_SocketOffCommand IMPLEMENTS I_Command

VAR
    refSocket : REFERENCE TO FB_Socket;
END_VAR

METHOD PUBLIC Execute
VAR
    bSuccess : BOOL;
END_VAR
IF (__ISVALIDREF(THIS^.refSocket)) THEN
    THIS^.refSocket.Off();
    bSuccess := TRUE;
ELSE
    bSuccess := FALSE;
END_IF
RETURN bSuccess;

METHOD PUBLIC FB_init
VAR_INPUT
    bInitRetains : BOOL; // if TRUE, the retain variables are initialized (warm start / cold start)
    bInCopyCode : BOOL;  // if TRUE, the instance afterwards gets moved into the copy code (online change)
    refNewSocket : REFERENCE TO FB_Socket;
END_VAR

IF (__ISVALIDREF(refNewSocket)) THEN
    THIS^.refSocket REF= refNewSocket;
ELSE
    THIS^.refSocket REF= 0;
END_IF