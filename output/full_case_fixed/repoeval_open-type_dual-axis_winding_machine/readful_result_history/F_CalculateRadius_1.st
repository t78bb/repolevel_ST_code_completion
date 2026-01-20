FUNCTION F_CalculateRadius : LREAL
VAR_INPUT
	lD				:	LREAL;		//两轴中心距离
	lHold			:	LREAL;		//测量开始时的AxisV位置
	lHnew			:	LREAL;		//测量结束时的AxisV位置
	lTk				:	LREAL;		//材料厚度
	lOffset			:	LREAL;		//高度偏移量
END_VAR
VAR
    lRadiusStart : LREAL;
    lRadiusEnd : LREAL;
    lResult : LREAL;
END_VAR

lRadiusStart := SQRT(POW(lD, 2) + POW(lHold + lOffset, 2));
lRadiusEnd := SQRT(POW(lD, 2) + POW(lHnew + lOffset, 2));
lResult := ABS(lRadiusEnd - lRadiusStart) / PI + lTk;

F_CalculateRadius := lResult;
RETURN;
END_FUNCTION