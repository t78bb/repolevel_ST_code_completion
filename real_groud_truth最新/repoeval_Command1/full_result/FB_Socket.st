FUNCTION_BLOCK PUBLIC FB_Socket
VAR_OUTPUT
	bActive		: BOOL;
END_VAR

METHOD PUBLIC On
VAR_OUTPUT
	bActive : BOOL;
END_VAR

// Set the socket to active
bActive := TRUE;

METHOD PUBLIC Off
VAR_OUTPUT
	bActive : BOOL;
END_VAR

// Set the socket to inactive
bActive := FALSE;

FUNCTION_BLOCK PUBLIC FB_SocketOnCommand IMPLEMENTS I_Command
VAR
	refSocket : REFERENCE TO FB_Socket;
END_VAR

METHOD PUBLIC Execute
// Turn the socket on by calling the On method
refSocket.On();

FUNCTION_BLOCK PUBLIC FB_SocketOffCommand IMPLEMENTS I_Command
VAR
	refSocket : REFERENCE TO FB_Socket;
END_VAR

METHOD PUBLIC Execute
// Turn the socket off by calling the Off method
refSocket.Off();

FUNCTION_BLOCK PUBLIC FB_Lamp
VAR_OUTPUT
	byLevel : BYTE; // Represents the brightness level of the lamp
END_VAR

METHOD PUBLIC SetLevel
VAR_INPUT
	iLevel : BYTE; // Input level to set the lamp brightness
END_VAR

// Set the brightness level of the lamp
byLevel := iLevel;

METHOD PUBLIC GetLevel
VAR_OUTPUT
	byLevel : BYTE; // Output the current brightness level
END_VAR

// Return the current brightness level
byLevel := byLevel;
END_FUNCTION_BLOCK