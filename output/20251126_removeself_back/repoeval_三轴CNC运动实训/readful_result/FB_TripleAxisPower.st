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

// Y轴伺服使能
fbPowerY(
	Enable := bServoEnable,
	Axis := AxisY
);

// Z轴伺服使能
fbPowerZ(
	Enable := bServoEnable,
	Axis := AxisZ
);

// 检查各轴是否准备就绪
bAxisXReady := fbPowerX.Status;
bAxisYReady := fbPowerY.Status;
bAxisZReady := fbPowerZ.Status;

// 如果所有轴都准备就绪，则设置bReady为TRUE
bReady := bAxisXReady AND bAxisYReady AND bAxisZReady;

// 错误处理
IF NOT bReady THEN
	bError := TRUE;
	sErrorString := 'One or more axes are not ready';
ELSE
	bError := FALSE;
	sErrorString := '';
END_IF