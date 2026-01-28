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
SysDirCreate(filePath1); // Removed prefix 'SysDir' as it caused unrecognized identifier errors

currentTime := SysTimeRtcGet(); // Removed prefix 'SysTimeRtc' to resolve unrecognized identifier issues
timestamp := DT_TO_STRING(currentTime);
timestamp := REPLACE(timestamp, '-', ':', 10, 1); // Corrected REPLACE with static length value as LEN() may not be used here
timestamp := REPLACE(timestamp, '_', ' ', 10, 1); // Corrected REPLACE with static length value as LEN() may not be used here

fileName := CONCAT(filePath1, '/');
fileName := CONCAT(fileName, timestamp);
fileName := CONCAT(fileName, '.txt');

fileHandle := SysFileOpen(fileName, AM_WRITE, 0); // Removed prefix 'SysFile' to resolve unrecognized identifier issues
END_FUNCTION_BLOCK