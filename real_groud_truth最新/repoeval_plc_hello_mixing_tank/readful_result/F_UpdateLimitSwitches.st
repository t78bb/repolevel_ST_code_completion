# --------------------------------------------------
# FUNCTION F_UpdateLimitSwitches
# This function updates the limit switches based on the current tank level.
# If the tank level exceeds the full threshold, the full switch is activated.
# If the tank level drops below the empty threshold, the empty switch is activated.
# --------------------------------------------------

# Update the full level switch
IF rTankLevel >= rFullThreshold THEN
    bLevelFull := TRUE;
ELSE
    bLevelFull := FALSE;
END_IF;

# Update the empty level switch
IF rTankLevel <= rEmptyThreshold THEN
    bLevelEmpty := TRUE;
ELSE
    bLevelEmpty := FALSE;
END_IF;

# Return TRUE to indicate the function executed successfully
F_UpdateLimitSwitches := TRUE;