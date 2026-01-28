FUNCTION F_SecondsToTime : TIME
VAR_INPUT
	dwSeconds	:	DWORD;		//输入的秒数
END_VAR
F_SecondsToTime := DWORD_TO_TIME(dwSeconds * 1000);
RETURN;
END_FUNCTION
