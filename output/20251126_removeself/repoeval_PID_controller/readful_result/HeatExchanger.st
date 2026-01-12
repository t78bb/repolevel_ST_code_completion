// Internal variables
VAR
	now: TIME;
	lastTime: TIME := T#0s;
	delta_t: REAL;
	heat_flow: REAL;
	lastPV: REAL;
END_VAR
VAR CONSTANT
	millis: REAL := 1000;
END_VAR

// Calculate the current time
now := TIME();

// Check if the sample time has elapsed
IF ((now - lastTime) > Sample_time) THEN
	// Calculate the time difference in seconds
	delta_t := REAL_TO_TIME((now - lastTime)) / millis;
	
	// Calculate the heat flow based on the system gain and process time
	heat_flow := Kp * (CO - lastPV) / Tp;
	
	// Update the process value based on the heat flow and time difference
	PV := lastPV + heat_flow * delta_t;
	
	// Update the last process value and time
	lastPV := PV;
	lastTime := now;
END_IF;