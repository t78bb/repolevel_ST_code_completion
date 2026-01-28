FUNCTION_BLOCK FB_TankLevelSimulator
VAR_INPUT
	bMedium1Opened		:	BOOL;			// 介质1阀门打开
	bMedium2Opened		:	BOOL;			// 介质2阀门打开
	bDrainOpened		:	BOOL;			// 排空阀门打开
	bReset				:	BOOL;			// 复位到初始液位
	
	// 配置参数
	rInitialLevel		:	REAL := 25.0;	// 初始液位 (%)
	rFillRate1			:	REAL := 0.1;	// 介质1填充速率 (%/cycle)
	rFillRate2			:	REAL := 0.1;	// 介质2填充速率 (%/cycle)
	rDrainRate			:	REAL := 0.2;	// 排空速率 (%/cycle)
	rMinLevel			:	REAL := 0.0;	// 最小液位 (%)
	rMaxLevel			:	REAL := 100.0;	// 最大液位 (%)
END_VAR
VAR_OUTPUT
	rCurrentLevel		:	REAL;			// 当前液位 (%)
END_VAR
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
