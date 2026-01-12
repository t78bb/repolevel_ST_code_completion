VAR
	now: TIME;
	lastTime: TIME;
	delta_t: REAL;
	heatFlow: REAL;
END_VAR
VAR CONSTANT
	millis: REAL := 1000;
END_VAR

now := TIME();
IF ((now - lastTime) > Sample_time) THEN
	delta_t := TIME_TO_REAL(Sample_time) / millis;
	heatFlow := (Heat_In - U * (Temp_In - Temp_Out)) * delta_t / TC;
	Temp := Temp_In + heatFlow;
	lastTime := now;
END_IF;