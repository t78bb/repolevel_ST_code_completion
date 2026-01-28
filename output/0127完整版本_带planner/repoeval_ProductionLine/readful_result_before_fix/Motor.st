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

IF MotorI.liga THEN
	TurnOn();
END_IF;

IF MotorI.desliga THEN
	TurnOff();
END_IF;

IF MotorI.settime THEN
	SetWaitTime(SequenceDelay := MotorI.timetemp);
END_IF;

IF MotorI.setfault THEN
	SetFault();
END_IF;

IF MotorI.reset THEN
	MotorO.FaultStatus := FALSE;
	WaitTimer(IN := FALSE);
END_IF;
END_FUNCTION_BLOCK
