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
	bDoneX			:	BOOL;				//X轴停止完成
	bDoneY			:	BOOL;				//Y轴停止完成
	bDoneZ			:	BOOL;				//Z轴停止完成
	bErrorX			:	BOOL;				//X轴错误标志
	bErrorY			:	BOOL;				//Y轴错误标志
	bErrorZ			:	BOOL;				//Z轴错误标志
	sErrorStringX	:	STRING;				//X轴错误信息字符串
	sErrorStringY	:	STRING;				//Y轴错误信息字符串
	sErrorStringZ	:	STRING;				//Z轴错误信息字符串
END_VAR

fbStopX(
	Execute := bExecute,
	Deceleration := rDeceleration,
	Axis := AxisX
);
bDoneX := fbStopX.Done;
bErrorX := fbStopX.Error;
sErrorStringX := fbStopX.ErrorID;

fbStopY(
	Execute := bExecute,
	Deceleration := rDeceleration,
	Axis := AxisY
);
bDoneY := fbStopY.Done;
bErrorY := fbStopY.Error;
sErrorStringY := fbStopY.ErrorID;

fbStopZ(
	Execute := bExecute,
	Deceleration := rDeceleration,
	Axis := AxisZ
);
bDoneZ := fbStopZ.Done;
bErrorZ := fbStopZ.Error;
sErrorStringZ := fbStopZ.ErrorID;

bDone := bDoneX AND bDoneY AND bDoneZ;
bError := bErrorX OR bErrorY OR bErrorZ;

IF bError THEN
	IF bErrorX THEN
		sErrorString := CONCAT('X轴错误: ', sErrorStringX);
	ELSIF bErrorY THEN
		sErrorString := CONCAT('Y轴错误: ', sErrorStringY);
	ELSIF bErrorZ THEN
		sErrorString := CONCAT('Z轴错误: ', sErrorStringZ);
	END_IF;
ELSE
	sErrorString := '';
END_IF;

bBusy := NOT bDone AND NOT bError;
END_FUNCTION_BLOCK
