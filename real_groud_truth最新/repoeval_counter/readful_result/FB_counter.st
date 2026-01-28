VAR
    bPrevUp:BOOL := FALSE;    (* Previous state of bUp *)
    bPrevDown:BOOL := FALSE;  (* Previous state of bDown *)
END_VAR

(* Increment logic *)
IF bUp AND NOT bPrevUp THEN
    nValue := nValue + 1;    (* Increment value on rising edge of bUp *)
END_IF

(* Decrement logic *)
IF bDown AND NOT bPrevDown THEN
    nValue := nValue - 1;    (* Decrement value on rising edge of bDown *)
END_IF

(* Reset logic *)
IF bReset THEN
    nValue := 0;             (* Reset value to 0 *)
END_IF

(* Update previous states *)
bPrevUp := bUp;
bPrevDown := bDown;