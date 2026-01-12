VAR
	fbStopX			:	MC_Stop;			//X轴停止
	fbStopY			:	MC_Stop;			//Y轴停止
	fbStopZ			:	MC_Stop;			//Z轴停止
	bXDone			:	BOOL;				//X轴停止完成
	bYDone			:	BOOL;				//Y轴停止完成
	bZDone			:	BOOL;				//Z轴停止完成
END_VAR

fbStopX(
	Execute := bExecute,
	Axis := AxisX,
	Deceleration := rDeceleration
);
bXDone := fbStopX.Done;

fbStopY(
	Execute := bExecute,
	Axis := AxisY,
	Deceleration := rDeceleration
);
bYDone := fbStopY.Done;

fbStopZ(
	Execute := bExecute,
	Axis := AxisZ,
	Deceleration := rDeceleration
);
bZDone := fbStopZ.Done;

bBusy := fbStopX.Busy OR fbStopY.Busy OR fbStopZ.Busy;
bError := fbStopX.Error OR fbStopY.Error OR fbStopZ.Error;

IF bError THEN
	IF fbStopX.Error THEN
		sErrorString := fbStopX.ErrorID;
	ELSIF fbStopY.Error THEN
		sErrorString := fbStopY.ErrorID;
	ELSIF fbStopZ.Error THEN
		sErrorString := fbStopZ.ErrorID;
	END_IF;
ELSE
	sErrorString := '';
END_IF;

bDone := bXDone AND bYDone AND bZDone;