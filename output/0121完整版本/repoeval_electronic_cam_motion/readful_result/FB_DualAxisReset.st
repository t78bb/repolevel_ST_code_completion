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
END_VAR

CASE nState OF 
	0: (* 空闲状态 *)
		bDone := FALSE;
		bBusy := FALSE;
		bError := FALSE;
		
		IF bExecute THEN
			// 初始化
			fbReset1(Axis := Axis1, Execute := FALSE);
			fbReset2(Axis := Axis2, Execute := FALSE);
			fbReadStatus1(Axis := Axis1);
			fbReadStatus2(Axis := Axis2);
			
			nState := 1; // 转到复位状态
		END_IF;

	1: (* 复位状态 *)
		bBusy := TRUE;

		// 执行轴1复位
		fbReset1(Axis := Axis1, Execute := TRUE);
		IF fbReset1.Done THEN
			fbReset1.Execute := FALSE;
		END_IF;

		// 执行轴2复位
		fbReset2(Axis := Axis2, Execute := TRUE);
		IF fbReset2.Done THEN
			fbReset2.Execute := FALSE;
		END_IF;

		// 检查轴1和轴2状态
		fbReadStatus1(Axis := Axis1);
		fbReadStatus2(Axis := Axis2);

		bError1 := fbReadStatus1.Error;
		bError2 := fbReadStatus2.Error;

		IF NOT bError1 AND NOT bError2 THEN
			IF fbReset1.Done AND fbReset2.Done THEN
				bDone := TRUE;
				bBusy := FALSE;
				nState := 0; // 返回空闲状态
			END_IF;
		ELSE
			bError := TRUE;
			bBusy := FALSE;
			nState := 0; // 返回空闲状态
		END_IF;

END_CASE;
END_FUNCTION_BLOCK
