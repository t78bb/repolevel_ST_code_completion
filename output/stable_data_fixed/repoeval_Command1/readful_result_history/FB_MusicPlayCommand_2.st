FUNCTION_BLOCK PUBLIC FB_MusicPlayCommand IMPLEMENTS I_Command

VAR
    refCDPlayer : REFERENCE TO FB_CDPlayer;
END_VAR

METHOD Execute

IF NOT __ISVALIDREF(THIS^.refCDPlayer) THEN
  // Add appropriate error handling for invalid reference.
  RETURN;
END_IF

THIS^.refCDPlayer.SetVolume(40);
THIS^.refCDPlayer.SetTrack(1);
THIS^.refCDPlayer.Start();

END_FUNCTION_BLOCK