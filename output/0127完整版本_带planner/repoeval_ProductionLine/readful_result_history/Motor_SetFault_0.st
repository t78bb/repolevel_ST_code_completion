METHOD SetFault : BOOL
VAR_INPUT
	MotorI:MotorI;
END_VAR
VAR_OUTPUT
	MotorO:MotorO;
END_VAR
VAR
	OverloadDetected: BOOL;
END_VAR

OverloadDetected := MotorI.Overload;

IF OverloadDetected THEN
	MotorO.FaultStatus := TRUE;
	MotorO.Coil := FALSE; // Turn off the motor
	SetFault := TRUE; // Fault successfully handled
ELSE
	SetFault := FALSE; // No fault detected
END_IF;
END_OTHER
