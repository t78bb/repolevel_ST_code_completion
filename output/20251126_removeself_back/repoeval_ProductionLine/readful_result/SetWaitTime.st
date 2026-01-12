VAR
	WaitTimer:TON;
	InternalSequenceDelay:TIME;
END_VAR

// Assign the input sequence delay to the internal variable
InternalSequenceDelay := SequenceDelay;

// Initialize the timer with the internal sequence delay
WaitTimer(IN := TRUE, PT := InternalSequenceDelay);

// Check if the timer has elapsed
IF WaitTimer.Q THEN
	// Perform actions when the wait time has elapsed
	MotorO.Coil := TRUE;
	WaitTimer(IN := FALSE); // Reset the timer
	RETURN TRUE; // Indicate successful completion
ELSE
	// Actions to perform while waiting
	MotorO.Coil := FALSE;
	RETURN FALSE; // Indicate that the wait time has not yet elapsed
END_IF