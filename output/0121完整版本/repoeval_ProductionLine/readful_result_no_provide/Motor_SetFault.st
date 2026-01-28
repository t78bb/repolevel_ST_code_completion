VAR
	WaitTimer:TON;
	InternalSequenceDelay:TIME;
END_VAR

IF MotorI.Overload THEN
	MotorO.FaultStatus := TRUE;
	MotorO.Coil := FALSE;
END_IF
END_OTHER
