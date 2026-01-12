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
ELSE
	IF MotorI.TurnOnRequest AND NOT MotorO.FaultStatus THEN
		WaitTimer(IN := TRUE, PT := InternalSequenceDelay);
		IF WaitTimer.Q THEN
			MotorO.Coil := TRUE;
			WaitTimer(IN := FALSE);
		END_IF;
	END_IF;

	IF MotorI.TurnOffRequest THEN
		MotorO.Coil := FALSE;
	END_IF;
END_IF;

IF MotorI.SetSequenceDelay THEN
	InternalSequenceDelay := MotorI.SequenceDelay;
END_IF;

END_FUNCTION_BLOCK
