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
    DeltaTime: REAL; // Time difference in seconds
    LevelChange: REAL; // Change in tank level
BEGIN
    // Calculate the time difference in seconds
    DeltaTime := TO_REAL(TIME_TO_MS(SampleTime)) / 1000.0;

    // Calculate the change in tank level
    LevelChange := (Process_In - Process_Out) * DeltaTime;

    // Update the tank level
    Level := Level + LevelChange;

    // Ensure the tank level stays within the specified limits
    IF Level > Upper_limit THEN
        Level := Upper_limit;
    ELSIF Level < Lower_limit THEN
        Level := Lower_limit;
    END_IF;
END_VAR
