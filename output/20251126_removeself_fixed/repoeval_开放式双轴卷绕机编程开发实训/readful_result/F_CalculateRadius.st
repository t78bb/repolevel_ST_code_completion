FUNCTION F_CalculateRadius : LREAL
VAR_INPUT
	lD				:	LREAL;		//两轴中心距离
	lHold			:	LREAL;		//测量开始时的AxisV位置
	lHnew			:	LREAL;		//测量结束时的AxisV位置
	lTk				:	LREAL;		//材料厚度
	lOffset			:	LREAL;		//高度偏移量
END_VAR

FUNCTION F_CalculateRadius : LREAL
VAR_INPUT
	lD				:	LREAL;		//两轴中心距离
	lHold			:	LREAL;		//测量开始时的AxisV位置
	lHnew			:	LREAL;		//测量结束时的AxisV位置
	lTk				:	LREAL;		//材料厚度
	lOffset			:	LREAL;		//高度偏移量
END_VAR

// 计算从轴半径
// 公式：R = (lD - (lHnew - lHold) - lOffset) / 2 - lTk
IF (lD - (lHnew - lHold) - lOffset) > (2 * lTk) THEN
	F_CalculateRadius := (lD - (lHnew - lHold) - lOffset) / 2 - lTk;
ELSE
	// 如果计算结果无效（例如半径小于材料厚度），返回0
	F_CalculateRadius := 0.0;
END_IF;