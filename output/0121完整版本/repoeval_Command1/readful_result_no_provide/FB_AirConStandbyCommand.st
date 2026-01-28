FUNCTION_BLOCK FB_AirConStandbyCommand IMPLEMENTS I_Command
VAR
  refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

IF __ISVALIDREF(refAirConditioning) THEN
  refAirConditioning.bActive := FALSE;
END_IF
END_FB