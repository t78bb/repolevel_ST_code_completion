VAR
	rNewLevel : REAL; // 临时变量，用于计算新的液位
END_VAR

// 复位逻辑
IF bReset THEN
	rCurrentLevel := rInitialLevel;
ELSE
	// 液位计算
	rNewLevel := rCurrentLevel
				+ rFillRate1 * BOOL_TO_REAL(bMedium1Opened)
				+ rFillRate2 * BOOL_TO_REAL(bMedium2Opened)
				- rDrainRate * BOOL_TO_REAL(bDrainOpened);

	// 确保液位在最小和最大范围内
	IF rNewLevel < rMinLevel THEN
		rCurrentLevel := rMinLevel;
	ELSIF rNewLevel > rMaxLevel THEN
		rCurrentLevel := rMaxLevel;
	ELSE
		rCurrentLevel := rNewLevel;
	END_IF;
END_IF;
END_FUNCTION_BLOCK
