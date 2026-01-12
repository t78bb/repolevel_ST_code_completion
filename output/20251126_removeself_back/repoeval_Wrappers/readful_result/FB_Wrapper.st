VAR
    fb_teste: FB_Teste;
    fb_taste_mLiga: FB_Taste_mLiga;
    fb_taste_mDesliga: FB_Taste_mDesliga;
    state: BOOL;
END_VAR

METHOD Map : BOOL
VAR
    index: INT;
    fb_teste_array: ARRAY [1..3] OF FB_Teste;
END_VAR

FOR index := 1 TO 3 DO
    fb_teste_array[index].entrada := in;
    out := fb_teste_array[index].saida;
END_FOR

METHOD Execute : BOOL
VAR
    result: BOOL;
END_VAR

IF in THEN
    result := fb_taste_mLiga(entrada := in);
    state := result;
ELSE
    result := fb_taste_mDesliga(entrada := in);
    state := result;
END_IF

out := state;
RETURN out;

END_FUNCTION_BLOCK