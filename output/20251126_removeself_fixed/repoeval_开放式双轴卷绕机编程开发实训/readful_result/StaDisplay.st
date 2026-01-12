FUNCTION_BLOCK StaDisplay
VAR_INPUT
	iStatus :	INT;
END_VAR
VAR_OUTPUT
	Y1,Y2,Y3,Y4,Y5,Y6	:	BOOL;
END_VAR

VAR
	_nState : USINT;
END_VAR

// Implementation of the StaDisplay function block
// This function block is used to display the status of the machine using output signals (Y1 to Y6)
METHOD Main
VAR_INPUT
	iStatus : INT; // Input status code
END_VAR
VAR_OUTPUT
	Y1, Y2, Y3, Y4, Y5, Y6 : BOOL; // Output signals representing different status indicators
END_VAR

// Reset all outputs to FALSE initially
Y1 := FALSE;
Y2 := FALSE;
Y3 := FALSE;
Y4 := FALSE;
Y5 := FALSE;
Y6 := FALSE;

// Set outputs based on the input status code
CASE iStatus OF
	1: 
		Y1 := TRUE; // Status 1 corresponds to Y1 being active
	2: 
		Y2 := TRUE; // Status 2 corresponds to Y2 being active
	3: 
		Y3 := TRUE; // Status 3 corresponds to Y3 being active
	4: 
		Y4 := TRUE; // Status 4 corresponds to Y4 being active
	5: 
		Y5 := TRUE; // Status 5 corresponds to Y5 being active
	6: 
		Y6 := TRUE; // Status 6 corresponds to Y6 being active
	ELSE
		// If the status code does not match any predefined case, all outputs remain FALSE
END_CASE;
END_METHOD