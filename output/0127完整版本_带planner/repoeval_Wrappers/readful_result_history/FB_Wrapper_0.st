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
	delay_times: ARRAY [1..3] OF TIME := [T#4S, T#1S, T#2S];
	output_states: ARRAY [1..3] OF BOOL;
	final_output: BOOL;
END_VAR

FOR index := 1 TO 3 DO
	// Configure delay for each FB_Teste instance
	fb_teste[index].SetTempo(delay := delay_times[index]);
	
	// Propagate input signal to each FB_Teste instance
	fb_teste[index].entrada := in;
	
	// Execute internal logic of FB_Teste instance
	fb_teste[index]();
	
	// Collect output states
	output_states[index] := fb_teste[index].saida;
END_FOR

// Apply logic to calculate final output (e.g., AND logic)
final_output := TRUE;
FOR index := 1 TO 3 DO
	final_output := final_output AND output_states[index];
END_FOR

// Assign calculated output to the output variable
out := final_output;
END_FUNCTION_BLOCK
