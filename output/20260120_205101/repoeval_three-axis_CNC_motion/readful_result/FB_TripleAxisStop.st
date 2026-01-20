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
	fbStopX			:	MC_STOP;			//X轴停止
	fbStopY			:	MC_STOP;			//Y轴停止
	fbStopZ			:	MC_STOP;			//Z轴停止
	bStopXDone		:	BOOL;				//X轴停止完成
	bStopYDone		:	BOOL;				//Y轴停止完成
	bStopZDone		:	BOOL;				//Z轴停止完成
	bStopXError		:	BOOL;				//X轴停止错误
	bStopYError		:	BOOL;				//Y轴停止错误
	bStopZError		:	BOOL;				//Z轴停止错误
	sStopXError		:	STRING;				//X轴错误信息
	sStopYError		:	STRING;				//Y轴错误信息
	sStopZError		:	STRING;				//Z轴错误信息
END_VAR

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

bDone := bStopXDone AND bStopYDone AND bStopZDone;
bBusy := NOT bDone AND NOT (bStopXError OR bStopYError OR bStopZError);
bError := bStopXError OR bStopYError OR bStopZError;

IF bStopXError THEN
	sErrorString := CONCAT('X轴错误: ', sStopXError);
ELSIF bStopYError THEN
	sErrorString := CONCAT('Y轴错误: ', sStopYError);
ELSIF bStopZError THEN
	sErrorString := CONCAT('Z轴错误: ', sStopZError);
ELSE
	sErrorString := '';
END_IF;
END_FUNCTION_BLOCK
