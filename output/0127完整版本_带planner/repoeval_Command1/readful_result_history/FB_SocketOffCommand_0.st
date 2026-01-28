FUNCTION_BLOCK PUBLIC FB_SocketOffCommand IMPLEMENTS I_Command
VAR
    bCommandExecuted : BOOL := FALSE;
END_VAR

IF NOT bCommandExecuted THEN
    (* Step 1: Initialize command state *)
    bCommandExecuted := TRUE;

    (* Step 2: Call control logic to turn off the socket *)
    IF __ISVALIDREF(THIS^.refSocket) THEN
        THIS^.refSocket.Off();
    END_IF;

    (* Step 3: Update socket state to off *)
    IF __ISVALIDREF(THIS^.refSocket) THEN
        THIS^.refSocket.bActive := FALSE;
    END_IF;

    (* Step 4: Indicate command execution success *)
    bCommandExecuted := TRUE;
END_IF;

(* Step 5: Clean up resources if necessary *)
(* No additional resources to clean up in this implementation *)
END_FUNCTION_BLOCK
