VAR
	fbReset1	:	MC_Reset;
	fbReset2	:	MC_Reset;
	
	fbReadAxisError1	:	MC_ReadAxisError;
	fbReadAxisError2	:	MC_ReadAxisError;
	
	fbReadStatus1	:	MC_ReadStatus;
	fbReadStatus2	:	MC_ReadStatus;
	
	fbExecTrig	:	R_TRIG;
	nState 		:	BYTE;
	
	bErrorX		:	BOOL;
	bErrorY		:	BOOL;
	
	bResetDoneX	:	BOOL;
	bResetDoneY	:	BOOL;
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
		bErrorX := fbReadAxisError1.ErrorID <> 0;
		bErrorY := fbReadAxisError2.ErrorID <> 0;
		
		IF NOT bErrorX AND NOT bErrorY THEN
			nState := 4;
		ELSE
			nState := 2;
		END_IF

	2:
		fbReset1(Execute := bErrorX);
		fbReset2(Execute := bErrorY);
		bResetDoneX := fbReset1.Done;
		bResetDoneY := fbReset2.Done;

		IF bResetDoneX OR bResetDoneY THEN
			nState := 3;
		END_IF

	3:
		fbReadStatus1(Enable := TRUE);
		fbReadStatus2(Enable := TRUE);

		IF fbReadStatus1.Error OR fbReadStatus2.Error THEN
			nState := 2;
		ELSIF fbReadStatus1.Valid AND fbReadStatus2.Valid THEN
			nState := 4;
		END_IF

	4:
		Done := TRUE;
		nState := 0;
END_CASE
END_FUNCTION_BLOCK
