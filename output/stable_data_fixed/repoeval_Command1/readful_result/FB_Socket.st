FUNCTION_BLOCK PUBLIC FB_Socket
VAR_OUTPUT
bActive		: BOOL;
END_VAR

METHOD PUBLIC On : BOOL
// Reflect the output after assigning the return value
On := TRUE;
bActive := TRUE;

METHOD PUBLIC Off : BOOL
// Reflect the output after assigning the return value
Off := FALSE;
bActive := FALSE;

END_FUNCTION_BLOCK