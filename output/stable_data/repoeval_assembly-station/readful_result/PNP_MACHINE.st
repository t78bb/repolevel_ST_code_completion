VAR
	prevBaseClamped: BOOL := FALSE;
	prevLidClamped: BOOL := FALSE;
END_VAR

IF Reset THEN
	LidPicked := FALSE;
	LidPlaced := FALSE;
	prevBaseClamped := FALSE;
	prevLidClamped := FALSE;
	RETURN;
END_IF

IF NOT prevLidClamped AND LidClamped THEN
	LidPicked := TRUE;
ELSE
	LidPicked := FALSE;
END_IF

IF prevBaseClamped AND NOT BaseClamped THEN
	LidPlaced := TRUE;
ELSE
	LidPlaced := FALSE;
END_IF

prevBaseClamped := BaseClamped;
prevLidClamped := LidClamped;