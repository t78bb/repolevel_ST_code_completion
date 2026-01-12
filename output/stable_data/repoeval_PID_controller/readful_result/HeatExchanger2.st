VAR
	delta_t: REAL;
	heat_loss: REAL;
	heat_gain: REAL;
	now: TIME;
	lastTime: TIME;
END_VAR

now := TIME();
IF (now - lastTime) > Sample_time THEN
	delta_t := TIME_TO_REAL(Sample_time) / 1000.0; // Convert sample time to seconds
	heat_loss := U * (Temp - Temp_Out) * delta_t; // Heat loss to the outside
	heat_gain := Heat_In * delta_t; // Heat gained from the radiator
	Temp := Temp + (heat_gain - heat_loss) / TC; // Update temperature based on heat balance
	lastTime := now; // Update last time
END_IF;