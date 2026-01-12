VAR
	tRemainingTime	:	TIME;		//剩余时间
END_VAR

// 计算剩余时间
tRemainingTime := tTotalTime - tElapsedTime;

// 如果剩余时间小于0，则设置为0
IF tRemainingTime < T#0S THEN
	tRemainingTime := T#0S;
END_IF;

// 将剩余时间转换为秒数
nRemainingSeconds := DINT_TO_UINT(TRUNC(TIME_TO_DWORD(tRemainingTime) / 1000.0));