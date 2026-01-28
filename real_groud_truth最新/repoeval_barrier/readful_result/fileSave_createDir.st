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

STT(SystemTime:= S_Time64, TimeDate:= S_Time);

IF fileHandle = 0 THEN
	datetime := SysTimeGetDateAndTime();
	uiYear := datetime.YEAR;
	uiMonth := datetime.MONTH;
	uiDay := datetime.DAY;
	uiHour := datetime.HOUR;
	uiMinute := datetime.MINUTE;
	uiSecond := datetime.SECOND;
	uiMsSecond := datetime.MILLISECOND;

	Time_Str := concat(INT_TO_STRING(uiYear), '-');
	Time_Str := concat(Time_Str, INT_TO_STRING(uiMonth));
	Time_Str := concat(Time_Str, '-');
	Time_Str := concat(Time_Str, INT_TO_STRING(uiDay));
	Time_Str := concat(Time_Str, '_');
	Time_Str := concat(Time_Str, INT_TO_STRING(uiHour));
	Time_Str := concat(Time_Str, '-');
	Time_Str := concat(Time_Str, INT_TO_STRING(uiMinute));
	Time_Str := concat(Time_Str, '-');
	Time_Str := concat(Time_Str, INT_TO_STRING(uiSecond));

	fileName := concat(filePath, '/');
	fileName := concat(fileName, devName);
	fileName := concat(fileName, '_');
	fileName := concat(fileName, Time_Str);
	fileName := concat(fileName, '.txt');

	fileHandle := SysFileOpen(fileName, 'w', F_err);
	IF F_err <> 0 THEN
		fileHandle := 0;
	END_IF;
END_IF;