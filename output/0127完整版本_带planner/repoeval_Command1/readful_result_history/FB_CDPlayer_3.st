FUNCTION_BLOCK PUBLIC FB_CDPlayer
VAR_OUTPUT
	bPlayerActive		: BOOL;
	byVolume			: BYTE;
	byTrack				: UINT;
END_VAR
VAR
	bCurrentState		: BOOL;
	byCurrentVolume		: BYTE;
	byCurrentTrack		: UINT;
END_VAR

IF bPlayerActive THEN
// Update outputs to reflect the current state of the CD player
bPlayerActive := TRUE;
byVolume := byVolume;  // Internal state reflects current volume
byTrack := byTrack;    // Internal state reflects current track
ELSE
// If the player is not active, reset outputs
bPlayerActive := FALSE;
byVolume := 0;
byTrack := 0;
END_IF;
END_FUNCTION_BLOCK