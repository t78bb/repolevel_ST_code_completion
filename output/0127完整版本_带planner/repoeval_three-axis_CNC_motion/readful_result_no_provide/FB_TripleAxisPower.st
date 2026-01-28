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
