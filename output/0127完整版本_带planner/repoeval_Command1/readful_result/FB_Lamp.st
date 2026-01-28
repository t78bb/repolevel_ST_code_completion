FUNCTION_BLOCK PUBLIC FB_Lamp
VAR_OUTPUT
  byLevel			: BYTE;
END_VAR
VAR
  byNewLevel		: BYTE;
END_VAR

IF byNewLevel > 255 THEN
  byLevel := 255;
ELSE
  byLevel := byNewLevel;
END_IF;
END_FUNCTION_BLOCK