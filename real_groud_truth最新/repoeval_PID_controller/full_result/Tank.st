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

// Internal variables for simulation
VAR
    DeltaTime: REAL; // Time step in seconds
    FlowChange: REAL; // Change in tank level based on input/output flow
END_VAR

// Calculate the time step in seconds
DeltaTime := REAL_TO_TIME(SampleTime) / T#1s;

// Calculate the change in tank level based on input and output flow
FlowChange := (Process_In - Process_Out) * DeltaTime;

// Update the tank level
Level := Level + FlowChange;

// Ensure the tank level stays within the defined limits
IF Level < Lower_limit THEN
    Level := Lower_limit;
ELSIF Level > Upper_limit THEN
    Level := Upper_limit;
END_IF;
END_FUNCTION_BLOCK