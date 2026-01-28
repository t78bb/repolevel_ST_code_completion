VAR
	now: TIME;
	lastTime: TIME := T#0ms;
	proc_sum_in: REAL := 0.0;
	proc_sum_out: REAL := 0.0;
	temp: REAL := 0.0;
	millis: UINT := 1000;
	proc_out: REAL := 0.0;
END_VAR

now := TIME();
IF (now - lastTime) >= SampleTime THEN
	// Update the fluid level based on input and output flow rates
	Level := Level + TIME_TO_REAL(SampleTime) / millis * (Process_In - Process_Out);
	
	// Ensure the level does not exceed the defined limits
	IF Level < Lower_limit THEN
		Level := Lower_limit;
	ELSIF Level > Upper_limit THEN
		Level := Upper_limit;
	END_IF;
	
	// Update the last time variable
	lastTime := now;
END_IF;
END_FUNCTION_BLOCK
