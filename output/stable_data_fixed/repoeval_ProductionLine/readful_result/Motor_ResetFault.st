VAR
	ResetDetect: r_trig;
END_VAR

ResetDetect(CLK := MotorI.FaultReset);

IF ResetDetect.Q THEN
	MotorO.FaultStatus := FALSE;
	ResetFault := TRUE;
ELSE
	ResetFault := FALSE;
END_IF;