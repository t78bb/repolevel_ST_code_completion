METHOD TurnOff : BOOL
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

MotorO.Coil := FALSE;
RETURN;
END_OTHER
