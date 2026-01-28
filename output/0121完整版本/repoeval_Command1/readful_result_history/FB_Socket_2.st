FUNCTION_BLOCK PUBLIC FB_Socket
VAR_OUTPUT
  bActive		: BOOL;
END_VAR
VAR
  bInitialized : BOOL := FALSE;
END_VAR

IF NOT bInitialized THEN
  bActive := FALSE;
  bInitialized := TRUE;
END_IF
END_FUNCTION_BLOCK