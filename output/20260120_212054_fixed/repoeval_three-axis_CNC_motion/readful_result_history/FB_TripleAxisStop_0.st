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
	bStopXDone		:	BOOL;
	bStopYDone		:	BOOL;
	bStopZDone		:	BOOL;
	bStopXBusy		:	BOOL;
	bStopYBusy		:	BOOL;
	bStopZBusy		:	BOOL;
	bStopXError		:	BOOL;
	bStopYError		:	BOOL;
	bStopZError		:	BOOL;
	sStopXErrorString:	STRING;
	sStopYErrorString:	STRING;
	sStopZErrorString:	STRING;
END_VAR

fbStopX(
	Execute := bExecute,
	Deceleration := rDeceleration,
	Axis := AxisX
);
bStopXDone := fbStopX.Done;
bStopXBusy := fbStopX.Busy;
bStopXError := fbStopX.Error;
sStopXErrorString := fbStopX.ErrorID;

fbStopY(
	Execute := bExecute,
	Deceleration := rDeceleration,
	Axis := AxisY
);
bStopYDone := fbStopY.Done;
bStopYBusy := fbStopY.Busy;
bStopYError := fbStopY.Error;
sStopYErrorString := fbStopY.ErrorID;

fbStopZ(
	Execute := bExecute,
	Deceleration := rDeceleration,
	Axis := AxisZ
);
bStopZDone := fbStopZ.Done;
bStopZBusy := fbStopZ.Busy;
bStopZError := fbStopZ.Error;
sStopZErrorString := fbStopZ.ErrorID;

bDone := bStopXDone AND bStopYDone AND bStopZDone;
bBusy := bStopXBusy OR bStopYBusy OR bStopZBusy;
bError := bStopXError OR bStopYError OR bStopZError;

IF bStopXError THEN
	sErrorString := sStopXErrorString;
ELSIF bStopYError THEN
	sErrorString := sStopYErrorString;
ELSIF bStopZError THEN
	sErrorString := sStopZErrorString;
ELSE
	sErrorString := '';
END_IF;
END_FUNCTION_BLOCK
