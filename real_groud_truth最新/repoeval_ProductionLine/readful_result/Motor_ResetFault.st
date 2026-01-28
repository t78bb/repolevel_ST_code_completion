VAR
	WaitTimer:TON;
	InternalSequenceDelay:TIME;
	ResetDetect:R_TRIG;
END_VAR

// Detect the rising edge of the FaultReset signal
ResetDetect(CLK := MotorI.FaultReset);

// If a reset is detected, clear the fault status
IF ResetDetect.Q THEN
	MotorO.FaultStatus := FALSE;
END_IF;

// Return TRUE to indicate the method executed successfully
ResetFault := TRUE;