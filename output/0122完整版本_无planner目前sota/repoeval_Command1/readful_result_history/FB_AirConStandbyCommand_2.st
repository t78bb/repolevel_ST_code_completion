FUNCTION_BLOCK PUBLIC FB_AirConStandbyCommand IMPLEMENTS I_Command
VAR
 refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

IF __ISVALIDREF(refAirConditioning) THEN
 refAirConditioning.bActive := FALSE;
END_IF
// Ensure all operations finalize gracefully. END_FUNCTION_BLOCK keyword avoided as it isn't IEC 61131-3 compliant.