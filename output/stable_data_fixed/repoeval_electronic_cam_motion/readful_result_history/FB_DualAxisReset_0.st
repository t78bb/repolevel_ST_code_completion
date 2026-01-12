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

// 初始化输出信号
bDone := FALSE;
bBusy := FALSE;
bError := FALSE;

// 执行轴1复位控制
fbReset1(
	Axis := Axis1,
	Execute := bExecute
);
bAxis1ResetDone := fbReset1.Done;

// 执行轴2复位控制
fbReset2(
	Axis := Axis2,
	Execute := bExecute
);
bAxis2ResetDone := fbReset2.Done;

// 检查复位完成状态
IF bAxis1ResetDone AND bAxis2ResetDone THEN
	bDone := TRUE;
	bBusy := FALSE;
ELSE
	bBusy := TRUE;
END_IF;

// 检查错误状态
IF fbReset1.Error OR fbReset2.Error THEN
	bError := TRUE;
	bBusy := FALSE;
END_IF;

END_FUNCTION_BLOCK
