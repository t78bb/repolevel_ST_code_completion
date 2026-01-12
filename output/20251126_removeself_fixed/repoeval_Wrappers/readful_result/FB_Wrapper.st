FUNCTION_BLOCK FB_Wrapper
VAR_INPUT
	in:BOOL;
END_VAR
VAR_OUTPUT
	out:BOOL;
END_VAR

VAR
    fb_teste: FB_Teste; // Verify FB_Teste is defined in the Codesys project or libraries
    fb_taste_mLiga: FB_Taste_mLiga; // Verify FB_Taste_mLiga exists and is valid
    fb_taste_mDesliga: FB_Taste_mDesliga; // Verify FB_Taste_mDesliga exists and is valid
    state: BOOL; // Correctly declared BOOL variable
END_VAR

METHOD Map : BOOL
VAR
    index: INT;
    fb_teste_array: ARRAY [1..3] OF FB_Teste; // Correctly declared array of FB_Teste function blocks
END_VAR

FOR index := 1 TO 3 DO
    fb_teste_array[index].entrada := in; // Assuming "entrada" is a valid input of FB_Teste
    out := fb_teste_array[index].saida;  // Assuming "saida" is a valid output of FB_Teste
END_FOR;
RETURN out; // Return output
END_METHOD

METHOD Execute : BOOL
VAR
    result: BOOL; // Ensure "result" is properly declared for storing operation outcome
END_VAR

IF in THEN
    result := fb_taste_mLiga(entrada := in); // Assuming "entrada" is a valid input of fb_taste_mLiga
    state := result; // Assign to state
ELSE
    result := fb_taste_mDesliga(entrada := in); // Assuming "entrada" is a valid input of fb_taste_mDesliga
    state := result; // Assign to state
END_IF

out := state; // Output result through "out"
RETURN out; // Return final result
END_METHOD

END_FUNCTION_BLOCK