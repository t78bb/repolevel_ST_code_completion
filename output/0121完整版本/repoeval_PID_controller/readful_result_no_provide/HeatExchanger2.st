VAR
	now: TIME;
	lastTime: TIME := T#0s;
	delta_t: REAL;
	heat_flow: REAL;
	lastTemp: REAL;
END_VAR
VAR CONSTANT
	millis: REAL := 1000;
END_VAR

now := TIME();
IF ((now - lastTime) > Sample_time) THEN
delta_t := TIME_TO_REAL(now - lastTime) / 1000; // Converts TIME difference to REAL directly in milliseconds, then divides by 1000 to obtain seconds
	lastTime := now;

	// Calculate heat flow based on thermal conductance and temperature difference
	heat_flow := U * (Temp_Out - Temp_In);

	// Update temperature using heat input, heat flow, and thermal capacity
	Temp := Temp_In + ((Heat_In - heat_flow) * delta_t / TC);

	// Store the last temperature for reference
	lastTemp := Temp;
END_IF;
END_FUNCTION_BLOCK