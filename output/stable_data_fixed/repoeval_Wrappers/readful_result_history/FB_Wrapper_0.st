FUNCTION_BLOCK FB_Wrapper
VAR_INPUT
	in:BOOL;
END_VAR
VAR_OUTPUT
	out:BOOL;
END_VAR

VAR
	index: INT;
	fb_teste: ARRAY [1..3] OF FB_Teste;
END_VAR

FOR index := 1 TO 3 DO
	fb_teste[index].entrada := in;
	out := fb_teste[index].saida;
END_FOR;

END_FUNCTION_BLOCK
