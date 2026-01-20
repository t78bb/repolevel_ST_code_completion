METHOD SetWaitTime : BOOL
VAR_INPUT
  MotorI:MotorI;
  SequenceDelay:TIME;
END_VAR
VAR_OUTPUT
  MotorO:MotorO;
END_VAR
VAR
  WaitTimer:TON;
  InternalSequenceDelay:TIME;
END_VAR

InternalSequenceDelay := SequenceDelay;

IF MotorO.FaultStatus = FALSE THEN
  // Start the timer when there is no fault
  WaitTimer(IN := TRUE, PT := InternalSequenceDelay);
END_IF

IF WaitTimer.Q THEN
  // Activate MotorO coil when WaitTimer indicates timeout
  MotorO.Coil := TRUE;
  // Reset the timer
  WaitTimer(IN := FALSE);
END_IF

RETURN;
// Replace incorrect keyword "END_OTHER" with "END_METHOD"
END_METHOD