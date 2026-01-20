FUNCTION_BLOCK FB_Wrapper
VAR_INPUT
	in:BOOL;
END_VAR
VAR_OUTPUT
	out:BOOL;
END_VAR
VAR
	fb_teste: ARRAY [1..3] OF FB_Teste;
	index: INT;
END_VAR

FOR index := 1 TO 3 DO
  // Set individual delay times based on the index for each FB_Teste instance
  CASE index OF
    1: fb_teste[index].SetTempo(delay := T#4S);
    2: fb_teste[index].SetTempo(delay := T#1S);
    3: fb_teste[index].SetTempo(delay := T#2S);
  END_CASE;

  // Check the input and activate or deactivate the function block
  IF in THEN
    fb_teste[index].mLiga();
  ELSE
    fb_teste[index].mDesliga();
  END_IF;
END_FOR;

out := FALSE;
FOR index := 1 TO 3 DO
  // Check the output of each FB_Teste instance
  IF fb_teste[index].saida THEN
    out := TRUE;
    EXIT;
  END_IF;
END_FOR;
END_FUNCTION_BLOCK