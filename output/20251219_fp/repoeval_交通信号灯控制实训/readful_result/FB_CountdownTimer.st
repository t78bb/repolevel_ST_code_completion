VAR
	dwElapsedSeconds	: DWORD;	// 已经过的秒数
	dwTotalSeconds		: DWORD;	// 总秒数
	dwRemainingSeconds	: DWORD;	// 剩余秒数
END_VAR

// 将已经过的时间和总时间转换为秒数
dwElapsedSeconds := DINT_TO_DWORD(TRUNC(TIME_TO_DWORD(tElapsedTime) / 1000.0));
dwTotalSeconds := DINT_TO_DWORD(TRUNC(TIME_TO_DWORD(tTotalTime) / 1000.0));

// 计算剩余秒数
IF dwTotalSeconds > dwElapsedSeconds THEN
	dwRemainingSeconds := dwTotalSeconds - dwElapsedSeconds;
ELSE
	dwRemainingSeconds := 0;
END_IF;

// 将剩余秒数赋值给输出变量
nRemainingSeconds := DWORD_TO_UINT(dwRemainingSeconds);