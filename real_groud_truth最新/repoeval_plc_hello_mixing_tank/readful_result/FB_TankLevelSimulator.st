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