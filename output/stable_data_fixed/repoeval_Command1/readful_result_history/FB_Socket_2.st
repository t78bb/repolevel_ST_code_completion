FUNCTION_BLOCK PUBLIC FB_Socket
VAR_OUTPUT
 bActive		: BOOL;
END_VAR

METHOD PUBLIC On : BOOL
 // Use intermediary assignments to avoid directly writing to an OUTPUT variable
 On := TRUE;
 bActive := On;

METHOD PUBLIC Off : BOOL
 // Use intermediary assignments to avoid directly writing to an OUTPUT variable
 Off := FALSE;
 bActive := Off;

END_FUNCTION_BLOCK