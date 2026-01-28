bLevelFull := rTankLevel >= rFullThreshold;		// 液位 >= 满阈值时，满开关激活
bLevelEmpty := rTankLevel <= rEmptyThreshold;	// 液位 <= 空阈值时，空开关激活

F_UpdateLimitSwitches := TRUE;
RETURN;
END_FUNCTION
