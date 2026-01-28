VAR
	success		:BOOL;
BEGIN
	// Initialize success to FALSE
	success := FALSE;

	// Check the direction and set the button state accordingly
	CASE direct OF
		TargetDirect.extend:
			CASE level OF
				1: // 地轨
					gController.grd[idx].extendButton := TRUE;
					gController.grd[idx].retractButton := FALSE;
					success := TRUE;
				2: // 天轨
					gController.sky[idx].extendButton := TRUE;
					gController.sky[idx].retractButton := FALSE;
					success := TRUE;
			END_CASE;
		TargetDirect.retract:
			CASE level OF
				1: // 地轨
					gController.grd[idx].extendButton := FALSE;
					gController.grd[idx].retractButton := TRUE;
					success := TRUE;
				2: // 天轨
					gController.sky[idx].extendButton := FALSE;
					gController.sky[idx].retractButton := TRUE;
					success := TRUE;
			END_CASE;
	END_CASE;

	// Return the success status
	setButtonByDirect := success;
END_FUNCTION