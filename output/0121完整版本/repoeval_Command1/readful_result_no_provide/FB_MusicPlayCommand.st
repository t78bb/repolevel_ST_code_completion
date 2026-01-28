VAR
    refCDPlayer : REFERENCE TO FB_CDPlayer;
END_VAR

METHOD Execute
VAR
END_VAR

IF (__ISVALIDREF(refCDPlayer)) THEN
  refCDPlayer.SetVolume(40);
  refCDPlayer.SetTrack(1);
  refCDPlayer.Start();
END_IF
END_FUNCTION_BLOCK