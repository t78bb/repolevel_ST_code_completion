FUNCTION_BLOCK PUBLIC FB_SocketOnCommand IMPLEMENTS I_Command
VAR
    refSocket : REFERENCE TO FB_Socket;
    bCommandValid : BOOL;
END_VAR

VAR_INPUT
    sCommand : STRING;
END_VAR

VAR_OUTPUT
    bSuccess : BOOL;
    sErrorMessage : STRING;
END_VAR

VAR
    bSocketState : BOOL;
END_VAR

// Implementation
IF NOT __ISVALIDREF(refSocket) THEN
  bSuccess := FALSE;
  sErrorMessage := 'Invalid socket reference'; // Invalid socket reference detected.
  RETURN; // Exit function block.
END_IF

// Step 1: Initialize internal state variables
bCommandValid := FALSE;
// Initialization of bSocketState below will overwrite FALSE value later. Consider avoiding redundancy.

// Step 2: Parse the command
IF sCommand = 'ON' THEN
    bCommandValid := TRUE;
    bSocketState := TRUE;
ELSIF sCommand = 'OFF' THEN
    bCommandValid := TRUE;
    bSocketState := FALSE;
ELSE
    bCommandValid := FALSE;
END_IF

// Step 3: Validate command parameters
IF NOT bCommandValid THEN
    bSuccess := FALSE;
    sErrorMessage := 'Invalid command';
    RETURN;
END_IF

// Step 4: Control the socket
IF bSocketState THEN
  refSocket.On(); // Invoking socket turning ON. Ensure this method exists in FB_Socket.
ELSE
  refSocket.Off(); // Invoking socket turning OFF. Ensure this method exists in FB_Socket.
END_IF

// Step 5: Set output status
bSuccess := TRUE;
sErrorMessage := '';

// Step 6: Handle exceptions (already handled in validation steps above)
RETURN;
END_FUNCTION_BLOCK