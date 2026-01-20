FUNCTION_BLOCK NodeExpandCollapse
VAR_INPUT
    xNodeClick : BOOL;  (* Input signal for node click *)
    tDblClickTime : TIME := T#500MS;  (* Time to wait for double click *)
END_VAR

VAR_OUTPUT
    xNodeExpand : BOOL;  (* Output: TRUE when node is expanded *)
    xNodeSelected : BOOL; (* Output: TRUE when node is selected *)
END_VAR
VAR
    NodeDblClick : TON;
    xNodeClickOld : BOOL;
    iNodeState : INT := 1;
END_VAR

CASE iNodeState OF
    1: (* Wait for first click *)
        IF xNodeClick AND NOT xNodeClickOld THEN
            NodeDblClick(IN := TRUE, PT := tDblClickTime);
            iNodeState := 2;
            xNodeSelected := TRUE;
        END_IF

    2: (* Wait for second click or timeout *)
IF NodeDblClick.Q THEN
 (* Timeout - single click, reset *)
 NodeDblClick(IN := FALSE); // Stop the TON block without modifying PT
 xNodeClickOld := FALSE;    // Reset click state properly
 iNodeState := 1;           // Reset the state
 xNodeSelected := FALSE;    // Reset selection to inactive
ELSIF NOT xNodeClick AND xNodeClickOld THEN
 (* Second click detected - toggle expansion *)
 NodeDblClick(IN := FALSE); // Stop the TON block without modifying PT
 xNodeExpand := NOT xNodeExpand; // Toggle the expansion state
 iNodeState := 1;                // Reset the state
 xNodeSelected := FALSE;         // Reset selection to inactive
END_IF
END_CASE

xNodeClickOld := xNodeClick;
END_FUNCTION_BLOCK