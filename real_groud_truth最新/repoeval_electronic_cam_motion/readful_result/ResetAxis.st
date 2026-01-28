VAR_OUTPUT
	bDone	:	BOOL;
	bBusy	:	BOOL;
	bError	:	BOOL;
END_VAR
VAR
	fbReset	:	MC_Reset;		// 轴复位功能块
	fbReadStatus	:	MC_ReadStatus;	// 轴状态读取功能块
	nState	:	UDINT;			// 状态机变量
	bAxisError	:	BOOL;			// 轴错误标志
END_VAR

CASE nState OF
	0: (* 空闲状态 *)
		bDone := FALSE;
		bBusy := FALSE;
		bError := FALSE;
		IF bExec THEN
			nState := 1; (* 转到复位状态 *)
		END_IF;

	1: (* 复位状态 *)
		bBusy := TRUE;
		fbReset.Execute := TRUE;
		fbReset.Axis := Axis; (* 假设有一个轴引用变量 Axis *)
		IF fbReset.Done THEN
			fbReset.Execute := FALSE;
			nState := 2; (* 转到完成状态 *)
		ELSIF fbReset.Error THEN
			bAxisError := TRUE;
			bError := TRUE;
			fbReset.Execute := FALSE;
			nState := 3; (* 转到错误状态 *)
		END_IF;

	2: (* 完成状态 *)
		bDone := TRUE;
		bBusy := FALSE;
		nState := 0; (* 返回空闲状态 *)

	3: (* 错误状态 *)
		bDone := FALSE;
		bBusy := FALSE;
		(* 错误处理逻辑可以在这里添加 *)
		nState := 0; (* 返回空闲状态 *)
END_CASE;