VAR
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

	S_Time64		: SysTime64;
	STT				: CurTimeEx;
	S_Time			: SystemTimeDate;
	Time_Str		: STRING;
	F_err			: DWORD;
	F_HANDL			: DWORD;
END_VAR
VAR_OUTPUT
END_VAR

STT(SystemTime := S_Time64, TimeDate := S_Time);

IF fileHandle = 0 THEN
	datetime := SysTimeGetDateAndTime();
	uiYear := datetime.YEAR;
	uiMonth := datetime.MONTH;
	uiDay := datetime.DAY;
	uiHour := datetime.HOUR;
	uiMinute := datetime.MINUTE;
	uiSecond := datetime.SECOND;
	uiMsSecond := datetime.MILLISECOND;

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
	DTimer_Str := concat(DTimer_Str, '_');
	DTimer_Str := concat(DTimer_Str, INT_TO_STRING(uiMsSecond));

	fileName := concat(filePath, '/');
	fileName := concat(fileName, devName);
	fileName := concat(fileName, '_');
	fileName := concat(fileName, DTimer_Str);
	fileName := concat(fileName, '.txt');

	F_HANDL := SysFileOpen(fileName, 'w', F_err);
	IF F_err = 0 THEN
		fileHandle := F_HANDL;
		lineCount := 0;
	ELSE
		fileHandle := 0;
	END_IF;
END_IF;