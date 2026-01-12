FUNCTION F_TimeToSeconds : DWORD
VAR_INPUT
	tTime	:	TIME;		//输入的时间
END_VAR

// 将TIME类型转换为秒数（DWORD）
    F_TimeToSeconds := TIME_TO_DWORD(tTime) / 1000;