FUNCTION_BLOCK PUBLIC FB_Socket
VAR_OUTPUT
  bActive		: BOOL;
END_VAR
VAR
  bInitialized : BOOL := FALSE;
  bConnected   : BOOL := FALSE;
END_VAR

IF NOT bInitialized THEN
  (* Initialize the socket *)
  bInitialized := TRUE;
  (* bConnected remains as FALSE; assume not connected initially *)
END_IF

(* Check the connection status *)
IF bInitialized THEN
  (* Simulate connection check logic *)
  bActive := bConnected;
END_IF

(* Update connection status for the next cycle *)
(* Simulate connection status change logic *)
bConnected := NOT bConnected; // Toggle connection status for demonstration
END_FUNCTION_BLOCK