FUNCTION CAN_Send_Data_SWMC : BOOL
VAR_INPUT
	SWMC_ID : UINT;
	id 		: UINT;
	data	: ARRAY[1..8] OF BYTE;
END_VAR

VAR
    result : BOOL;

// Initialize result to FALSE
result := FALSE;

// Simulate sending data over CAN bus
// This is a placeholder for actual CAN bus communication logic
// In a real-world scenario, this would involve interfacing with hardware
IF (SWMC_ID > 0) AND (id > 0) THEN
    // Assume the data is sent successfully
    result := TRUE;
END_IF;

// Return the result indicating success or failure
RETURN result;
END_FUNCTION

// Additional code for handling CAN communication
// This could include initialization, error handling, etc.

PROGRAM Main
VAR
    sendSuccess : BOOL;
    testData    : ARRAY[1..8] OF BYTE;
END_VAR

// Initialize test data
testData[1] := 16#01;
testData[2] := 16#02;
testData[3] := 16#03;
testData[4] := 16#04;
testData[5] := 16#05;
testData[6] := 16#06;
testData[7] := 16#07;
testData[8] := 16#08;

// Call the CAN_Send_Data_SWMC function
sendSuccess := CAN_Send_Data_SWMC(1, 16#500, testData);

// Check if the data was sent successfully
IF sendSuccess THEN
    // Data sent successfully
    // Additional logic can be added here
ELSE
    // Failed to send data
    // Error handling logic can be added here
END_IF;
END_PROGRAM