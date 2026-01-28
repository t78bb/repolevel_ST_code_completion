VAR
  now: TIME;
  lastTime: TIME := T#0ms;
  timeDelta: REAL;
  volumeIn: REAL;
  volumeOut: REAL;
END_VAR
// Step 1: Calculate time delta in seconds
now := TIME();
timeDelta := TIME_TO_REAL(now - lastTime) / 1000.0;

// Step 2: Calculate volume change due to input flow
volumeIn := timeDelta * Process_In;

// Step 3: Calculate volume change due to output flow
volumeOut := timeDelta * Process_Out;

// Step 4: Update tank level
Level := Level + volumeIn - volumeOut;

// Step 5: Constrain tank level within limits
IF Level < Lower_limit THEN
  Level := Lower_limit;
ELSIF Level > Upper_limit THEN
  Level := Upper_limit;
END_IF;

// Update lastTime for the next cycle
lastTime := now;