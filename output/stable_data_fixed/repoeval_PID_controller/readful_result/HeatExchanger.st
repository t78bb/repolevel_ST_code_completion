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
    lastTime: TIME := T#0s;
    delta_t: REAL;
    response: REAL;
    lastPV: REAL;
END_VAR
VAR CONSTANT
    millis: REAL := 1000;
END_VAR

now := TIME();
IF ((now - lastTime) > Sample_time) THEN
    delta_t := REAL_TO_TIME((now - lastTime)) / millis;
    response := (CO - lastPV) * (1 - EXP(-delta_t / Tp));
    PV := lastPV + response;
    lastPV := PV;
    lastTime := now;
END_IF;
