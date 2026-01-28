VAR
    refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR
VAR_INPUT
    bInitRetains : BOOL; // if TRUE, the retain variables are initialized (warm start / cold start)
    bInCopyCode : BOOL;  // if TRUE, the instance afterwards gets moved into the copy code (online change)
    refNewAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

IF (__ISVALIDREF(refNewAirConditioning)) THEN
    THIS^.refAirConditioning REF= refNewAirConditioning;
ELSE
    THIS^.refAirConditioning REF= 0;
END_IF

METHOD PUBLIC Execute : BOOL
VAR_OUTPUT
    bSuccess : BOOL;
END_VAR

IF (__ISVALIDREF(refAirConditioning)) THEN
    refAirConditioning^.bActive := FALSE; // Set air conditioning to standby mode
    bSuccess := TRUE;
ELSE
    bSuccess := FALSE; // Command failed due to invalid reference
END_IF

RETURN bSuccess;