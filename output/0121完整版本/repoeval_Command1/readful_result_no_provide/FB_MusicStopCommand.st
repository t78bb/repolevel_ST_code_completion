VAR
	refCDPlayer : REFERENCE TO FB_CDPlayer;
END_VAR

METHOD Execute
// Removed redundant re-declaration of refCDPlayer to fix the shadowing error.

IF (__ISVALIDREF(THIS^.refCDPlayer)) THEN
  THIS^.refCDPlayer.Stop();
END_IF
END_FUNCTION_BLOCK