FUNCTION_BLOCK TestFB
VAR_INPUT
    x: BOOL;
END_VAR
VAR_OUTPUT
    y: BOOL;
END_VAR
VAR
    xg: BOOL; // Declare xg properly based on its expected usage or functionality
END_VAR

    y := x;
    xg := TRUE; // Assuming you want to set xg to TRUE

END_FUNCTION_BLOCK
