VAR_OUTPUT
	bDone	:	BOOL;
	bBusy	:	BOOL;
	bError	:	BOOL;
END_VAR
VAR
	fbReset	:	MC_Reset;		// 轴复位功能块
	nState	:	UDINT;			// 状态机
END_VAR

CASE nState OF
	0: (* 空闲状态 *)
		bDone := FALSE;
		bBusy := FALSE;
		bError := FALSE;

		IF bExec THEN
			nState := 1; (* 转到复位状态 *)
		END_IF;

	1: (* 执行复位 *)
		bBusy := TRUE;
		fbReset(Execute := TRUE);

		IF fbReset.Done THEN
			bDone := TRUE;
			bBusy := FALSE;
			nState := 0; (* 返回空闲状态 *)
		ELSIF fbReset.Error THEN
			bError := TRUE;
			bBusy := FALSE;
			nState := 0; (* 返回空闲状态 *)
		END_IF;

END_CASE;