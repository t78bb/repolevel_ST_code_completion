FUNCTION_BLOCK ResetAxis
VAR_INPUT 
	bExec	:	BOOL;
END_VAR
VAR
	fbReset1	:	MC_Reset;
	fbReset2	:	MC_Reset;
	
	fbReadAxisError1	:	MC_ReadAxisError;
	fbReadAxisError2	:	MC_ReadAxisError;
	
	fbReadStatus1	:	MC_ReadStatus;
	fbReadStatus2	:	MC_ReadStatus;
	
	fbExecTrig	:	R_TRIG;
	nState 	:	BYTE;
	
	bErrorX	:	BOOL;
	bErrorY	:	BOOL;
	
END_VAR

VAR_OUTPUT 
	Done	:	BOOL;
END_VAR

fbExecTrig(CLK := bExec);

CASE nState OF 
	0:
		IF fbExecTrig.Q THEN
			nState := 1;
			Done := FALSE;
		END_IF
	1:
		fbReadAxisError1(Execute := TRUE);
		fbReadAxisError2(Execute := TRUE);
		
		bErrorX := fbReadAxisError1.Error;
		bErrorY := fbReadAxisError2.Error;
		
		IF NOT bErrorX AND NOT bErrorY THEN
			nState := 3;
		ELSE
			nState := 2;
		END_IF
	2:
		fbReset1(Execute := bErrorX);
		fbReset2(Execute := bErrorY);
		
		IF fbReset1.Done AND fbReset2.Done THEN
			nState := 3;
		END_IF
	3:
		fbReadStatus1(Execute := TRUE);
		fbReadStatus2(Execute := TRUE);
		
		IF fbReadStatus1.Error OR fbReadStatus2.Error THEN
			nState := 2;
		ELSE
			Done := TRUE;
			nState := 0;
		END_IF
END_CASE
END_FUNCTION_BLOCK
