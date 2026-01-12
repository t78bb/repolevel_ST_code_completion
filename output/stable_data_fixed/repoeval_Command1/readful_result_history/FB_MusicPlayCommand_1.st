FUNCTION_BLOCK PUBLIC FB_MusicPlayCommand IMPLEMENTS I_Command

VAR
    refCDPlayer : REFERENCE TO FB_CDPlayer;
END_VAR

METHOD Execute

IF (__ISVALIDREF(THIS^.refCDPlayer)) THEN
  THIS^.refCDPlayer.SetVolume(40);
  THIS^.refCDPlayer.SetTrack(1);
  THIS^.refCDPlayer.Start();
END_IF

END_FUNCTION_BLOCK