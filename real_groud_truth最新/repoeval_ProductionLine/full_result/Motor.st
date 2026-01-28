FUNCTION_BLOCK Motor
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

METHOD TurnOn : BOOL
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

IF MotorO.FaultStatus = FALSE THEN
	WaitTimer(IN:=TRUE, PT:=InternalSequenceDelay);
END_IF

IF WaitTimer.Q THEN
	MotorO.Coil := TRUE;
	WaitTimer(IN := FALSE);
END_IF

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

METHOD SetFault : BOOL
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

IF MotorI.Overload THEN
	MotorO.FaultStatus := TRUE;
	TurnOff();
END_IF

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

PROGRAM PLC_PRG
VAR
	Motor:Motor;
	MotorInputs:MotorI;
	MotorOutputs:MotorO;
	liga: BOOL;
	desliga: BOOL;
	settime: BOOL;
	setfault: BOOL;
	reset: BOOL;
	timetemp: TIME;
END_VAR

Motor(MotorI := MotorInputs, MotorO => MotorOutputs);

IF liga THEN
	Motor.TurnOn();
	liga := FALSE;
END_IF

IF desliga THEN
	Motor.TurnOff();
	desliga := FALSE;
END_IF

IF settime THEN
	Motor.SetWaitTime(SequenceDelay := timetemp);
	settime := FALSE;
END_IF

IF setfault THEN
	Motor.SetFault();
	setfault := FALSE;
END_IF

IF reset THEN
	MotorO.FaultStatus := FALSE;
	reset := FALSE;
END_IF
END_FUNCTION_BLOCK