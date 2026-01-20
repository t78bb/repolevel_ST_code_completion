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

IF MotorO.FaultStatus = FALSE THEN
 WaitTimer.IN := TRUE; 
 WaitTimer.PT := InternalSequenceDelay; 
 WaitTimer(); // Execute the TON function block
END_IF

IF WaitTimer.Q THEN
 MotorO.Coil := TRUE;
 WaitTimer.IN := FALSE; 
 WaitTimer(); // Execute the TON function block after modifying IN
END_IF

RETURN;
END_METHOD