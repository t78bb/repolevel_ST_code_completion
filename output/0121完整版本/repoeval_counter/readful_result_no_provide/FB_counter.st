VAR
    nPrevValue: INT;   (* Previous value for internal tracking *)
END_VAR

IF bReset THEN
    nValue := 0;       (* Reset the counter *)
ELSIF bUp THEN
    nValue := nValue + 1; (* Increment the counter *)
ELSIF bDown THEN
    nValue := nValue - 1; (* Decrement the counter *)
END_IF
END_FUNCTION_BLOCK
