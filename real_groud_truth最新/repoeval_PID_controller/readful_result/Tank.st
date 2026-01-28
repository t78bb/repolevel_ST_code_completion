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