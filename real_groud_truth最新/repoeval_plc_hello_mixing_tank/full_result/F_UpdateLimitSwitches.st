FUNCTION F_UpdateLimitSwitches : BOOL
VAR_INPUT
	rTankLevel			:	REAL;			// 当前液位 (%)
	rFullThreshold		:	REAL := 85.0;	// 满液位阈值 (%)
	rEmptyThreshold		:	REAL := 5.0;	// 空液位阈值 (%)
END_VAR
VAR_OUTPUT
	bLevelFull			:	BOOL;			// 液位满开关
	bLevelEmpty			:	BOOL;			// 液位空开关
END_VAR

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
END_FUNCTION