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