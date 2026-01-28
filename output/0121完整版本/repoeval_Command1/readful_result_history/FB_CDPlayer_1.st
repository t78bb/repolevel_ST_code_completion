FUNCTION_BLOCK PUBLIC FB_CDPlayer
VAR_OUTPUT
  bPlayerActive		: BOOL;
  byVolume			: BYTE;
  byTrack				: UINT;
END_VAR
VAR
  bInitialized        : BOOL := FALSE;
END_VAR

IF NOT bInitialized THEN
  bPlayerActive := FALSE;
  byVolume := 50; // Default volume level
  byTrack := 1;   // Default track number
  bInitialized := TRUE;
END_IF

CASE bPlayerActive OF
  TRUE: 
    // Player is active, maintain current state
    bPlayerActive := TRUE;
  FALSE:
    // Player is inactive, reset outputs
    byVolume := 0;
    byTrack := 0;
END_CASE;
END_FUNCTION_BLOCK