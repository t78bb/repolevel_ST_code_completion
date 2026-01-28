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
ELSE
	bDone := FALSE;
	bBusy := TRUE;
END_IF;

// 错误处理
IF fbResetX.Error THEN
	bError := TRUE;
	sErrorString := 'X轴复位错误';
ELSIF fbResetY.Error THEN
	bError := TRUE;
	sErrorString := 'Y轴复位错误';
ELSIF fbResetZ.Error THEN
	bError := TRUE;
	sErrorString := 'Z轴复位错误';
ELSE
	bError := FALSE;
	sErrorString := '';
END_IF;