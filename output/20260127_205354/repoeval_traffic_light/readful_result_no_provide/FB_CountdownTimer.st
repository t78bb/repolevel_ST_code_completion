VAR
	nTotalSeconds		:	UINT;	//总秒数
	nElapsedSeconds		:	UINT;	//已过秒数
END_VAR

nTotalSeconds := INT_TO_UINT(TRUNC_INT(TIME_TO_DWORD(tTotalTime) / 1000.0));
nElapsedSeconds := INT_TO_UINT(TRUNC_INT(TIME_TO_DWORD(tElapsedTime) / 1000.0));

nRemainingSeconds := nTotalSeconds - nElapsedSeconds;
END_FUNCTION_BLOCK
