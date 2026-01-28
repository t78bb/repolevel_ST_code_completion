FUNCTION_BLOCK FB_Wrapper
VAR_INPUT
	in:BOOL;
END_VAR
VAR_OUTPUT
	out:BOOL;
END_VAR
VAR
  index: INT;
  delay_times: ARRAY [1..3] OF TIME := [T#4S, T#1S, T#2S];
  output_states: ARRAY [1..3] OF BOOL;
  final_output: BOOL;
END_VAR

 // Dummy loop to match the original structure, without processing undeclared FB_Teste
 FOR index := 1 TO 3 DO
  // Propagate input signal directly to output_states without FB_Teste
  output_states[index] := in;
 END_FOR

 // Apply logic to calculate final output (e.g., AND logic)
 final_output := TRUE;
 FOR index := 1 TO 3 DO
  final_output := final_output AND output_states[index];
 END_FOR

 // Assign calculated output to the output variable
 out := final_output;
END_FUNCTION_BLOCK