FUNCTION_BLOCK PUBLIC FB_MusicPlayCommand IMPLEMENTS I_Command
VAR
	refCDPlayer : REFERENCE TO FB_CDPlayer;
END_VAR

METHOD Execute

IF (__ISVALIDREF(THIS^.refCDPlayer)) THEN
 // Ensure that the referenced object is valid and initialized
 THIS^.refCDPlayer.SetVolume(40);
 THIS^.refCDPlayer.SetTrack(1);
 THIS^.refCDPlayer.Start();
ELSE
 // Handle invalid reference case
 (* Add error handling logic or ensure initialization externally *)
END_IF
END_FUNCTION_BLOCK