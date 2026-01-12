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

// Initialize the file save process
STT(SystemTime := S_Time64, TimeDate := S_Time);

// Create the directory if it doesn't exist
filePath := concat(filePath, '/');
filePath := concat(filePath, devName);
SysDirCreate2(filePath, TRUE);

// Generate a unique filename based on the current date and time
uiYear := S_Time.uiYear;
uiMonth := S_Time.uiMonth;
uiDay := S_Time.uiDay;
uiHour := S_Time.uiHour;
uiMinute := S_Time.uiMinute;
uiSecond := S_Time.uiSecond;

fileName := concat(INT_TO_STRING(uiYear), '_');
fileName := concat(fileName, INT_TO_STRING(uiMonth));
fileName := concat(fileName, '_');
fileName := concat(fileName, INT_TO_STRING(uiDay));
fileName := concat(fileName, '_');
fileName := concat(fileName, INT_TO_STRING(uiHour));
fileName := concat(fileName, '_');
fileName := concat(fileName, INT_TO_STRING(uiMinute));
fileName := concat(fileName, '_');
fileName := concat(fileName, INT_TO_STRING(uiSecond));
fileName := concat(fileName, '.txt');

// Open the file for writing
fileHandle := SysFileOpen(concat(filePath, '/', fileName), 'w', F_err);

// Check if the file was successfully opened
IF fileHandle = 0 THEN
	// Handle the error (e.g., log it or raise an exception)
	RETURN;
END_IF;

// Initialize line count
lineCount := 0;

// File save process is now ready