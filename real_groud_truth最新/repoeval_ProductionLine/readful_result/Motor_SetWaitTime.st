VAR
	WaitTimer:TON;
	InternalSequenceDelay:TIME;
END_VAR

// Assign the input SequenceDelay to the internal variable
InternalSequenceDelay := SequenceDelay;

// Check if the motor is not in a fault state before setting the wait time
IF MotorO.FaultStatus = FALSE THEN
	// Configure the timer with the provided delay
	WaitTimer(IN := TRUE, PT := InternalSequenceDelay);
	
	// If the timer has elapsed, reset the timer and return TRUE
	IF WaitTimer.Q THEN
		WaitTimer(IN := FALSE);
		RETURN TRUE;
	END_IF;
ELSE
	// If the motor is in a fault state, do not set the wait time
	RETURN FALSE;
END_IF;