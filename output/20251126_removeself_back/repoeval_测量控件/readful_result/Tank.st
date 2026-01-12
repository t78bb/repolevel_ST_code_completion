It seems like you're working with a structured text (ST) code fragment for a PLC program. Here's a continuation of your code based on the context provided:

```structured-text
METHOD CheckTankStatus : BOOL
VAR_INPUT
    nCurrentLevel : INT;
    nCurrentTemp  : INT;
END_VAR
VAR
    bLevelInRange : BOOL;
    bTempInRange  : BOOL;
END_VAR

// Check if the current level is within the defined range
bLevelInRange := (nCurrentLevel >= nMinLevel) AND (nCurrentLevel <= nMaxLevel);

// Check if the current temperature is within the defined range
bTempInRange := (nCurrentTemp >= nMinTemp) AND (nCurrentTemp <= nMaxTemp);

// Return TRUE if both level and temperature are within range, otherwise FALSE
CheckTankStatus := bLevelInRange AND bTempInRange;
```

This method `CheckTankStatus` can be used to verify whether the current level and temperature of the tank are within the specified ranges. You can call this method and pass the current level and temperature as inputs to determine the tank's status.

If you need further assistance or have additional requirements, feel free to ask!