METHOD ResetFault : BOOL
VAR_INPUT
	MotorI:MotorI;
END_VAR
VAR_OUTPUT
	MotorO:MotorO;
END_VAR
VAR
	ResetDetect: R_TRIG;
	ResetSuccessful: BOOL;
END_VAR

ResetDetect(CLK := MotorI.ResetSignal);

IF ResetDetect.Q THEN
	MotorO.FaultStatus := FALSE;
	MotorO.OperationStatus := READY; // Assuming READY is the default operation status
	ResetSuccessful := TRUE;
ELSE
	ResetSuccessful := FALSE;
END_IF;

ResetFault := ResetSuccessful;
RETURN;
END_OTHER
