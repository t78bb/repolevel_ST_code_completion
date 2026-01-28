VAR
	fbStopX			:	MC_STOP;			//X轴停止
	fbStopY			:	MC_STOP;			//Y轴停止
	fbStopZ			:	MC_STOP;			//Z轴停止
	bStopXDone		:	BOOL := FALSE;		//X轴停止完成标志
	bStopYDone		:	BOOL := FALSE;		//Y轴停止完成标志
	bStopZDone		:	BOOL := FALSE;		//Z轴停止完成标志
	bStopXError		:	BOOL := FALSE;		//X轴停止错误标志
	bStopYError		:	BOOL := FALSE;		//Y轴停止错误标志
	bStopZError		:	BOOL := FALSE;		//Z轴停止错误标志
	sStopXError		:	STRING := '';		//X轴错误信息
	sStopYError		:	STRING := '';		//Y轴错误信息
	sStopZError		:	STRING := '';		//Z轴错误信息
END_VAR

IF NOT bExecute THEN
	bDone := FALSE;
	bBusy := FALSE;
	RETURN;
END_IF;

bBusy := TRUE;
bDone := FALSE;
bError := FALSE;
sErrorString := '';

fbStopX(
	Execute := bExecute,
	Deceleration := rDeceleration,
	Axis := AxisX
);
bStopXDone := fbStopX.Done;
bStopXError := fbStopX.Error;
sStopXError := fbStopX.ErrorID;

fbStopY(
	Execute := bExecute,
	Deceleration := rDeceleration,
	Axis := AxisY
);
bStopYDone := fbStopY.Done;
bStopYError := fbStopY.Error;
sStopYError := fbStopY.ErrorID;

fbStopZ(
	Execute := bExecute,
	Deceleration := rDeceleration,
	Axis := AxisZ
);
bStopZDone := fbStopZ.Done;
bStopZError := fbStopZ.Error;
sStopZError := fbStopZ.ErrorID;

IF bStopXError THEN
	bError := TRUE;
	sErrorString := CONCAT('X轴错误: ', sStopXError);
	bBusy := FALSE;
	RETURN;
END_IF;

IF bStopYError THEN
	bError := TRUE;
	sErrorString := CONCAT('Y轴错误: ', sStopYError);
	bBusy := FALSE;
	RETURN;
END_IF;

IF bStopZError THEN
	bError := TRUE;
	sErrorString := CONCAT('Z轴错误: ', sStopZError);
	bBusy := FALSE;
	RETURN;
END_IF;

IF bStopXDone AND bStopYDone AND bStopZDone THEN
	bDone := TRUE;
	bBusy := FALSE;
	RETURN;
END_IF;
END_FUNCTION_BLOCK
