VAR
	now: TIME;
	lastTime: TIME := T#0s;
	delta_t: REAL;
	heat_flow: REAL;
	lastTemp: REAL;
	temp_diff: REAL;
	temp_change_rate: REAL;
	temp_change: REAL;
END_VAR

VAR CONSTANT
	millis: REAL := 1000;
END_VAR

now := TIME();
IF ((now - lastTime) > Sample_time) THEN
	// Step 1: Calculate temperature difference
	temp_diff := Temp_Out - Temp_In;

	// Step 2: Calculate heat transfer rate
	heat_flow := Heat_In - (U * temp_diff);

	// Step 3: Calculate temperature change rate
delta_t := TIME_TO_REAL(Sample_time) / millis;
	temp_change_rate := heat_flow / TC;

	// Step 4: Calculate temperature change for the current sampling period
	temp_change := temp_change_rate * delta_t;

	// Step 5: Update room temperature
	Temp := Temp_In + temp_change;

	// Update lastTime and lastTemp
	lastTime := now;
	lastTemp := Temp;
END_IF;
END_FUNCTION_BLOCK