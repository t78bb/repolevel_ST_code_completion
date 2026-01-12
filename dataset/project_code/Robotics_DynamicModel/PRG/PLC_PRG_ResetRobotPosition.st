METHOD PRIVATE ResetRobotPosition : BOOL

setPosition.Position := start;
setPosition.CoordSystem := SMC_COORD_SYSTEM.ACS;
setPosition.Execute := TRUE;

IF setPosition.Done THEN
	setPosition.Execute := FALSE;
END_IF

ResetRobotPosition := setPosition.Done;