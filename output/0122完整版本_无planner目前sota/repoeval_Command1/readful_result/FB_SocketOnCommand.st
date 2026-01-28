FUNCTION_BLOCK PUBLIC FB_SocketOnCommand IMPLEMENTS I_Command
VAR
	refSocket : REFERENCE TO FB_Socket;
END_VAR

METHOD Execute : BOOL
IF __ISVALIDREF(refSocket) THEN
 refSocket.On();
 Execute := TRUE; // Last value of Execute is managed here
ELSE
 Execute := FALSE; // Default case for Execute
END_IF
END_METHOD // No explicit RETURN needed for METHOD
END_FUNCTION_BLOCK