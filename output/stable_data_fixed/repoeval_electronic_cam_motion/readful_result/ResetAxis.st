FUNCTION_BLOCK ResetAxis
VAR_INPUT 
	bExec	:	BOOL;
END_VAR

VAR_OUTPUT
	bDone	:	BOOL;
	bBusy	:	BOOL;
	bError	:	BOOL;
END_VAR
VAR
	fbReset		:	MC_Reset;
	fbReadStatus:	MC_ReadStatus;
	nState		:	UDINT;
	bAxisError	:	BOOL;
END_VAR

CASE nState OF
	0: (* Idle state *)
		bDone := FALSE;
		bBusy := FALSE;
		bError := FALSE;

		IF bExec THEN
			// Initialize reset function block
			fbReset(Execute := FALSE);
			nState := 1; // Transition to next state
		END_IF;

	1: (* Start reset *)
		bBusy := TRUE;
		fbReset(Execute := TRUE);

		IF fbReset.Done THEN
			fbReset(Execute := FALSE);
			nState := 2; // Transition to next state
		ELSIF fbReset.Error THEN
			bError := TRUE;
			nState := 3; // Transition to error state
		END_IF;

	2: (* Check status *)
		fbReadStatus(Enable := TRUE);

		IF fbReadStatus.Error THEN
			bError := TRUE;
			nState := 3; // Transition to error state
		ELSIF NOT fbReadStatus.Busy THEN
			bDone := TRUE;
			nState := 0; // Return to idle state
		END_IF;

	3: (* Error state *)
		bBusy := FALSE;
		fbReset(Execute := FALSE);
		fbReadStatus(Enable := FALSE);
		nState := 0; // Return to idle state
END_CASE;

END_FUNCTION_BLOCK
