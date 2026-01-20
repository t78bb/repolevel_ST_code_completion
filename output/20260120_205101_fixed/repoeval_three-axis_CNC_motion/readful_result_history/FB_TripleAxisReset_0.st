FUNCTION_BLOCK FB_TripleAxisReset
VAR_INPUT
	AxisX			:	SM3_Basic.AXIS_REF_SM3			//X轴引用
	AxisY			:	SM3_Basic.AXIS_REF_SM3			//Y轴引用
	AxisZ			:	SM3_Basic.AXIS_REF_SM3			//Z轴引用
	bExecute		:	BOOL;				//执行复位信号
END_VAR
VAR_OUTPUT
	bDone			:	BOOL;				//三轴都复位完成
	bBusy			:	BOOL;				//复位进行中
	bError			:	BOOL;				//错误标志
	sErrorString	:	STRING;				//错误信息字符串
END_VAR
VAR
	fbResetX		:	MC_RESET;			//X轴复位
	fbResetY		:	MC_RESET;			//Y轴复位
	fbResetZ		:	MC_RESET;			//Z轴复位
	bResetXDone		:	BOOL;				//X轴复位完成
	bResetYDone		:	BOOL;				//Y轴复位完成
	bResetZDone		:	BOOL;				//Z轴复位完成
	bResetXBusy		:	BOOL;				//X轴复位进行中
	bResetYBusy		:	BOOL;				//Y轴复位进行中
	bResetZBusy		:	BOOL;				//Z轴复位进行中
	bResetXError	:	BOOL;				//X轴复位错误
	bResetYError	:	BOOL;				//Y轴复位错误
	bResetZError	:	BOOL;				//Z轴复位错误
	sResetXErrorString	:	STRING;			//X轴复位错误信息
	sResetYErrorString	:	STRING;			//Y轴复位错误信息
	sResetZErrorString	:	STRING;			//Z轴复位错误信息
END_VAR

fbResetX(
	Execute := bExecute,
	Axis := AxisX
);
bResetXDone := fbResetX.Done;
bResetXBusy := fbResetX.Busy;
bResetXError := fbResetX.Error;
sResetXErrorString := fbResetX.ErrorID;

fbResetY(
	Execute := bExecute,
	Axis := AxisY
);
bResetYDone := fbResetY.Done;
bResetYBusy := fbResetY.Busy;
bResetYError := fbResetY.Error;
sResetYErrorString := fbResetY.ErrorID;

fbResetZ(
	Execute := bExecute,
	Axis := AxisZ
);
bResetZDone := fbResetZ.Done;
bResetZBusy := fbResetZ.Busy;
bResetZError := fbResetZ.Error;
sResetZErrorString := fbResetZ.ErrorID;

bDone := bResetXDone AND bResetYDone AND bResetZDone;
bBusy := bResetXBusy OR bResetYBusy OR bResetZBusy;
bError := bResetXError OR bResetYError OR bResetZError;

IF bResetXError THEN
	sErrorString := sResetXErrorString;
ELSIF bResetYError THEN
	sErrorString := sResetYErrorString;
ELSIF bResetZError THEN
	sErrorString := sResetZErrorString;
ELSE
	sErrorString := '';
END_IF;
END_FUNCTION_BLOCK
