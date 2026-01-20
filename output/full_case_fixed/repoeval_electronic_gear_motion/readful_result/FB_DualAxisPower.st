FUNCTION_BLOCK FB_DualAxisPower
VAR_INPUT
	Axis1			:	AXIS_REF;		//轴1引用
	Axis2			:	AXIS_REF;		//轴2引用
	bEnable			:	BOOL := TRUE;	//使能信号
END_VAR
VAR_OUTPUT
	bAxis1Ready		:	BOOL;			//轴1准备就绪
	bAxis2Ready		:	BOOL;			//轴2准备就绪
	bBothReady		:	BOOL;			//两轴都准备就绪
	bError			:	BOOL;			//错误标志
END_VAR
VAR
	fbPower1		:	MC_Power;		//轴1电源控制
	fbPower2		:	MC_Power;		//轴2电源控制
	bAxis1Error		:	BOOL;			//轴1错误标志
	bAxis2Error		:	BOOL;			//轴2错误标志
END_VAR

fbPower1(
 Axis := Axis1,
 Enable := bEnable
);

fbPower2(
 Axis := Axis2,
 Enable := bEnable
);

// Assuming correct logic for readiness is "Status = TRUE"
bAxis1Ready := fbPower1.Status = MC_POWER_READY;
bAxis2Ready := fbPower2.Status = MC_POWER_READY;

bAxis1Error := fbPower1.Error;
bAxis2Error := fbPower2.Error;

bError := bAxis1Error OR bAxis2Error;

bBothReady := bAxis1Ready AND bAxis2Ready;
END_FUNCTION_BLOCK