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