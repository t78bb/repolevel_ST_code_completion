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
	bAxis1PowerReady	:	BOOL;	//轴1电源准备标志
	bAxis2PowerReady	:	BOOL;	//轴2电源准备标志
END_VAR

// 轴1电源管理
IF bEnable THEN
	bAxis1PowerReady := Axis1.PowerOn();
	bAxis2PowerReady := Axis2.PowerOn();
ELSE
	bAxis1PowerReady := Axis1.PowerOff();
	bAxis2PowerReady := Axis2.PowerOff();
END_IF;

// 检查轴准备状态
bAxis1Ready := Axis1.IsReady() AND bAxis1PowerReady;
bAxis2Ready := Axis2.IsReady() AND bAxis2PowerReady;

// 两轴都准备就绪
bBothReady := bAxis1Ready AND bAxis2Ready;

// 错误标志
bError := Axis1.HasError() OR Axis2.HasError();

END_FUNCTION_BLOCK
