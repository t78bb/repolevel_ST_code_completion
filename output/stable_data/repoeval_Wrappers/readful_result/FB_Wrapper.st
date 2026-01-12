VAR
	index: INT;
	fb_teste: ARRAY [1..3] OF FB_Teste;
END_VAR

FOR index := 1 TO 3 DO
	fb_teste[index].entrada := in;
	out := fb_teste[index].saida;
END_FOR;