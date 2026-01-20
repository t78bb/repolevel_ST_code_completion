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
	fbPowerX		:	MC_POWER;			//X轴电源控制
	fbPowerY		:	MC_POWER;			//Y轴电源控制
	fbPowerZ		:	MC_POWER;			//Z轴电源控制
	bInternalError	:	BOOL;				//内部错误标志
	sInternalError	:	STRING;				//内部错误信息
END_VAR

fbPowerX(
	Enable := bServoEnable,
	bRegulatorOn := bServoEnable,
	bDriveStart := bServoEnable,
	Axis := AxisX
);

fbPowerY(
	Enable := bServoEnable,
	bRegulatorOn := bServoEnable,
	bDriveStart := bServoEnable,
	Axis := AxisY
);

fbPowerZ(
	Enable := bServoEnable,
	bRegulatorOn := bServoEnable,
	bDriveStart := bServoEnable,
	Axis := AxisZ
);

bAxisXReady := fbPowerX.Status = MC_POWER_STATUS.PowerOn;
bAxisYReady := fbPowerY.Status = MC_POWER_STATUS.PowerOn;
bAxisZReady := fbPowerZ.Status = MC_POWER_STATUS.PowerOn;

bReady := bAxisXReady AND bAxisYReady AND bAxisZReady;

bInternalError := fbPowerX.Error OR fbPowerY.Error OR fbPowerZ.Error;

IF bInternalError THEN
	bError := TRUE;
	IF fbPowerX.Error THEN
		sInternalError := 'X Axis Error';
	ELSIF fbPowerY.Error THEN
		sInternalError := 'Y Axis Error';
	ELSIF fbPowerZ.Error THEN
		sInternalError := 'Z Axis Error';
	END_IF;
	sErrorString := sInternalError;
ELSE
	bError := FALSE;
	sErrorString := '';
END_IF;
END_FUNCTION_BLOCK
