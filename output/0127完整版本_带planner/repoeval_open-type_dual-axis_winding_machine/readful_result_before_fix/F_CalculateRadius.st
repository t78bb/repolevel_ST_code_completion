FUNCTION F_CalculateRadius : LREAL
VAR_INPUT
	lD				:	LREAL;		//两轴中心距离
	lHold			:	LREAL;		//测量开始时的AxisV位置
	lHnew			:	LREAL;		//测量结束时的AxisV位置
	lTk				:	LREAL;		//材料厚度
	lOffset			:	LREAL;		//高度偏移量
END_VAR
VAR
    lDeltaH : LREAL;          // 轴位置变化量
    lEffectiveHeight : LREAL; // 总的有效高度
    lRadius : LREAL;          // 计算得到的半径值
END_VAR

// 计算轴位置变化量
lDeltaH := ABS(lHnew - lHold);

// 计算总的有效高度
lEffectiveHeight := lDeltaH + lTk + lOffset;

// 根据两轴中心距离和有效高度计算半径
lRadius := SQRT(EXPT(lD / 2, 2) + EXPT(lEffectiveHeight, 2));

// 返回计算得到的半径值
F_CalculateRadius := lRadius;
RETURN;
END_FUNCTION
