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