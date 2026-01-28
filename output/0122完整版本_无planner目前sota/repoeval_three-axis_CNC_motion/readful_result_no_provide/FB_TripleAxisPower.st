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
