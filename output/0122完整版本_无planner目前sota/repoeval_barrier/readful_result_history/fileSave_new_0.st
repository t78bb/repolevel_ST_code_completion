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
	filePath1	: STRING;
	currentTime : TIME;
	timestamp   : STRING;
END_VAR

filePath1 := filePath;
filePath1 := CONCAT(filePath1, '/');
filePath1 := CONCAT(filePath1, devName);
SysDirCreate2(filePath1, TRUE);

currentTime := SysTimeGet();
timestamp := SysTimeToString(currentTime, '%Y%m%d_%H%M%S');
fileName := CONCAT(filePath1, '/');
fileName := CONCAT(fileName, timestamp);
fileName := CONCAT(fileName, '.txt');

fileHandle := SysFileOpen(fileName, 'w');
IF fileHandle = 0 THEN
	RETURN;
END_IF;
END_FUNCTION_BLOCK
