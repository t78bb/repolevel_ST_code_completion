VAR
    lDeltaPos       : LREAL;    // 位置变化量
    lDeltaRadius    : LREAL;    // 半径变化量
    lCompensation   : LREAL;    // 速度补偿量
END_VAR

// 计算位置变化量
lDeltaPos := lNewPos - lOldPos;

// 根据放卷或收卷方向计算半径变化量
IF bUnwinding THEN
    lDeltaRadius := -lTk; // 放卷时，半径减小
ELSE
    lDeltaRadius := lTk;  // 收卷时，半径增加
END_IF;

// 计算速度补偿量
lCompensation := lDeltaPos / (lRadius + lDeltaRadius);

// 返回补偿后的速度
F_CompensateVelocity := lCurrentVel + lCompensation;
RETURN;