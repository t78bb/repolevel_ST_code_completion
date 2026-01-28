//A.J. Jaworowski 2015-02-20
//Simulering av en tank med RedBull
FUNCTION_BLOCK Tank
VAR_INPUT
	Process_In: REAL;  //Flöde in per sekund, testa vad som händer on du matar in 100
					   //Därefter ska regulatorns OUT in i denna ingång.
	Process_Out: REAL; //Flöde ut per sekund, typ 90
					   //Effekten blir att tanken fylls med 10 per sekund
					   //Full efter ca 1 minut - testa
	SampleTime: TIME;  //Uppdateringstid, typ 100ms
	Lower_limit: REAL; //Tankens lägsta nivå, typ 0
	Upper_limit: REAL; //Tankens max nivå, kanske 500
END_VAR
VAR_OUTPUT
	Level: REAL; //Nivån i tanken
END_VAR
VAR
  now: TIME;
  lastTime: TIME := T#0ms;
  timeDelta: REAL;
  volumeIn: REAL;
  volumeOut: REAL;
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
END_FUNCTION_BLOCK