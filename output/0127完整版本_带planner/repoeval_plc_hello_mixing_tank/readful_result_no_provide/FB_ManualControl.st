bMixerRunCmdOut := (bMixerRunCmd OR bMixerRunning) AND NOT bMixerStopCmd;

bMedium1OpenCmdOut := (bMedium1OpenCmd OR bMedium1Opened) AND NOT bMedium1CloseCmd;

bMedium2OpenCmdOut := (bMedium2OpenCmd OR bMedium2Opened) AND NOT bMedium2CloseCmd;

bDrainOpenCmdOut := (bDrainOpenCmd OR bDrainOpened) AND NOT bDrainCloseCmd;
END_FUNCTION_BLOCK
