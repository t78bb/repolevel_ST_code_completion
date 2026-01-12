VAR
    lDeltaH : LREAL;   // 轴位置变化量
    lRadius : LREAL;   // 计算出的半径
END_VAR

// 计算轴位置变化量
lDeltaH := lHnew - lHold;

// 计算半径，考虑材料厚度和高度偏移量
IF (lD - lDeltaH - lOffset - lTk) > 0.01 THEN  // 避免除零或负值
    lRadius := (lD - lDeltaH - lOffset - lTk) / 2.0;
ELSE
    lRadius := 0.0;  // 如果计算无效，返回0
END_IF;

// 返回计算出的半径
F_CalculateRadius := lRadius;
RETURN;