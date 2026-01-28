VAR
	_nState : USINT;
END_VAR

// Implementation of the StaDisplay function block
// This function block is used to display the status of the machine using output signals Y1 to Y6.
METHOD DisplayStatus : VOID
VAR_INPUT
	iStatus : INT; // Input status code
END_VAR
VAR_OUTPUT
	Y1, Y2, Y3, Y4, Y5, Y6 : BOOL; // Output signals representing different status indicators
END_VAR

// Reset all output signals to FALSE initially
Y1 := FALSE;
Y2 := FALSE;
Y3 := FALSE;
Y4 := FALSE;
Y5 := FALSE;
Y6 := FALSE;

// Set the corresponding output signal based on the input status code
CASE iStatus OF
	1: Y1 := TRUE; // Status 1 - Activate Y1
	2: Y2 := TRUE; // Status 2 - Activate Y2
	3: Y3 := TRUE; // Status 3 - Activate Y3
	4: Y4 := TRUE; // Status 4 - Activate Y4
	5: Y5 := TRUE; // Status 5 - Activate Y5
	6: Y6 := TRUE; // Status 6 - Activate Y6
	ELSE
		// If the status code is not recognized, keep all outputs FALSE
END_CASE;