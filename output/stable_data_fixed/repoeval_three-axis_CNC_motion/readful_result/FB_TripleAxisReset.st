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
	bDoneX			:	BOOL;				//X轴复位完成
	bDoneY			:	BOOL;				//Y轴复位完成
	bDoneZ			:	BOOL;				//Z轴复位完成
	bBusyX			:	BOOL;				//X轴复位进行中
	bBusyY			:	BOOL;				//Y轴复位进行中
	bBusyZ			:	BOOL;				//Z轴复位进行中
	bErrorX			:	BOOL;				//X轴复位错误
	bErrorY			:	BOOL;				//Y轴复位错误
	bErrorZ			:	BOOL;				//Z轴复位错误
	sErrorStringX	:	STRING;				//X轴错误信息字符串
	sErrorStringY	:	STRING;				//Y轴错误信息字符串
	sErrorStringZ	:	STRING;				//Z轴错误信息字符串
END_VAR

fbResetX(
	Execute := bExecute,
	Axis := AxisX
);
bDoneX := fbResetX.Done;
bBusyX := fbResetX.Busy;
bErrorX := fbResetX.Error;
sErrorStringX := fbResetX.ErrorString;

fbResetY(
	Execute := bExecute,
	Axis := AxisY
);
bDoneY := fbResetY.Done;
bBusyY := fbResetY.Busy;
bErrorY := fbResetY.Error;
sErrorStringY := fbResetY.ErrorString;

fbResetZ(
	Execute := bExecute,
	Axis := AxisZ
);
bDoneZ := fbResetZ.Done;
bBusyZ := fbResetZ.Busy;
bErrorZ := fbResetZ.Error;
sErrorStringZ := fbResetZ.ErrorString;

bDone := bDoneX AND bDoneY AND bDoneZ;
bBusy := bBusyX OR bBusyY OR bBusyZ;
bError := bErrorX OR bErrorY OR bErrorZ;

IF bError THEN
	sErrorString := CONCAT(CONCAT(sErrorStringX, sErrorStringY), sErrorStringZ);
ELSE
	sErrorString := '';
END_IF;

END_FUNCTION_BLOCK
