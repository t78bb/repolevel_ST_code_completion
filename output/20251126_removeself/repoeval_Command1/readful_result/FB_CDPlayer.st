METHOD PUBLIC Start
VAR_OUTPUT
	bPlayerActive		: BOOL;
	byVolume			: BYTE;
	byTrack				: UINT;
END_VAR

bPlayerActive := TRUE;

METHOD PUBLIC Stop
VAR_OUTPUT
	bPlayerActive		: BOOL;
	byVolume			: BYTE;
	byTrack				: UINT;
END_VAR

bPlayerActive := FALSE;

METHOD PUBLIC SetTrack : BOOL
VAR_INPUT
	byNewTrack			: UINT;
END_VAR
VAR_OUTPUT
	bPlayerActive		: BOOL;
	byVolume			: BYTE;
	byTrack				: UINT;
END_VAR

byTrack := byNewTrack;

METHOD PUBLIC SetVolume : BOOL
VAR_INPUT
	byNewVolume 		: BYTE;
END_VAR
VAR_OUTPUT
	bPlayerActive		: BOOL;
	byVolume			: BYTE;
	byTrack				: UINT;
END_VAR

byVolume := byNewVolume;

FUNCTION_BLOCK PUBLIC FB_Lamp
VAR_OUTPUT
	byLevel			: BYTE;
END_VAR

METHOD PUBLIC SetLevel : BOOL
VAR_INPUT
	byNewLevel			: BYTE;
END_VAR
VAR_OUTPUT
	byLevel				: BYTE;
END_VAR

byLevel := byNewLevel;