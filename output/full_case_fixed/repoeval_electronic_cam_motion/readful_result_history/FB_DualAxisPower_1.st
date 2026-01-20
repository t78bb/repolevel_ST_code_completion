FUNCTION_BLOCK FB_DualAxisPower
VAR_INPUT
	Axis1			:	AXIS_REF;			//轴1引用
	Axis2			:	AXIS_REF;			//轴2引用
	bPowerOn		:	BOOL;				//电源使能信号
END_VAR
VAR_OUTPUT
	bPowerDone		:	BOOL;				//两轴都准备就绪
	bAxis1Ready		:	BOOL;				//轴1准备就绪
	bAxis2Ready		:	BOOL;				//轴2准备就绪
	bError			:	BOOL;				//错误标志
END_VAR
VAR
	fbPower1		:	MC_Power;			//轴1电源控制
	fbPower2		:	MC_Power;			//轴2电源控制
	bAxis1Error		:	BOOL;				//轴1错误标志
	bAxis2Error		:	BOOL;				//轴2错误标志
END_VAR

fbPower1.Axis := Axis1;
fbPower1.Enable := TRUE;
fbPower1.Execute := bPowerOn; // Standard MC_Power input for enabling.
fbPower1();

bAxis1Ready := fbPower1.Status = TRUE; // Logical condition corrected.
bAxis1Error := fbPower1.Error;

fbPower2.Axis := Axis2;
fbPower2.Enable := TRUE;
fbPower2.Execute := bPowerOn; // Standard MC_Power input for enabling.
fbPower2();

bAxis2Ready := fbPower2.Status = TRUE; // Logical condition corrected.
bAxis2Error := fbPower2.Error;

bPowerDone := bAxis1Ready AND bAxis2Ready;
bError := bAxis1Error OR bAxis2Error;
END_FUNCTION_BLOCK