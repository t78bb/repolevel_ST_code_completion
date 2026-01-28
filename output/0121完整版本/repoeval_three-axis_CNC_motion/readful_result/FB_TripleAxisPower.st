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
END_VAR

fbPowerX(
	Enable := bServoEnable,
	bRegulatorOn := bServoEnable,
	bDriveStart := bServoEnable,
	Axis := AxisX
);
bAxisXReady := fbPowerX.Status = MC_POWER_STATUS.PoweredOn;
bErrorX := fbPowerX.Error;

fbPowerY(
	Enable := bServoEnable,
	bRegulatorOn := bServoEnable,
	bDriveStart := bServoEnable,
	Axis := AxisY
);
bAxisYReady := fbPowerY.Status = MC_POWER_STATUS.PoweredOn;
bErrorY := fbPowerY.Error;

fbPowerZ(
	Enable := bServoEnable,
	bRegulatorOn := bServoEnable,
	bDriveStart := bServoEnable,
	Axis := AxisZ
);
bAxisZReady := fbPowerZ.Status = MC_POWER_STATUS.PoweredOn;
bErrorZ := fbPowerZ.Error;

bReady := bAxisXReady AND bAxisYReady AND bAxisZReady;
bError := bErrorX OR bErrorY OR bErrorZ;

IF bError THEN
	IF bErrorX THEN
		sErrorString := 'Error in Axis X';
	ELSIF bErrorY THEN
		sErrorString := 'Error in Axis Y';
	ELSIF bErrorZ THEN
		sErrorString := 'Error in Axis Z';
	END_IF;
ELSE
	sErrorString := '';
END_IF;
END_FUNCTION_BLOCK
