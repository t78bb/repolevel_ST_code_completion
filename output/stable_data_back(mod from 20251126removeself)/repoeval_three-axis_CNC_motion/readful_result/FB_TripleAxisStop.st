VAR
	fbStopX			:	MC_STOP;			//X轴停止
	fbStopY			:	MC_STOP;			//Y轴停止
	fbStopZ			:	MC_STOP;			//Z轴停止
END_VAR

// X轴停止
fbStopX(
	Execute := bExecute,
	Axis := AxisX,
	Deceleration := rDeceleration
);

// Y轴停止
fbStopY(
	Execute := bExecute,
	Axis := AxisY,
	Deceleration := rDeceleration
);

// Z轴停止
fbStopZ(
	Execute := bExecute,
	Axis := AxisZ,
	Deceleration := rDeceleration
);

// 输出状态逻辑
bBusy := fbStopX.Busy OR fbStopY.Busy OR fbStopZ.Busy;
bDone := fbStopX.Done AND fbStopY.Done AND fbStopZ.Done;
bError := fbStopX.Error OR fbStopY.Error OR fbStopZ.Error;

IF bError THEN
	// 错误信息拼接
	sErrorString := CONCAT(CONCAT(fbStopX.ErrorText, ' | '), CONCAT(fbStopY.ErrorText, ' | ', fbStopZ.ErrorText));
END_IF;