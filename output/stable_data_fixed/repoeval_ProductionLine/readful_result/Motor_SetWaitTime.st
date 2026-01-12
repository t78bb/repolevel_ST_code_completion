VAR
	WaitTimer:TON;
	InternalSequenceDelay:TIME;
END_VAR

InternalSequenceDelay := SequenceDelay;
WaitTimer(IN := TRUE, PT := InternalSequenceDelay);

IF WaitTimer.Q THEN
	MotorO.WaitTimeSet := TRUE;
	WaitTimer(IN := FALSE);
	RETURN := TRUE;
ELSE
	MotorO.WaitTimeSet := FALSE;
	RETURN := FALSE;
END_IF;