VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
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
END_VAR
VAR_OUTPUT
END_VAR

IF fileHandle = 0 THEN
	datetime := SysTimeGetDateAndTime();
	uiYear := DT_TO_DATE(datetime).year;
	uiMonth := DT_TO_DATE(datetime).month;
	uiDay := DT_TO_DATE(datetime).day;
	uiHour := DT_TO_TIME(datetime).hour;
	uiMinute := DT_TO_TIME(datetime).minute;
	uiSecond := DT_TO_TIME(datetime).second;
	uiMsSecond := DT_TO_TIME(datetime).millisecond;

	DTimer_Str := concat(INT_TO_STRING(uiYear), '_');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiMonth));
	DTimer_Str := concat(DTimer_Str, '_');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiDay));
	DTimer_Str := concat(DTimer_Str, '_');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiHour));
	DTimer_Str := concat(DTimer_Str, '_');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiMinute));
	DTimer_Str := concat(DTimer_Str, '_');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiSecond));

	fileName := concat(filePath, '/');
	fileName := concat(fileName, DTimer_Str);
	fileName := concat(fileName, '.txt');

	fileHandle := SysFileOpen(fileName, 'w', F_err);
	IF F_err <> 0 THEN
		fileHandle := 0;
	END_IF;
END_IF;