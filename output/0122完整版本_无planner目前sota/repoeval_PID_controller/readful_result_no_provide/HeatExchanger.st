VAR
	now: TIME;
	lastTime: TIME;
	lastPV: REAL := 140;
	A: REAL;
	B: REAL;
	delta_t: REAL;
	deadTimeElapsed: TIME := T#0ms;
END_VAR
VAR CONSTANT
	millis: REAL := 1000;
END_VAR

now := TIME();
IF ((now - lastTime) > Sample_time) THEN
	delta_t := TIME_TO_REAL(Sample_time) / millis;
	A := EXP(-delta_t / Tp);
	B := 1 - A;

IF (deadTimeElapsed >= REAL_TO_TIME(Dead_t)) THEN
    PV := A * lastPV + B * Kp * CO + C;
    lastPV := PV;
  ELSE
    deadTimeElapsed := deadTimeElapsed + Sample_time;
  END_IF;

	lastTime := now;
END_IF;
END_FUNCTION_BLOCK