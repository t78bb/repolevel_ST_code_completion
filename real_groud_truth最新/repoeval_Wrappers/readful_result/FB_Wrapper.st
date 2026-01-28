VAR
    fb_teste: ARRAY [1..3] OF FB_Teste;
    index: INT;
END_VAR

METHOD Map : BOOL
VAR_INPUT
    in: BOOL;
END_VAR
VAR_OUTPUT
    out: BOOL;
END_VAR
VAR
    index: INT;
END_VAR

FOR index := 1 TO 3 DO
    fb_teste[index].entrada := in;
    out := fb_teste[index].saida;
END_FOR

METHOD mLiga : BOOL
VAR_INPUT
    entrada: BOOL;
END_VAR
VAR_OUTPUT
    saida: BOOL;
END_VAR
VAR
    Timer: ton;
    tempo: TIME;
END_VAR

Timer(IN := TRUE, PT := tempo);

IF Timer.Q THEN
    saida := TRUE;
    Timer(IN := FALSE);
END_IF

METHOD mDesliga : BOOL
VAR_INPUT
    entrada: BOOL;
END_VAR
VAR_OUTPUT
    saida: BOOL;
END_VAR
VAR
    Timer: ton;
    tempo: TIME;
END_VAR

saida := FALSE;
Timer(IN := FALSE);

END_FUNCTION_BLOCK