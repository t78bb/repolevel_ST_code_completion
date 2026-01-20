FUNCTION_BLOCK Motor
VAR_INPUT
	MotorI:MotorI;
END_VAR
VAR_OUTPUT
	MotorO:MotorO;
END_VAR
VAR
	WaitTimer: TON;
	InternalSequenceDelay: TIME;
END_VAR

IF MotorI.Overload THEN
	MotorO.FaultStatus := TRUE;
	MotorO.Coil := FALSE;
	RETURN;
END_IF

IF MotorO.FaultStatus = FALSE THEN
	WaitTimer(IN := TRUE, PT := InternalSequenceDelay);
END_IF

IF WaitTimer.Q THEN
	MotorO.Coil := TRUE;
	WaitTimer(IN := FALSE);
END_IF

RETURN;
END_FUNCTION_BLOCK
