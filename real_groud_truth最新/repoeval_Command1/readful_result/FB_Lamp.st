VAR_INPUT
	byNewLevel		: BYTE;
END_VAR

METHOD PUBLIC SetLevel : BOOL
VAR_OUTPUT
	byLevel			: BYTE;
END_VAR
VAR_INPUT
	byNewLevel		: BYTE;
END_VAR

// Implementation of the SetLevel method
byLevel := byNewLevel;
RETURN TRUE;

// Additional functionality for FB_Lamp
METHOD PUBLIC GetLevel : BYTE
// This method returns the current level of the lamp
RETURN byLevel;

METHOD PUBLIC IsOn : BOOL
// This method checks if the lamp is on (level > 0)
IF byLevel > 0 THEN
	RETURN TRUE;
ELSE
	RETURN FALSE;
END_IF;