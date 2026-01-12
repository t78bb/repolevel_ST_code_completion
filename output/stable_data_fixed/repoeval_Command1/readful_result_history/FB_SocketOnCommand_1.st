FUNCTION_BLOCK PUBLIC FB_SocketOnCommand IMPLEMENTS I_Command

VAR
    refSocket : REFERENCE TO FB_Socket;
END_VAR

METHOD Execute
VAR
END_VAR
IF (__ISVALIDREF(THIS^.refSocket)) THEN
  // Ensure safety by validating the reference before method call
  THIS^.refSocket^ .On();
END_IF

END_FUNCTION_BLOCK