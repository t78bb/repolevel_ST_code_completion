FUNCTION F_CalculateRadius : LREAL
VAR_INPUT
	lD				:	LREAL;		//两轴中心距离
	lHold			:	LREAL;		//测量开始时的AxisV位置
	lHnew			:	LREAL;		//测量结束时的AxisV位置
	lTk				:	LREAL;		//材料厚度
	lOffset			:	LREAL;		//高度偏移量
END_VAR

# --------------------------------------------------
# FUNCTION F_CalculateRadius : LREAL
# VAR_INPUT
# 	lD				:	LREAL;		//两轴中心距离
# 	lHold			:	LREAL;		//测量开始时的AxisV位置
# 	lHnew			:	LREAL;		//测量结束时的AxisV位置
# 	lTk				:	LREAL;		//材料厚度
# 	lOffset			:	LREAL;		//高度偏移量
# END_VAR
# 
# // 计算从轴半径
# IF (lHnew - lHold) > 0.01 THEN  // 避免除零
# 	F_CalculateRadius := lD / 2 + (lHnew - lHold) / 2 + lTk + lOffset;
# ELSE
# 	F_CalculateRadius := lD / 2 + lTk + lOffset;
# END_IF
# --------------------------------------------------
# the below code fragment can be found in:
# 开放式双轴卷绕机编程开发实训-PRG\PLC_PRG.st
# --------------------------------------------------
# 			// 使用F_CalculateRadius函数计算从轴半径
# 			Sr := F_CalculateRadius(lD := AxisDistance, lHold := AxisVStart, lHnew := AxisVEnd, lTk := MaterialThickness, lOffset := HeightOffset);
# 
# 			// 调用F_CompensateVelocity函数计算速度补偿
# 			CompensatedVelocity := F_CompensateVelocity(lCurrentVel := CurrentVelocity, lOldPos := OldPosition, lNewPos := NewPosition, lRadius := Sr, lTk := MaterialThickness, bUnwinding := IsUnwinding);
END_FUNCTION