VAR
	nTotalSeconds		:	UINT;	//总秒数
	nElapsedSeconds		:	UINT;	//已过秒数
END_VAR

// 将TIME转换为秒
nTotalSeconds := TO_UINT(TIME_TO_DWORD(tTotalTime) / 1000);
nElapsedSeconds := TO_UINT(TIME_TO_DWORD(tElapsedTime) / 1000);

// 检查是否已经过了总时间
IF tElapsedTime >= tTotalTime THEN
	nRemainingSeconds := 0;
ELSE
	// 计算剩余秒数
	nRemainingSeconds := nTotalSeconds - nElapsedSeconds;
END_IF;
END_FUNCTION_BLOCK