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
			nState := 1; // 转到复位状态
		END_IF;

1: (* 复位状态 *)
  bBusy := TRUE;

  // 执行轴1复位
  fbReset1(Axis := Axis1, Execute := TRUE);
  bError1 := fbReset1.Error;

  // 执行轴2复位
  fbReset2(Axis := Axis2, Execute := TRUE);
  bError2 := fbReset2.Error;

  // 检查错误
  IF bError1 OR bError2 THEN
    bError := TRUE;
    nState := 3; // 转到错误状态
  ELSIF NOT fbReset1.Done OR NOT fbReset2.Done THEN
    nState := 1; // 保持复位状态
  ELSE
    nState := 2; // 转到完成状态
  END_IF;

2: (* 完成状态 *)
  bDone := TRUE;
  bBusy := FALSE;
  bError := FALSE;

  // 复位完成
  fbReset1(Axis := Axis1, Execute := FALSE);
  fbReset2(Axis := Axis2, Execute := FALSE);
  nState := 0; // 转到空闲状态

3: (* 错误状态 *)
  bDone := FALSE;
  bBusy := FALSE;
  bError := TRUE;

  // 停止复位
  fbReset1(Axis := Axis1, Execute := FALSE);
  fbReset2(Axis := Axis2, Execute := FALSE);
  nState := 0; // 转到空闲状态
END_CASE;
END_FUNCTION_BLOCK