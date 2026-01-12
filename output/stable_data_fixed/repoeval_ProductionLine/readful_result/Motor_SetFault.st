VAR
	WaitTimer:TON;
	InternalSequenceDelay:TIME;
END_VAR

IF MotorI.Overload THEN
	MotorO.FaultStatus := TRUE;
	MotorO.Coil := FALSE;
	RETURN := TRUE;
ELSE
	RETURN := FALSE;
END_IF;