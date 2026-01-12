FUNCTION_BLOCK PUBLIC FB_CDPlayer
VAR_OUTPUT
	bPlayerActive		: BOOL;
	byVolume			: BYTE;
	byTrack				: UINT;
END_VAR

VAR
    bInitialized : BOOL := FALSE;
END_VAR

IF NOT bInitialized THEN
  bPlayerActive := FALSE;
  byVolume := 0;
  byTrack := 0;
  bInitialized := TRUE;
END_IF

METHOD PUBLIC Start : BOOL
bPlayerActive := TRUE;
RETURN;

METHOD PUBLIC Stop : BOOL
bPlayerActive := FALSE;
RETURN;

METHOD PUBLIC SetTrack : BOOL
VAR_INPUT
 byNewTrack : UINT;
END_VAR
byTrack := byNewTrack;
RETURN;

METHOD PUBLIC SetVolume : BOOL
VAR_INPUT
 byNewVolume : BYTE;
END_VAR
byVolume := byNewVolume;
RETURN;

END_FUNCTION_BLOCK