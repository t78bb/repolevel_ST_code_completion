VAR
    bPrevUp: BOOL := FALSE;    (* Previous state of bUp *)
    bPrevDown: BOOL := FALSE;  (* Previous state of bDown *)
END_VAR

IF bReset THEN
    nValue := 0;               (* Reset the counter to zero *)
ELSE
    IF bUp AND NOT bPrevUp THEN
        nValue := nValue + 1;  (* Increment the counter on rising edge of bUp *)
    END_IF;
    IF bDown AND NOT bPrevDown THEN
        nValue := nValue - 1;  (* Decrement the counter on rising edge of bDown *)
    END_IF;
END_IF;

bPrevUp := bUp;                (* Store the current state of bUp *)
bPrevDown := bDown;            (* Store the current state of bDown *)