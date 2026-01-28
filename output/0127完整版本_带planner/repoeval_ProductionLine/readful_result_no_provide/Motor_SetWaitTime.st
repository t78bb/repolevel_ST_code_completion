VAR
	IsValidDelay: BOOL;
END_VAR

// Step 1: Check if SequenceDelay is a valid time value (non-negative)
IsValidDelay := SequenceDelay >= T#0ms;

// Step 2: Update MotorI.WaitTime if SequenceDelay is valid
IF IsValidDelay THEN
	MotorI.WaitTime := SequenceDelay;
END_IF;

// Step 3: Copy updated MotorI to MotorO
MotorO := MotorI;

// Step 4: Return success flag
RETURN TRUE;
END_OTHER
