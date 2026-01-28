VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
	filePath1	: STRING;
END_VAR

filePath1 := filePath;
filePath1 := CONCAT(filePath1, '/');
filePath1 := CONCAT(filePath1, devName);
SysDirCreate2(filePath1, TRUE);
END_FUNCTION_BLOCK
