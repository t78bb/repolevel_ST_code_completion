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
	bXError			:	BOOL;				//X轴错误标志
	bYError			:	BOOL;				//Y轴错误标志
	bZError			:	BOOL;				//Z轴错误标志
	sXErrorString	:	STRING;				//X轴错误信息字符串
	sYErrorString	:	STRING;				//Y轴错误信息字符串
	sZErrorString	:	STRING;				//Z轴错误信息字符串
END_VAR

fbPowerX(
	Axis := AxisX,
	Enable := bServoEnable
);
bAxisXReady := fbPowerX.Status = MC_POWER_STATUS.PowerOn;
bXError := fbPowerX.Error;
sXErrorString := fbPowerX.ErrorText;

fbPowerY(
	Axis := AxisY,
	Enable := bServoEnable
);
bAxisYReady := fbPowerY.Status = MC_POWER_STATUS.PowerOn;
bYError := fbPowerY.Error;
sYErrorString := fbPowerY.ErrorText;

fbPowerZ(
	Axis := AxisZ,
	Enable := bServoEnable
);
bAxisZReady := fbPowerZ.Status = MC_POWER_STATUS.PowerOn;
bZError := fbPowerZ.Error;
sZErrorString := fbPowerZ.ErrorText;

bError := bXError OR bYError OR bZError;
IF bError THEN
	IF bXError THEN
		sErrorString := sXErrorString;
	ELSIF bYError THEN
		sErrorString := sYErrorString;
	ELSIF bZError THEN
		sErrorString := sZErrorString;
	END_IF;
END_IF;

bReady := bAxisXReady AND bAxisYReady AND bAxisZReady AND NOT bError;

END_FUNCTION_BLOCK
