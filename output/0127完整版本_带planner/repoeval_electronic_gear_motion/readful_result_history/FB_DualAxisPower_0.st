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
END_VAR

IF NOT bEnable THEN
	bAxis1Ready := FALSE;
	bAxis2Ready := FALSE;
	bBothReady := FALSE;
	bError := FALSE;
	RETURN;
END_IF

// 执行轴1电源控制
fbPower1(
	Axis := Axis1,
	Enable := bEnable,
	bDriveStart := TRUE,
	bRegulatorOn := TRUE
);

// 执行轴2电源控制
fbPower2(
	Axis := Axis2,
	Enable := bEnable,
	bDriveStart := TRUE,
	bRegulatorOn := TRUE
);

// 检查轴1状态
IF NOT fbPower1.Status OR fbPower1.Error THEN
	bAxis1Ready := FALSE;
	bError := TRUE;
	RETURN;
ELSE
	bAxis1Ready := TRUE;
END_IF

// 检查轴2状态
IF NOT fbPower2.Status OR fbPower2.Error THEN
	bAxis2Ready := FALSE;
	bError := TRUE;
	RETURN;
ELSE
	bAxis2Ready := TRUE;
END_IF

// 更新两轴准备状态
bBothReady := bAxis1Ready AND bAxis2Ready;

// 检查最终状态
IF bBothReady AND NOT bError THEN
	RETURN;
END_IF
END_FUNCTION_BLOCK
