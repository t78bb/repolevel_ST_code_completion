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
		bError := FALSE;

		IF bPowerOn THEN
			// 初始化
			fbPower1(Axis := Axis1, Enable := FALSE);
			fbPower2(Axis := Axis2, Enable := FALSE);
			nState := 10;
		END_IF;

	10: (* 启动轴1电源 *)
		fbPower1(Axis := Axis1, Enable := TRUE);
		IF fbPower1.Status THEN
			bAxis1Ready := TRUE;
			nState := 20;
		ELSIF fbPower1.Error THEN
			bError1 := TRUE;
			bError := TRUE;
			nState := 0;
		END_IF;

	20: (* 启动轴2电源 *)
		fbPower2(Axis := Axis2, Enable := TRUE);
		IF fbPower2.Status THEN
			bAxis2Ready := TRUE;
			nState := 30;
		ELSIF fbPower2.Error THEN
			bError2 := TRUE;
			bError := TRUE;
			nState := 0;
		END_IF;

	30: (* 检查两轴状态 *)
		IF bAxis1Ready AND bAxis2Ready THEN
			bPowerDone := TRUE;
			nState := 0;
		END_IF;

ELSE
	nState := 0;
END_CASE;