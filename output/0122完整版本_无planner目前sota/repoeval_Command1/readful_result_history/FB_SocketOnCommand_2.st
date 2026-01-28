FUNCTION_BLOCK PUBLIC FB_SocketOnCommand IMPLEMENTS I_Command
VAR
	refSocket : REFERENCE TO FB_Socket;
END_VAR

METHOD Execute : BOOL
IF __ISVALIDREF(refSocket) THEN
  refSocket.On();
  Execute := TRUE; // Assign return value directly
ELSE
  Execute := FALSE; // Default case for return value
END_IF

RETURN;
END_FUNCTION_BLOCK