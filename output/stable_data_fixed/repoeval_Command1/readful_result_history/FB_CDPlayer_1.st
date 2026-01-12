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
VAR
    bSuccess : BOOL;
END_VAR
bPlayerActive := TRUE;
bSuccess := TRUE;
RETURN bSuccess;

METHOD PUBLIC Stop : BOOL
VAR
    bSuccess : BOOL;
END_VAR
bPlayerActive := FALSE;
bSuccess := TRUE;
RETURN bSuccess;

METHOD PUBLIC SetTrack : BOOL
VAR_INPUT
    byNewTrack : UINT;
END_VAR
VAR
    bSuccess : BOOL;
END_VAR
byTrack := byNewTrack;
bSuccess := TRUE;
RETURN bSuccess;

METHOD PUBLIC SetVolume : BOOL
VAR_INPUT
    byNewVolume : BYTE;
END_VAR
VAR
    bSuccess : BOOL;
END_VAR
byVolume := byNewVolume;
bSuccess := TRUE;
RETURN bSuccess;

END_FUNCTION_BLOCK