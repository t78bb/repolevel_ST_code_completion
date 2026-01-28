FUNCTION_BLOCK fileSave
VAR_INPUT
	filePath 	:STRING;
	intervalt	:INT;
	devName		: STRING ;
END_VAR
VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
	currentTime : DT;
	timestamp   : STRING;
	filePath1	: STRING;
END_VAR

filePath1 := filePath;
filePath1 := CONCAT(filePath1, '/');
filePath1 := CONCAT(filePath1, devName);
SysDir.SysDirCreate(filePath1); // Use fully qualified name 'SysDir.SysDirCreate'

currentTime := SysTimeRtc.SysTimeRtcGet(); // Use fully qualified name 'SysTimeRtc.SysTimeRtcGet'
timestamp := DT_TO_STRING(currentTime);
timestamp := REPLACE(timestamp, '-', ':', LEN(timestamp), 1); // Correct 'REPLACE' with realistic length and position
timestamp := REPLACE(timestamp, '_', ' ', LEN(timestamp), 1); // Correct 'REPLACE' with realistic length and position

fileName := CONCAT(filePath1, '/');
fileName := CONCAT(fileName, timestamp);
fileName := CONCAT(fileName, '.txt');

fileHandle := SysFile.SysFileOpen(fileName, AM_WRITE, 0); // Use fully qualified name 'SysFile.SysFileOpen' and correct 'pResult'
END_FUNCTION_BLOCK