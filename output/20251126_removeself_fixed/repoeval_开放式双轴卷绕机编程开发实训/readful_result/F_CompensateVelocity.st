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
	lDeltaPos		:	LREAL;		//位置变化量
	lDeltaRadius	:	LREAL;		//半径变化量
	lCompensatedVel	:	LREAL;		//补偿后的速度
END_VAR

// 计算位置变化量
lDeltaPos := ABS(lNewPos - lOldPos);

// 根据放卷或收卷方向计算半径变化量
IF bUnwinding THEN
	// 放卷，半径减小
	lDeltaRadius := lDeltaPos / (2 * SMC_PI) - lTk;
ELSE
	// 收卷，半径增加
	lDeltaRadius := lDeltaPos / (2 * SMC_PI) + lTk;
END_IF

// 计算补偿后的速度
lCompensatedVel := lCurrentVel * (lRadius / (lRadius + lDeltaRadius));

// 返回补偿后的速度
F_CompensateVelocity := lCompensatedVel;