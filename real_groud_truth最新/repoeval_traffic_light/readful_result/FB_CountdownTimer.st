VAR
	tRemainingTime	:	TIME;		//剩余时间
END_VAR

// 计算剩余时间
tRemainingTime := tTotalTime - tElapsedTime;

// 如果剩余时间小于零，则设置为零
IF tRemainingTime < T#0ms THEN
	tRemainingTime := T#0ms;
END_IF

// 将剩余时间转换为秒数
nRemainingSeconds := TIME_TO_UINT(TRUNC(TIME_TO_DWORD(tRemainingTime) / 1000.0));
END_FUNCTION_BLOCK