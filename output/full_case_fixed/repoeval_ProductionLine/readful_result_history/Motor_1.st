FUNCTION_BLOCK Motor
VAR_INPUT
	MotorI:MotorI;
END_VAR
VAR_OUTPUT
	MotorO:MotorO;
END_VAR
VAR
	WaitTimer: TON;
	InternalSequenceDelay: TIME;
END_VAR

IF MotorI.Overload THEN
	MotorO.FaultStatus := TRUE;
	MotorO.Coil := FALSE;
	RETURN;
END_IF

IF MotorO.FaultStatus = FALSE THEN
WaitTimer.IN := TRUE; // Setting the 'IN' input for the TON block instance.
  WaitTimer.PT := InternalSequenceDelay; // Setting the 'PT' (preset time) input for the TON block instance.
  WaitTimer(); // Executing the TON instance.
END_IF

IF WaitTimer.Q THEN
	MotorO.Coil := TRUE;
WaitTimer.IN := FALSE; // Resetting the 'IN' input for the TON block instance.
  WaitTimer(); // Executing the TON instance to ensure state updates.
END_IF

RETURN;
END_FUNCTION_BLOCK