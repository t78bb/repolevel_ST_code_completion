FUNCTION_BLOCK PUBLIC FB_AirConStandbyCommand IMPLEMENTS I_Command
VAR
  refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

IF __ISVALIDREF(refAirConditioning) THEN
  refAirConditioning.bActive := FALSE;
END_IF
// Removed END_FUNCTION_BLOCK as it does not follow Codesys syntax conventions.