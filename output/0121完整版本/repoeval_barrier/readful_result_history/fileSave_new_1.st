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
SysDirCreate(filePath1, TRUE); // Use 'SysDirCreate' which is a valid function in Codesys

currentTime := SysTimeRtcGet(); // Use 'SysTimeRtcGet' for retrieving the current date and time
timestamp := DT_TO_STRING(currentTime);
timestamp := REPLACE(timestamp, '-', ':', 255, 1); // Corrected 'REPLACE' function for ':' -> '-'
timestamp := REPLACE(timestamp, '_', ' ', 255, 1); // Corrected 'REPLACE' function for ' ' -> '_'

fileName := CONCAT(filePath1, '/');
fileName := CONCAT(fileName, timestamp);
fileName := CONCAT(fileName, '.txt');

fileHandle := SysFileOpen(fileName, AM_WRITE, 0); // Corrected 'SysFileOpen': Added 'AM_WRITE' and '0' for pResult.
END_FUNCTION_BLOCK