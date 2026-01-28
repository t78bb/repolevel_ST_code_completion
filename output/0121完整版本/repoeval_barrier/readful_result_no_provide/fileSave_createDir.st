VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
	filePath1	:STRING;
END_VAR

filePath1 := filePath;
filePath1 := CONCAT(filePath1, '/');
filePath1 := CONCAT(filePath1, devName);

// Ensure the SysDir library is added to the project and verify the return value of the function
IF SysDirCreate2(ADR(filePath1), TRUE) <> 0 THEN
 // Handle error if directory creation fails
 RETURN;
END_IF;
END_FUNCTION_BLOCK