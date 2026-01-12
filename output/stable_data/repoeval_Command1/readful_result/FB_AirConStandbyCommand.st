VAR
	refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

VAR_INPUT
	bInitRetains : BOOL; // if TRUE, the retain variables are initialized (warm start / cold start)
	bInCopyCode : BOOL;  // if TRUE, the instance afterwards gets moved into the copy code (online change)
	refNewAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

VAR_OUTPUT
	bCommandExecuted : BOOL;
END_VAR

VAR
	bIsValidReference : BOOL;
END_VAR

IF (__ISVALIDREF(refNewAirConditioning)) THEN
	THIS^.refAirConditioning REF= refNewAirConditioning;
	bIsValidReference := TRUE;
ELSE
	THIS^.refAirConditioning REF= 0;
	bIsValidReference := FALSE;
END_IF

IF bIsValidReference AND __ISVALIDREF(refAirConditioning) THEN
	refAirConditioning^.bActive := FALSE; // Set air conditioning to standby mode
	bCommandExecuted := TRUE;
ELSE
	bCommandExecuted := FALSE;
END_IF