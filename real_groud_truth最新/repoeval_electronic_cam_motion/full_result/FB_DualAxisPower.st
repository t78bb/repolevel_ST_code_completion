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
	fbReadStatus1	:	MC_ReadStatus;		//轴1状态读取
	fbReadStatus2	:	MC_ReadStatus;		//轴2状态读取
	bError1			:	BOOL;				//轴1错误标志
	bError2			:	BOOL;				//轴2错误标志
	nState			:	UDINT;				//状态机
END_VAR

CASE nState OF
	0: (* 空闲状态 *)
		bPowerDone := FALSE;
		bAxis1Ready := FALSE;
		bAxis2Ready := FALSE;

		IF bPowerOn THEN
			// 初始化
			fbPower1(Axis := Axis1, Enable := FALSE);
			fbPower2(Axis := Axis2, Enable := FALSE);
			nState := 1;
		END_IF;

	1: (* 启动轴1电源 *)
		fbPower1(Axis := Axis1, Enable := TRUE);
		fbReadStatus1(Axis := Axis1);

		IF fbReadStatus1.Busy THEN
			bAxis1Ready := FALSE;
		ELSIF fbReadStatus1.Error THEN
			bError := TRUE;
			bError1 := TRUE;
			nState := 0; // 返回空闲状态
		ELSIF fbReadStatus1.Ready THEN
			bAxis1Ready := TRUE;
			nState := 2; // 转到轴2电源控制
		END_IF;

	2: (* 启动轴2电源 *)
		fbPower2(Axis := Axis2, Enable := TRUE);
		fbReadStatus2(Axis := Axis2);

		IF fbReadStatus2.Busy THEN
			bAxis2Ready := FALSE;
		ELSIF fbReadStatus2.Error THEN
			bError := TRUE;
			bError2 := TRUE;
			nState := 0; // 返回空闲状态
		ELSIF fbReadStatus2.Ready THEN
			bAxis2Ready := TRUE;
			nState := 3; // 转到完成状态
		END_IF;

	3: (* 电源准备完成 *)
		IF bAxis1Ready AND bAxis2Ready THEN
			bPowerDone := TRUE;
			nState := 0; // 返回空闲状态
		END_IF;

ELSE
	// 未知状态，返回空闲状态
	nState := 0;
END_CASE;
END_FUNCTION_BLOCK