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
	bAxis1PowerOn	:	BOOL;			//轴1电源状态
	bAxis2PowerOn	:	BOOL;			//轴2电源状态
END_VAR

// Logic for managing dual-axis power state
IF bEnable THEN
	// Check if Axis1 is ready
	bAxis1PowerOn := Axis1.PowerOn; // Assuming Axis1 has a PowerOn property
	bAxis1Ready := Axis1.Ready;     // Assuming Axis1 has a Ready property
	
	// Check if Axis2 is ready
	bAxis2PowerOn := Axis2.PowerOn; // Assuming Axis2 has a PowerOn property
	bAxis2Ready := Axis2.Ready;     // Assuming Axis2 has a Ready property
	
	// Determine if both axes are ready
	bBothReady := bAxis1Ready AND bAxis2Ready;
	
	// Error handling
	IF NOT bAxis1PowerOn OR NOT bAxis2PowerOn THEN
		bError := TRUE; // Set error flag if either axis is not powered on
	ELSE
		bError := FALSE; // Clear error flag
	END_IF;
ELSE
	// Disable power management
	bAxis1Ready := FALSE;
	bAxis2Ready := FALSE;
	bBothReady := FALSE;
	bError := FALSE;
END_IF;