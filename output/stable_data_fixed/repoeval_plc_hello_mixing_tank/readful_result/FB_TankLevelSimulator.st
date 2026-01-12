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

rLevelChange := 0.0;

// 复位到初始液位
IF bReset THEN
	rCurrentLevel := rInitialLevel;
	RETURN;
END_IF;

// 根据阀门状态计算液位变化
IF bMedium1Opened THEN
	rLevelChange := rLevelChange + rFillRate1;
END_IF;

IF bMedium2Opened THEN
	rLevelChange := rLevelChange + rFillRate2;
END_IF;

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

END_FUNCTION_BLOCK
