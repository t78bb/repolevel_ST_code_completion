FUNCTION_BLOCK PUBLIC FB_MusicStopCommand IMPLEMENTS I_Command
VAR
	refCDPlayer : REFERENCE TO FB_CDPlayer;
END_VAR

METHOD Execute

IF (__ISVALIDREF(THIS^.refCDPlayer)) THEN
 IF THIS^.refCDPlayer <> 0 THEN // Ensure refCDPlayer is assigned
  THIS^.refCDPlayer.Stop();
 END_IF;
END_IF
END_FUNCTION_BLOCK