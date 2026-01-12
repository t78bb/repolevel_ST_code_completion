FUNCTION_BLOCK PUBLIC FB_Lamp
VAR_OUTPUT
  byLevel			: BYTE;
END_VAR

VAR
  byPreviousLevel	: BYTE;
END_VAR

// Ensure meaningful flow of assignment logic
byPreviousLevel := byLevel;

END_FUNCTION_BLOCK