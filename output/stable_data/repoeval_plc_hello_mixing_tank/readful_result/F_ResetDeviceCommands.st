VAR
	bAllCommandsReset : BOOL;
END_VAR

// Reset all HMI command flags if the corresponding device state indicates the action is complete
bMixerRunCmd := FALSE;
bMixerStopCmd := FALSE;

IF bMedium1Opened THEN
	bMedium1OpenCmd := FALSE;
	bMedium1CloseCmd := FALSE;
END_IF;

IF bMedium2Opened THEN
	bMedium2OpenCmd := FALSE;
	bMedium2CloseCmd := FALSE;
END_IF;

IF bDrainOpened THEN
	bDrainOpenCmd := FALSE;
	bDrainCloseCmd := FALSE;
END_IF;

// Check if all commands have been reset
bAllCommandsReset := NOT (bMixerRunCmd OR bMixerStopCmd OR bMedium1OpenCmd OR bMedium1CloseCmd OR bMedium2OpenCmd OR bMedium2CloseCmd OR bDrainOpenCmd OR bDrainCloseCmd);

F_ResetDeviceCommands := bAllCommandsReset;
RETURN;