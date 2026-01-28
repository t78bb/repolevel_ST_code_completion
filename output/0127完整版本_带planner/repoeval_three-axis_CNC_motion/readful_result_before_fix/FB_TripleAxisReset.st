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
	bResetXDone		:	BOOL;				//X轴复位完成标志
	bResetYDone		:	BOOL;				//Y轴复位完成标志
	bResetZDone		:	BOOL;				//Z轴复位完成标志
	bResetXError	:	BOOL;				//X轴复位错误标志
	bResetYError	:	BOOL;				//Y轴复位错误标志
	bResetZError	:	BOOL;				//Z轴复位错误标志
	sResetXError	:	STRING;				//X轴复位错误信息
	sResetYError	:	STRING;				//Y轴复位错误信息
	sResetZError	:	STRING;				//Z轴复位错误信息
END_VAR

IF NOT bExecute THEN
	bBusy := FALSE;
	bDone := FALSE;
	bError := FALSE;
	sErrorString := '';
	RETURN;
END_IF;

bBusy := TRUE;

// X轴复位
fbResetX(Execute := bExecute, Axis := AxisX);
bResetXDone := fbResetX.Done;
bResetXError := fbResetX.Error;
sResetXError := fbResetX.ErrorID;

// Y轴复位
fbResetY(Execute := bExecute, Axis := AxisY);
bResetYDone := fbResetY.Done;
bResetYError := fbResetY.Error;
sResetYError := fbResetY.ErrorID;

// Z轴复位
fbResetZ(Execute := bExecute, Axis := AxisZ);
bResetZDone := fbResetZ.Done;
bResetZError := fbResetZ.Error;
sResetZError := fbResetZ.ErrorID;

// 检查复位状态
IF bResetXError THEN
	bError := TRUE;
	sErrorString := CONCAT('X轴复位错误: ', sResetXError);
	bBusy := FALSE;
	RETURN;
END_IF;

IF bResetYError THEN
	bError := TRUE;
	sErrorString := CONCAT('Y轴复位错误: ', sResetYError);
	bBusy := FALSE;
	RETURN;
END_IF;

IF bResetZError THEN
	bError := TRUE;
	sErrorString := CONCAT('Z轴复位错误: ', sResetZError);
	bBusy := FALSE;
	RETURN;
END_IF;

IF bResetXDone AND bResetYDone AND bResetZDone THEN
	bDone := TRUE;
	bError := FALSE;
	sErrorString := '';
	bBusy := FALSE;
	RETURN;
END_IF;
END_FUNCTION_BLOCK
