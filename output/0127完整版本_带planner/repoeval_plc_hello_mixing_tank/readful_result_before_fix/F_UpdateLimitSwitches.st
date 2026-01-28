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
bLevelFull := rTankLevel >= rFullThreshold;
bLevelEmpty := rTankLevel <= rEmptyThreshold;
F_UpdateLimitSwitches := TRUE;
RETURN;
END_FUNCTION
