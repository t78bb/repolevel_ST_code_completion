VAR
	fbPowerX		:	MC_POWER;			//X轴伺服使能功能块
	fbPowerY		:	MC_POWER;			//Y轴伺服使能功能块
	fbPowerZ		:	MC_POWER;			//Z轴伺服使能功能块
END_VAR

// X轴伺服使能
fbPowerX(
	Enable := bServoEnable,
	Axis := AxisX
);
bAxisXReady := fbPowerX.Status;

// Y轴伺服使能
fbPowerY(
	Enable := bServoEnable,
	Axis := AxisY
);
bAxisYReady := fbPowerY.Status;

// Z轴伺服使能
fbPowerZ(
	Enable := bServoEnable,
	Axis := AxisZ
);
bAxisZReady := fbPowerZ.Status;

// 检查所有轴是否准备就绪
bReady := bAxisXReady AND bAxisYReady AND bAxisZReady;

// 错误处理
bError := fbPowerX.Error OR fbPowerY.Error OR fbPowerZ.Error;
IF fbPowerX.Error THEN
	sErrorString := fbPowerX.ErrorID;
ELSIF fbPowerY.Error THEN
	sErrorString := fbPowerY.ErrorID;
ELSIF fbPowerZ.Error THEN
	sErrorString := fbPowerZ.ErrorID;
END_IF;