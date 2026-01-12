FUNCTION_BLOCK PUBLIC FB_Lamp
VAR_OUTPUT
	byLevel			: BYTE;
END_VAR

VAR
	byPreviousLevel	: BYTE;
END_VAR

byPreviousLevel := byLevel;
byLevel := byPreviousLevel;

END_FUNCTION_BLOCK
