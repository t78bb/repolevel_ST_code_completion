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

IF NOT bPowerOn THEN
	bPowerDone := FALSE;
	bAxis1Ready := FALSE;
	bAxis2Ready := FALSE;
	bError := FALSE;
	RETURN;
END_IF

// 执行轴1电源控制
fbPower1(
	Axis := Axis1,
	Enable := TRUE,
	bDriveStart := bPowerOn,
	bRegulatorOn := bPowerOn
);
bAxis1Ready := fbPower1.Status = MC_POWER_STATUS_READY;
bAxis1Error := fbPower1.Error;

// 执行轴2电源控制
fbPower2(
	Axis := Axis2,
	Enable := TRUE,
	bDriveStart := bPowerOn,
	bRegulatorOn := bPowerOn
);
bAxis2Ready := fbPower2.Status = MC_POWER_STATUS_READY;
bAxis2Error := fbPower2.Error;

// 判断两轴是否都准备就绪
IF bAxis1Ready AND bAxis2Ready THEN
	bPowerDone := TRUE;
ELSE
	bPowerDone := FALSE;
END_IF

// 检测是否出现错误
IF bAxis1Error OR bAxis2Error THEN
	bError := TRUE;
ELSE
	bError := FALSE;
END_IF
END_FUNCTION_BLOCK
