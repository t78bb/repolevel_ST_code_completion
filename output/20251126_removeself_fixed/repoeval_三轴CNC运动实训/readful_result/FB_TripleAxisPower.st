FUNCTION_BLOCK FB_TripleAxisPower
VAR_INPUT
	AxisX			:	SM3_Basic.AXIS_REF_SM3			//X轴引用
	AxisY			:	SM3_Basic.AXIS_REF_SM3			//Y轴引用
	AxisZ			:	SM3_Basic.AXIS_REF_SM3			//Z轴引用
	bServoEnable	:	BOOL;				//伺服使能信号
END_VAR
VAR_OUTPUT
	bReady			:	BOOL;				//三轴都准备就绪
	bAxisXReady		:	BOOL;				//X轴准备就绪
	bAxisYReady		:	BOOL;				//Y轴准备就绪
	bAxisZReady		:	BOOL;				//Z轴准备就绪
	bError			:	BOOL;				//错误标志
	sErrorString	:	STRING;				//错误信息字符串
END_VAR

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