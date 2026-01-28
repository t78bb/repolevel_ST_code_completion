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
SysDirCreate2(filePath1, TRUE);

currentTime := SysTimeGet();
timestamp := DT_TO_STRING(currentTime);
timestamp := REPLACE(timestamp, ':', '-');
timestamp := REPLACE(timestamp, ' ', '_');

fileName := CONCAT(filePath1, '/');
fileName := CONCAT(fileName, timestamp);
fileName := CONCAT(fileName, '.txt');

fileHandle := SysFileOpen(fileName, 'w');
END_FUNCTION_BLOCK
