FUNCTION_BLOCK PUBLIC FB_Lamp
VAR_OUTPUT
  byLevel			: BYTE;
END_VAR
VAR
  byCurrentLevel : BYTE := 0;
END_VAR

METHOD UpdateLevel : VOID
IF byCurrentLevel <> byLevel THEN
  byCurrentLevel := byLevel;
END_IF
END_METHOD
END_FUNCTION_BLOCK