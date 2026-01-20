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
		fbReadAxisError1(Enable := TRUE);
		fbReadAxisError2(Enable := TRUE);
		bErrorX := fbReadAxisError1.Error;
		bErrorY := fbReadAxisError2.Error;
		nState := 2;
	2:
		IF bErrorX THEN
			fbReset1(Execute := TRUE);
		END_IF
		IF bErrorY THEN
			fbReset2(Execute := TRUE);
		END_IF
		nState := 3;
	3:
		fbReadStatus1(Enable := TRUE);
		fbReadStatus2(Enable := TRUE);
		IF NOT fbReadStatus1.Busy AND NOT fbReadStatus2.Busy THEN
			Done := TRUE;
			nState := 0;
		END_IF
END_CASE;
END_FUNCTION_BLOCK
