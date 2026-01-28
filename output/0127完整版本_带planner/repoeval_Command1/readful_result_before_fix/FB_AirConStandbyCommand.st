FUNCTION_BLOCK PUBLIC FB_AirConStandbyCommand IMPLEMENTS I_Command
VAR
    bStandbyCommandReceived : BOOL;
    bStandbyConditionsMet : BOOL;
    sExecutionResult : STRING;
END_VAR

bStandbyCommandReceived := FALSE;
bStandbyConditionsMet := FALSE;

// Step 1: Parse input command and check if it is "Standby"
IF __ISVALIDREF(refAirConditioning) THEN
    IF CommandType = "Standby" THEN
        bStandbyCommandReceived := TRUE;
    END_IF;
END_IF;

// Step 2: Check if the air conditioning system can enter standby mode
IF bStandbyCommandReceived THEN
    IF refAirConditioning.bActive AND (refAirConditioning.lrTemperature > 18.0 AND refAirConditioning.lrTemperature < 30.0) THEN
        bStandbyConditionsMet := TRUE;
    END_IF;
END_IF;

// Step 3: Execute standby operation if conditions are met
IF bStandbyConditionsMet THEN
    refAirConditioning.bActive := FALSE;
    sExecutionResult := 'Standby mode activated successfully';
ELSE
    sExecutionResult := 'Failed to activate standby mode';
END_IF;

// Step 4: Update internal system state or necessary flags
IF bStandbyConditionsMet THEN
    SystemState := 'Standby';
ELSE
    SystemState := 'Active';
END_IF;

// Step 5: Output execution result
ExecutionResult := sExecutionResult;
END_FUNCTION_BLOCK
