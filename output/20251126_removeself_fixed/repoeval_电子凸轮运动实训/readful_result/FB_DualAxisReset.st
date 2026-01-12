FUNCTION_BLOCK FB_DualAxisReset
VAR_INPUT
	Axis1			:	AXIS_REF;			//轴1引用
	Axis2			:	AXIS_REF;			//轴2引用
	bExecute		:	BOOL;				//执行复位信号
END_VAR
VAR_OUTPUT
	bDone			:	BOOL;				//复位完成
	bBusy			:	BOOL;				//复位进行中
	bError			:	BOOL;				//错误标志
END_VAR

VAR
	fbReset1		:	MC_Reset;			//轴1复位控制
	fbReset2		:	MC_Reset;			//轴2复位控制
	bAxis1ResetDone	:	BOOL;				//轴1复位完成标志
	bAxis2ResetDone	:	BOOL;				//轴2复位完成标志
END_VAR

// 执行轴1复位控制
fbReset1(
	Axis := Axis1,
	Execute := bExecute
);

// 检查轴1复位状态
IF fbReset1.Done THEN
	bAxis1ResetDone := TRUE;
ELSE
	bAxis1ResetDone := FALSE;
END_IF

// 执行轴2复位控制
fbReset2(
	Axis := Axis2,
	Execute := bExecute
);

// 检查轴2复位状态
IF fbReset2.Done THEN
	bAxis2ResetDone := TRUE;
ELSE
	bAxis2ResetDone := FALSE;
END_IF

// 检查两轴复位完成状态
IF bAxis1ResetDone AND bAxis2ResetDone THEN
	bDone := TRUE;
	bBusy := FALSE;
ELSE
	bDone := FALSE;
	bBusy := TRUE;
END_IF

// 错误处理
IF fbReset1.Error OR fbReset2.Error THEN
	bError := TRUE;
	bDone := FALSE;
	bBusy := FALSE;
ELSE
	bError := FALSE;
END_IF