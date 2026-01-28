FUNCTION_BLOCK PUBLIC FB_MusicStopCommand IMPLEMENTS I_Command
VAR
    isCommandValid : BOOL;
    isStopSuccessful : BOOL;
END_VAR

IF __ISVALIDREF(THIS^.refCDPlayer) THEN
    isCommandValid := TRUE;
ELSE
    isCommandValid := FALSE;
END_IF;

IF isCommandValid THEN
    IF (THIS^.refCDPlayer.State = CDPlayerState.Playing) OR (THIS^.refCDPlayer.State = CDPlayerState.Paused) THEN
        THIS^.refCDPlayer.Stop();
        isStopSuccessful := (THIS^.refCDPlayer.State = CDPlayerState.Stopped);
        
        IF isStopSuccessful THEN
            // Update internal state to reflect the stop operation
            // (Assuming there is an internal state variable to update)
        ELSE
            // Handle stop failure
            // (Set error flag or status information as needed)
        END_IF;
    END_IF;
END_IF;
END_FUNCTION_BLOCK
