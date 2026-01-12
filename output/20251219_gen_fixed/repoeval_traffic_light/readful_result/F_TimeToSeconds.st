FUNCTION F_TimeToSeconds : DWORD
VAR_INPUT
	tTime	:	TIME;		//输入的时间
END_VAR

F_TimeToSeconds := TIME_TO_DWORD(tTime) / 1000;
RETURN;

END_FUNCTION
