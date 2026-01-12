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
	rLevelChange		:	REAL;			// 液位变化量
END_VAR

// 主逻辑
IF bReset THEN
	// 如果复位信号为真，将液位重置为初始液位
	rCurrentLevel := rInitialLevel;
ELSE
	// 计算液位变化
	rLevelChange := 0.0;
	
	// 如果介质1阀门打开，增加液位
	IF bMedium1Opened THEN
		rLevelChange := rLevelChange + rFillRate1;
	END_IF;
	
	// 如果介质2阀门打开，增加液位
	IF bMedium2Opened THEN
		rLevelChange := rLevelChange + rFillRate2;
	END_IF;
	
	// 如果排空阀门打开，减少液位
	IF bDrainOpened THEN
		rLevelChange := rLevelChange - rDrainRate;
	END_IF;
	
	// 更新当前液位
	rCurrentLevel := rCurrentLevel + rLevelChange;
	
	// 限制液位在最小和最大值之间
	IF rCurrentLevel > rMaxLevel THEN
		rCurrentLevel := rMaxLevel;
	ELSIF rCurrentLevel < rMinLevel THEN
		rCurrentLevel := rMinLevel;
	END_IF;
END_IF;