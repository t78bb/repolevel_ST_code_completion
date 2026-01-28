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
	bErrorX			:	BOOL;				//X轴错误标志
	bErrorY			:	BOOL;				//Y轴错误标志
	bErrorZ			:	BOOL;				//Z轴错误标志
	sErrorX			:	STRING;				//X轴错误信息
	sErrorY			:	STRING;				//Y轴错误信息
	sErrorZ			:	STRING;				//Z轴错误信息
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

bErrorX := fbPowerX.Error;
bErrorY := fbPowerY.Error;
bErrorZ := fbPowerZ.Error;

sErrorX := fbPowerX.ErrorID;
sErrorY := fbPowerY.ErrorID;
sErrorZ := fbPowerZ.ErrorID;

bError := bErrorX OR bErrorY OR bErrorZ;

IF bError THEN
	IF bErrorX THEN
		sErrorString := 'X Axis Error: ' + sErrorX;
	ELSIF bErrorY THEN
		sErrorString := 'Y Axis Error: ' + sErrorY;
	ELSIF bErrorZ THEN
		sErrorString := 'Z Axis Error: ' + sErrorZ;
	END_IF;
ELSE
	sErrorString := '';
END_IF;

bReady := bAxisXReady AND bAxisYReady AND bAxisZReady;
END_FUNCTION_BLOCK
