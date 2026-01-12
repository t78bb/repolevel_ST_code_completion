FUNCTION_BLOCK FB_TripleAxisStop
VAR_INPUT
	AxisX			:	SM3_Basic.AXIS_REF_SM3			//X轴引用
	AxisY			:	SM3_Basic.AXIS_REF_SM3			//Y轴引用
	AxisZ			:	SM3_Basic.AXIS_REF_SM3			//Z轴引用
	bExecute		:	BOOL;				//执行停止信号
	rDeceleration	:	REAL := 100.0;		//减速度
END_VAR
VAR_OUTPUT
	bDone			:	BOOL;				//三轴都停止完成
	bBusy			:	BOOL;				//停止进行中
	bError			:	BOOL;				//错误标志
	sErrorString	:	STRING;				//错误信息字符串
END_VAR

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

END_FUNCTION_BLOCK
