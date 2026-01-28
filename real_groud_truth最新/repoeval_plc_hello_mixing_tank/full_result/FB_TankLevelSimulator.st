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
	rLevel				:	REAL;			// 内部液位变量
END_VAR

// 初始化液位
IF bReset THEN
	rLevel := rInitialLevel;
END_IF

// 液位计算逻辑
IF bMedium1Opened THEN
	rLevel := rLevel + rFillRate1;
END_IF

IF bMedium2Opened THEN
	rLevel := rLevel + rFillRate2;
END_IF

IF bDrainOpened THEN
	rLevel := rLevel - rDrainRate;
END_IF

// 限制液位范围
IF rLevel < rMinLevel THEN
	rLevel := rMinLevel;
ELSIF rLevel > rMaxLevel THEN
	rLevel := rMaxLevel;
END_IF

// 输出当前液位
rCurrentLevel := rLevel;
END_FUNCTION_BLOCK