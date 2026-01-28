VAR
	OperationSuccessful: BOOL;
END_VAR

OperationSuccessful := FALSE;

IF MotorI.AllowTurnOff THEN
	MotorO.Coil := FALSE;
	MotorO.Status := 'Off';
	OperationSuccessful := TRUE;
END_IF;

TurnOff := OperationSuccessful;
RETURN;
END_OTHER
