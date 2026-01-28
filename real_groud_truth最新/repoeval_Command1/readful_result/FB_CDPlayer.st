# Define the methods for the FB_CDPlayer function block

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
	byNewVolume			: BYTE;
END_VAR
VAR_OUTPUT
	bPlayerActive		: BOOL;
	byVolume			: BYTE;
	byTrack				: UINT;
END_VAR

byVolume := byNewVolume;

# The FB_CDPlayer function block now includes methods to start, stop, set the track, and set the volume.