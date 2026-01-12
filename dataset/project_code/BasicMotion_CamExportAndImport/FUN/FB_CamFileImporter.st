FUNCTION_BLOCK FB_CamFileImporter
VAR_INPUT
	bExecute		:	BOOL;			// 执行导入
	sFileName		:	STRING;			// 导入文件名
END_VAR
VAR_OUTPUT
	bDone			:	BOOL;			// 导入完成
	bBusy			:	BOOL;			// 导入进行中
	bError			:	BOOL;			// 错误标志
	nErrorID		:	DWORD;			// 错误ID
	camRef			:	MC_CAM_REF;		// 导入的凸轮引用
END_VAR
VAR
	fbReadCam		:	SMC_ReadCAM;	// 凸轮读取功能块
	fbRtrigExecute	:	R_TRIG;			// 执行上升沿检测
	nState			:	BYTE;			// 内部状态机
END_VAR

fbRtrigExecute(CLK := bExecute);

CASE nState OF
	0: // 空闲/初始化
		bDone := FALSE;
		bBusy := FALSE;
		bError := FALSE;
		nErrorID := 0;
		fbReadCam(bExecute := FALSE);
		
		IF fbRtrigExecute.Q THEN
			nState := 1;
			bBusy := TRUE;
		END_IF
		
	1: // 执行导入
		fbReadCam(
			bExecute := TRUE,
			sFileName := sFileName
		);
		
		IF fbReadCam.bDone THEN
			camRef := fbReadCam.cam; // 获取导入的凸轮引用
			fbReadCam(bExecute := FALSE); // 复位执行信号
			nState := 2;
		ELSIF fbReadCam.bError THEN
			bError := TRUE;
			nErrorID := fbReadCam.nErrorID;
			fbReadCam(bExecute := FALSE);
			nState := 100;
		END_IF
		
	2: // 完成
		bDone := TRUE;
		bBusy := FALSE;
		nState := 0;
		
	100: // 错误状态
		bError := TRUE;
		bBusy := FALSE;
		// 等待bExecute复位
		IF NOT bExecute THEN
			nState := 0;
		END_IF
END_CASE

