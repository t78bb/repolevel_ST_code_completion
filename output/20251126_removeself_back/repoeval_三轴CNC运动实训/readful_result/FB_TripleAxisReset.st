VAR
	fbResetX		:	MC_RESET;			//X轴复位
	fbResetY		:	MC_RESET;			//Y轴复位
	fbResetZ		:	MC_RESET;			//Z轴复位
END_VAR

// X轴复位
fbResetX(
	Execute := bExecute,
	Axis := AxisX
);

// Y轴复位
fbResetY(
	Execute := bExecute,
	Axis := AxisY
);

// Z轴复位
fbResetZ(
	Execute := bExecute,
	Axis := AxisZ
);

// 检查复位状态
IF fbResetX.Done AND fbResetY.Done AND fbResetZ.Done THEN
	bDone := TRUE;
	bBusy := FALSE;
	bError := FALSE;
	sErrorString := '';
ELSIF fbResetX.Error OR fbResetY.Error OR fbResetZ.Error THEN
	bDone := FALSE;
	bBusy := FALSE;
	bError := TRUE;
	sErrorString := 'Error during axis reset';
ELSE
	bDone := FALSE;
	bBusy := TRUE;
	bError := FALSE;
	sErrorString := '';
END_IF;