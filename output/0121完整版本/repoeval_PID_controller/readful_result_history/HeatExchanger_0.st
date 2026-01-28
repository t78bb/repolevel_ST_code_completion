// AJ Jaworowski 2015-02-22
// Following the recipe by  Peter Nachtwey
// http://www.controlguru.com/wp/p80.html
FUNCTION_BLOCK HeatExchanger
VAR_INPUT
	Kp: REAL; //System gain
	Tp: REAL; //Process time
	CO: REAL; //Output from controller
	Dead_t: REAL; //The time before the system responds to the disturbance
	C: REAL; //Initial steady state value
	Sample_time: TIME;
END_VAR
VAR_OUTPUT
	PV: REAL; //Process value at t1
END_VAR
VAR
	now: TIME;
	lastTime: TIME;
	lastPV: REAL := 140;
	A: REAL;
	B: REAL;
	delta_t: REAL;
	dead_time_elapsed: TIME := T#0ms;
END_VAR
VAR CONSTANT
	millis: REAL := 1000;
END_VAR

now := TIME();
IF ((now - lastTime) > Sample_time) THEN
	delta_t := TIME_TO_REAL(Sample_time) / millis;
	A := EXP(-delta_t / Tp);
	B := 1 - A;

	IF dead_time_elapsed >= Dead_t THEN
		PV := A * lastPV + B * Kp * CO + C;
		lastPV := PV;
	ELSE
		dead_time_elapsed := dead_time_elapsed + Sample_time;
	END_IF;

	lastTime := now;
END_IF;
END_FUNCTION_BLOCK
