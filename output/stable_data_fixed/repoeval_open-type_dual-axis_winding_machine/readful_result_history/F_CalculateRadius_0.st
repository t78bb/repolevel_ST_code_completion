FUNCTION F_CalculateRadius : LREAL
VAR_INPUT
	lD				:	LREAL;		//两轴中心距离
	lHold			:	LREAL;		//测量开始时的AxisV位置
	lHnew			:	LREAL;		//测量结束时的AxisV位置
	lTk				:	LREAL;		//材料厚度
	lOffset			:	LREAL;		//高度偏移量
END_VAR

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

END_FUNCTION
