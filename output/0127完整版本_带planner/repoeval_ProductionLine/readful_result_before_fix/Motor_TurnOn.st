METHOD TurnOn : BOOL
VAR_INPUT
	MotorI:MotorI;
END_VAR
VAR_OUTPUT
	MotorO:MotorO;
END_VAR
VAR
	WaitTimer: TON;
END_VAR

IF MotorI.FaultStatus THEN
	RETURN := FALSE;
	RETURN;
END_IF;

WaitTimer(IN := TRUE, PT := MotorI.DelayTime);

IF NOT WaitTimer.Q THEN
	RETURN := FALSE;
	RETURN;
END_IF;

MotorO.Coil := TRUE;
RETURN := TRUE;
END_OTHER
