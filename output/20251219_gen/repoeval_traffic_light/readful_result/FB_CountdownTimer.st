VAR
	tRemainingTime	:	TIME;		//剩余时间
END_VAR

tRemainingTime := tTotalTime - tElapsedTime; // 计算剩余时间
IF tRemainingTime < T#0s THEN
	tRemainingTime := T#0s; // 如果剩余时间小于0，则设置为0
END_IF

nRemainingSeconds := DINT_TO_UINT(TRUNC(TIME_TO_DWORD(tRemainingTime) / 1000.0)); // 将剩余时间转换为秒数