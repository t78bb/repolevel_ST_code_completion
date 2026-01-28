FUNCTION F_CompensateVelocity : LREAL
VAR_INPUT
	lCurrentVel		:	LREAL;		//当前速度
	lOldPos			:	LREAL;		//上一次位置
	lNewPos			:	LREAL;		//当前位置
	lRadius			:	LREAL;		//当前半径
	lTk				:	LREAL;		//材料厚度
	bUnwinding		:	BOOL;		//TRUE=放卷（半径减小），FALSE=收卷（半径增加）
END_VAR
VAR
    lDeltaPos       : LREAL;    // 位置变化量
    lDeltaRadius    : LREAL;    // 半径变化量
    lCompFactor     : LREAL;    // 速度补偿系数
    lAdjustedRadius : LREAL;    // 调整后的半径
END_VAR

// 1. 计算位置变化量
lDeltaPos := lNewPos - lOldPos;

// 2. 判断运动方向并校正位置变化量
IF lDeltaPos = 0 THEN
    lDeltaPos := 0; // 保持不变
ELSIF lDeltaPos < 0 THEN
    lDeltaPos := -ABS(lDeltaPos); // 确保方向正确
ELSE
    lDeltaPos := ABS(lDeltaPos);
END_IF

// 3. 计算半径变化量
lDeltaRadius := lDeltaPos * lTk;

// 4. 根据放卷或收卷逻辑调整半径
IF bUnwinding THEN
    lAdjustedRadius := lRadius - lDeltaRadius; // 放卷：半径减小
ELSE
    lAdjustedRadius := lRadius + lDeltaRadius; // 收卷：半径增加
END_IF

// 避免半径过小导致除零错误
IF lAdjustedRadius < 0.01 THEN
    lAdjustedRadius := 0.01;
END_IF

// 5. 计算速度补偿系数
lCompFactor := lRadius / lAdjustedRadius;

// 6. 使用补偿系数调整速度
F_CompensateVelocity := lCurrentVel * lCompFactor;
RETURN;
END_FUNCTION
