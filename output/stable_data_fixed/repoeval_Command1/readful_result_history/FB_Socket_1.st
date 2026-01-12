FUNCTION_BLOCK PUBLIC FB_Socket
VAR_OUTPUT
  bActive		: BOOL;
END_VAR

METHOD PUBLIC On : BOOL
  bActive := TRUE;
  On := bActive;

METHOD PUBLIC Off : BOOL
  bActive := FALSE;
  Off := bActive;

END_FUNCTION_BLOCK