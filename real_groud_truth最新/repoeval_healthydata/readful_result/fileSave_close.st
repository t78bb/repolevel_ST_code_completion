# VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
	fileHandle0 : DWORD;
	datetime	: DATE_AND_TIME;
	UdIntms 	: UDINT;
	UdMsOffset  : UDINT;
	DTimer_Str  : STRING;
	uiYear 		: UINT; 
	uiMonth 	: UINT; 
	uiDay 		: UINT; 
	uiHour 		: UINT; 
	uiMinute 	: UINT; 
	uiSecond 	: UINT;	
	uiMsSecond	: UINT;
	S_Time64	: UDINT;
END_VAR
VAR_OUTPUT
END_VAR

# Initialize the file handle and other variables
IF fileHandle = 0 THEN
	datetime := SysTimeGet();
	uiYear := DT_TO_DATE(datetime).Year;
	uiMonth := DT_TO_DATE(datetime).Month;
	uiDay := DT_TO_DATE(datetime).Day;
	uiHour := DT_TO_TIME(datetime).Hour;
	uiMinute := DT_TO_TIME(datetime).Minute;
	uiSecond := DT_TO_TIME(datetime).Second;
	uiMsSecond := DT_TO_TIME(datetime).Millisecond;

	DTimer_Str := concat(INT_TO_STRING(uiYear), '-');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiMonth));
	DTimer_Str := concat(DTimer_Str, '-');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiDay));
	DTimer_Str := concat(DTimer_Str, '_');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiHour));
	DTimer_Str := concat(DTimer_Str, '-');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiMinute));
	DTimer_Str := concat(DTimer_Str, '-');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiSecond));
	DTimer_Str := concat(DTimer_Str, '-');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiMsSecond));

	fileName := concat(filePath, '/');
	fileName := concat(fileName, DTimer_Str);
	fileName := concat(fileName, '.txt');

	fileHandle := SysFileOpen(fileName, 'w');
END_IF