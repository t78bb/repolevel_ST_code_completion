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
// Convert TIME to REAL for arithmetic operation
  delta_t := TIME_TO_REAL(now - lastTime) / millis;
	heat_flow := Heat_In + U * (Temp_Out - Temp_In);
	Temp := Temp_In + (heat_flow * delta_t / TC);
	lastTime := now;
END_IF;
RETURN;
END_FUNCTION_BLOCK