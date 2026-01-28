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
	bDone := FALSE;
	bBusy := TRUE;
END_IF;

// 错误处理
bError := fbReset1.Error OR fbReset2.Error;