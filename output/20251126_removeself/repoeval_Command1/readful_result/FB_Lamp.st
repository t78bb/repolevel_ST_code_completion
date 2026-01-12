METHOD PUBLIC SetLevel : BOOL
VAR_INPUT
	byNewLevel		: BYTE;
END_VAR

byLevel := byNewLevel;
RETURN TRUE;
END_METHOD

METHOD PUBLIC GetLevel : BYTE
VAR_OUTPUT
	byCurrentLevel	: BYTE;
END_VAR

byCurrentLevel := byLevel;
RETURN byCurrentLevel;
END_METHOD

METHOD PUBLIC TurnOff : BOOL
VAR_OUTPUT
	bLampActive		: BOOL;
END_VAR

byLevel := 0;
bLampActive := FALSE;
RETURN TRUE;
END_METHOD

METHOD PUBLIC TurnOn : BOOL
VAR_OUTPUT
	bLampActive		: BOOL;
END_VAR

byLevel := 255; // Default maximum level
bLampActive := TRUE;
RETURN TRUE;
END_METHOD