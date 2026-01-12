uiMinute 	: UINT; 
	uiSecond 	: UINT;	
	uiMsSecond	: UINT;
END_VAR
VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
	fileHandle0 : DWORD;
	datetime	: DATE_AND_TIME;
	UdIntms 	: UDINT;
	UdMsOffset  : UDINT;
	DTimer_Str  : STRING;
	S_Time64	: SysTime64;
	STT			: CurTimeEx;
	S_Time		: SystemTimeDate;
	Time_Str	: STRING;
	F_err		: DWORD;
	F_HANDL		: DWORD;
END_VAR
VAR_OUTPUT
END_VAR

// Initialize the file creation process
STT(SystemTime := S_Time64, TimeDate := S_Time);
datetime := S_Time.DateTime;
uiYear := S_Time.Year;
uiMonth := S_Time.Month;
uiDay := S_Time.Day;
uiHour := S_Time.Hour;
uiMinute := S_Time.Minute;
uiSecond := S_Time.Second;
uiMsSecond := S_Time.MilliSecond;

// Construct the file name using the current date and time
fileName := concat(filePath, '/');
fileName := concat(fileName, devName);
fileName := concat(fileName, '_');
fileName := concat(fileName, UINT_TO_STRING(uiYear));
fileName := concat(fileName, '-');
fileName := concat(fileName, UINT_TO_STRING(uiMonth));
fileName := concat(fileName, '-');
fileName := concat(fileName, UINT_TO_STRING(uiDay));
fileName := concat(fileName, '_');
fileName := concat(fileName, UINT_TO_STRING(uiHour));
fileName := concat(fileName, '-');
fileName := concat(fileName, UINT_TO_STRING(uiMinute));
fileName := concat(fileName, '-');
fileName := concat(fileName, UINT_TO_STRING(uiSecond));
fileName := concat(fileName, '.txt');

// Open or create the file
fileHandle := SysFileOpen(FileName := fileName, Mode := 'w', Error := F_err);
IF F_err <> 0 THEN
	// Handle file open error
	RETURN;
END_IF;

// Reset line count
lineCount := 0;