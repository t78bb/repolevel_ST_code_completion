VAR
	rNewLevel : REAL; // 用于计算更新后的液位
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

	// 液位限制
	IF rNewLevel > rMaxLevel THEN
		rCurrentLevel := rMaxLevel;
	ELSIF rNewLevel < rMinLevel THEN
		rCurrentLevel := rMinLevel;
	ELSE
		rCurrentLevel := rNewLevel;
	END_IF;
END_IF;
END_FUNCTION_BLOCK
