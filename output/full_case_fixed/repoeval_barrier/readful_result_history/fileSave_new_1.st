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
	timestamp	: STRING;
END_VAR

filePath1 := filePath;
filePath1 := CONCAT(filePath1, '/');
filePath1 := CONCAT(filePath1, devName);
SysDirCreate2(filePath1, TRUE);

// Correctly convert timestamp to a STRING using proper function
timestamp := SysTimeRtcConvert(SysTimeRtcGetTimestamp());
fileName := CONCAT(filePath1, '/');
fileName := CONCAT(fileName, timestamp);
fileName := CONCAT(fileName, '.txt');

// Fixed file mode argument using DOUBLE single quotes ('w' -> ''w'')
fileHandle := SysFileOpen(fileName, ''w'');
IF fileHandle = 0 THEN
  RETURN;
END_IF;
END_FUNCTION_BLOCK