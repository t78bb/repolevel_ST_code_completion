VAR
    bInitialized : BOOL := FALSE;
END_VAR

IF NOT bInitialized THEN
  bPlayerActive := FALSE;
  byVolume := 50; // Default volume level
  byTrack := 1;   // Default track number
  bInitialized := TRUE;
END_IF

IF bPlayerActive THEN
  // Logic for active player state can be implemented here
END_IF

END_FUNCTION_BLOCK