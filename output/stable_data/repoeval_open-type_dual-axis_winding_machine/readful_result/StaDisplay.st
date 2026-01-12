VAR
	iTempStatus : INT;
END_VAR

IF iStatus < 0 THEN
	iTempStatus := 0;
ELSE
	iTempStatus := iStatus;
END_IF

CASE iTempStatus OF
	0: 
		Y1 := FALSE;
		Y2 := FALSE;
		Y3 := FALSE;
		Y4 := FALSE;
		Y5 := FALSE;
		Y6 := FALSE;
	1: 
		Y1 := TRUE;
		Y2 := FALSE;
		Y3 := FALSE;
		Y4 := FALSE;
		Y5 := FALSE;
		Y6 := FALSE;
	2: 
		Y1 := FALSE;
		Y2 := TRUE;
		Y3 := FALSE;
		Y4 := FALSE;
		Y5 := FALSE;
		Y6 := FALSE;
	3: 
		Y1 := FALSE;
		Y2 := FALSE;
		Y3 := TRUE;
		Y4 := FALSE;
		Y5 := FALSE;
		Y6 := FALSE;
	4: 
		Y1 := FALSE;
		Y2 := FALSE;
		Y3 := FALSE;
		Y4 := TRUE;
		Y5 := FALSE;
		Y6 := FALSE;
	5: 
		Y1 := FALSE;
		Y2 := FALSE;
		Y3 := FALSE;
		Y4 := FALSE;
		Y5 := TRUE;
		Y6 := FALSE;
	6: 
		Y1 := FALSE;
		Y2 := FALSE;
		Y3 := FALSE;
		Y4 := FALSE;
		Y5 := FALSE;
		Y6 := TRUE;
	ELSE
		Y1 := FALSE;
		Y2 := FALSE;
		Y3 := FALSE;
		Y4 := FALSE;
		Y5 := FALSE;
		Y6 := FALSE;
END_CASE