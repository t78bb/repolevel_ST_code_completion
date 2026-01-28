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
	fbReset1		:	MC_Reset;			//轴1复位
	fbReset2		:	MC_Reset;			//轴2复位
	fbReadStatus1	:	MC_ReadStatus;		//轴1状态读取
	fbReadStatus2	:	MC_ReadStatus;		//轴2状态读取
	bError1			:	BOOL;				//轴1错误标志
	bError2			:	BOOL;				//轴2错误标志
	nState			:	UDINT;				//状态机
	tTimeout		:	TIME := T#5s;		//超时时间
	tStartTime		:	TIME;				//开始时间
END_VAR

CASE nState OF
	0: (* 空闲状态 *)
		bDone := FALSE;
		bBusy := FALSE;
		bError := FALSE;

		IF bExecute THEN
			bBusy := TRUE;
			tStartTime := TIME(); (* 记录开始时间 *)
			nState := 10;
		END_IF;

	10: (* 检查轴状态 *)
		fbReadStatus1(Axis := Axis1);
		fbReadStatus2(Axis := Axis2);

		bError1 := NOT fbReadStatus1.Error AND NOT fbReadStatus1.Valid;
		bError2 := NOT fbReadStatus2.Error AND NOT fbReadStatus2.Valid;

		IF bError1 OR bError2 THEN
			bError := TRUE;
			bBusy := FALSE;
			nState := 0;
		ELSE
			nState := 20;
		END_IF;

	20: (* 执行复位 *)
		fbReset1(Axis := Axis1, Execute := TRUE);
		fbReset2(Axis := Axis2, Execute := TRUE);

		IF fbReset1.Done AND fbReset2.Done THEN
			bDone := TRUE;
			bBusy := FALSE;
			bError := FALSE;
			nState := 0;
		ELSIF fbReset1.Error OR fbReset2.Error THEN
			bError := TRUE;
			bBusy := FALSE;
			bDone := FALSE;
			nState := 0;
		ELSIF (TIME() - tStartTime) > tTimeout THEN
			bError := TRUE;
			bBusy := FALSE;
			bDone := FALSE;
			nState := 0;
		END_IF;
END_CASE;
END_FUNCTION_BLOCK
