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
 bSuccess := FALSE; // Mark the operation as unsuccessful.
 sErrorMessage := 'Invalid socket reference'; // Provide an error message for debugging.
 RETURN; // Exit the function block to avoid further invalid operations.
END_IF

// Step 1: Initialize internal state variables
bCommandValid := FALSE; // State validity flag for the command, starts invalid.

// Step 2: Parse the command
IF sCommand = 'ON' THEN
  bCommandValid := TRUE; // Command recognized as valid for turning ON.
  bSocketState := TRUE;  // Set socket state to ON.
ELSIF sCommand = 'OFF' THEN
  bCommandValid := TRUE; // Command recognized as valid for turning OFF.
  bSocketState := FALSE; // Set socket state to OFF.
ELSE
  bCommandValid := FALSE; // Invalid command received; set validation to FALSE.
END_IF

// Step 3: Validate command parameters
IF NOT bCommandValid THEN
    bSuccess := FALSE;
    sErrorMessage := 'Invalid command';
    RETURN;
END_IF

// Step 4: Control the socket
IF bSocketState THEN
refSocket.On(); // Turns the socket ON correctly. Verify that the 'On' method is implemented in the FB_Socket block.
ELSE
refSocket.Off(); // Turns the socket OFF correctly. Verify that the 'Off' method is implemented in the FB_Socket block.
END_IF

// Step 5: Set output status
bSuccess := TRUE; // Operation completed successfully.
sErrorMessage := ''; // Clear any prior error messages.

// Step 6: Handle exceptions (already handled in validation steps above)
RETURN;
END_FUNCTION_BLOCK