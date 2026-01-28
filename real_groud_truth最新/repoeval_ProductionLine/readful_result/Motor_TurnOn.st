VAR
	WaitTimer:TON;
	InternalSequenceDelay:time;
END_VAR

// Check if the motor is not in a fault state
IF MotorO.FaultStatus = FALSE THEN
	// Start the timer for the internal sequence delay
	WaitTimer(IN:=TRUE, PT:=InternalSequenceDelay);
END_IF

// If the timer has elapsed, turn on the motor coil
IF WaitTimer.Q THEN
	MotorO.Coil := TRUE;
	// Stop the timer
	WaitTimer(IN:=FALSE);
END_IF

// Return the status of the motor coil as the method's result
RETURN MotorO.Coil;