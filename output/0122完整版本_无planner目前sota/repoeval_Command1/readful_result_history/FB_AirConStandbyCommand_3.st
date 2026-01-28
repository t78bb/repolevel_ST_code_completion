FUNCTION_BLOCK PUBLIC FB_AirConStandbyCommand IMPLEMENTS I_Command
VAR
refAirConditioning : REFERENCE TO FB_AirConditioning;
END_VAR

IF __ISVALIDREF(refAirConditioning) THEN
refAirConditioning.bActive := FALSE;
END_IF
// Comment removed to maintain clarity and proper IEC 61131-3 formatting.