VAR
    nMinValue: INT := 0;  (* Minimum value for the counter *)
    nMaxValue: INT := 100; (* Maximum value for the counter *)
END_VAR

(* Initialize the counter value *)
nValue := nMinValue;

(* Increment the counter value if bUp is TRUE and nValue is less than nMaxValue *)
IF bUp AND (nValue < nMaxValue) THEN
    nValue := nValue + 1;
END_IF

(* Decrement the counter value if bDown is TRUE and nValue is greater than nMinValue *)
IF bDown AND (nValue > nMinValue) THEN
    nValue := nValue - 1;
END_IF

(* Reset the counter value to nMinValue if bReset is TRUE *)
IF bReset THEN
    nValue := nMinValue;
END_IF
```

This code extends the functionality of the `FB_Counter` function block by adding minimum and maximum value constraints for the counter. The counter will only increment if it is below the maximum value and will only decrement if it is above the minimum value. The reset functionality sets the counter back to the minimum value.