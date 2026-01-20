METHOD TurnOn : BOOL
VAR_INPUT
MotorI:MotorI;
END_VAR
VAR_OUTPUT
MotorO:MotorO;
END_VAR
VAR
WaitTimer:TON;
InternalSequenceDelay:TIME;
END_VAR

// Ensure WaitTimer executes only when necessary
IF MotorO.FaultStatus = FALSE THEN
WaitTimer.IN := TRUE; 
WaitTimer.PT := InternalSequenceDelay; 
WaitTimer(); // Execute the TON function block
END_IF

IF WaitTimer.Q THEN
MotorO.Coil := TRUE;

// Reset the timer only if necessary
IF WaitTimer.IN THEN
 WaitTimer.IN := FALSE; 
 WaitTimer(); // Call TON to reflect the reset state
END_IF
END_IF

RETURN;
END_METHOD