VAR
	rTempLevel : REAL; // 临时变量用于液位计算
END_VAR

// 复位逻辑
IF bReset THEN
	rCurrentLevel := rInitialLevel;
ELSE
	// 液位计算
	rTempLevel := rCurrentLevel
				+ rFillRate1 * BOOL_TO_REAL(bMedium1Opened)
				+ rFillRate2 * BOOL_TO_REAL(bMedium2Opened)
				- rDrainRate * BOOL_TO_REAL(bDrainOpened);

	// 边界检查
	IF rTempLevel > rMaxLevel THEN
		rCurrentLevel := rMaxLevel;
	ELSIF rTempLevel < rMinLevel THEN
		rCurrentLevel := rMinLevel;
	ELSE
		rCurrentLevel := rTempLevel;
	END_IF;
END_IF;
END_FUNCTION_BLOCK
