FUNCTION_BLOCK PUBLIC FB_SocketOffCommand IMPLEMENTS I_Command

VAR
    refSocket : REFERENCE TO FB_Socket;
END_VAR

METHOD PUBLIC Execute : BOOL
VAR
    bSuccess : BOOL;
END_VAR
bSuccess := FALSE;

IF (__ISVALIDREF(THIS^.refSocket)) THEN
    THIS^.refSocket.Off();
    bSuccess := TRUE;
END_IF;

Execute := bSuccess;

METHOD PUBLIC FB_init : BOOL
VAR_INPUT
    bInitRetains : BOOL; // if TRUE, the retain variables are initialized (warm start / cold start)
    bInCopyCode : BOOL;  // if TRUE, the instance afterwards gets moved into the copy code (online change)
    refNewSocket : REFERENCE TO FB_Socket;
END_VAR
VAR
    bInitSuccess : BOOL;
END_VAR
bInitSuccess := FALSE;

IF (__ISVALIDREF(refNewSocket)) THEN
    THIS^.refSocket REF= refNewSocket;
    bInitSuccess := TRUE;
ELSE
THIS^.refSocket REF= __NULL; // Use the correct syntax for null references
END_IF;

FB_init := bInitSuccess;

END_FUNCTION_BLOCK