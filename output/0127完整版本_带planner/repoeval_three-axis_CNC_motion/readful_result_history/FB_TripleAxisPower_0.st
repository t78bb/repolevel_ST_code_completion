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
	bLocalError		:	BOOL;				//本地错误标志
	sLocalError		:	STRING;				//本地错误信息
END_VAR

IF NOT bServoEnable THEN
	bReady := FALSE;
	bAxisXReady := FALSE;
	bAxisYReady := FALSE;
	bAxisZReady := FALSE;
	bError := FALSE;
	sErrorString := '';
	RETURN;
END_IF;

// X轴电源控制
fbPowerX(
	Enable := bServoEnable,
	bRegulatorOn := bServoEnable,
	bDriveStart := bServoEnable,
	Axis := AxisX
);
bLocalError := fbPowerX.Error;
sLocalError := fbPowerX.ErrorID;

IF bLocalError THEN
	bError := TRUE;
	sErrorString := CONCAT('AxisX Error: ', sLocalError);
	bAxisXReady := FALSE;
ELSE
	bAxisXReady := fbPowerX.Status;
END_IF;

// Y轴电源控制
fbPowerY(
	Enable := bServoEnable,
	bRegulatorOn := bServoEnable,
	bDriveStart := bServoEnable,
	Axis := AxisY
);
bLocalError := fbPowerY.Error;
sLocalError := fbPowerY.ErrorID;

IF bLocalError THEN
	bError := TRUE;
	sErrorString := CONCAT('AxisY Error: ', sLocalError);
	bAxisYReady := FALSE;
ELSE
	bAxisYReady := fbPowerY.Status;
END_IF;

// Z轴电源控制
fbPowerZ(
	Enable := bServoEnable,
	bRegulatorOn := bServoEnable,
	bDriveStart := bServoEnable,
	Axis := AxisZ
);
bLocalError := fbPowerZ.Error;
sLocalError := fbPowerZ.ErrorID;

IF bLocalError THEN
	bError := TRUE;
	sErrorString := CONCAT('AxisZ Error: ', sLocalError);
	bAxisZReady := FALSE;
ELSE
	bAxisZReady := fbPowerZ.Status;
END_IF;

// 检查三轴是否都准备就绪
IF bAxisXReady AND bAxisYReady AND bAxisZReady THEN
	bReady := TRUE;
ELSE
	bReady := FALSE;
END_IF;
END_FUNCTION_BLOCK
