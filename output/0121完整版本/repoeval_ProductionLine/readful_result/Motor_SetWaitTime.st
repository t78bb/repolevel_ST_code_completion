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
	WaitTimer(IN := TRUE, PT := InternalSequenceDelay);
END_IF

IF WaitTimer.Q THEN
	MotorO.WaitTimeReached := TRUE;
	WaitTimer(IN := FALSE);
	RETURN := TRUE;
ELSE
	MotorO.WaitTimeReached := FALSE;
	RETURN := FALSE;
END_IF
END_OTHER
