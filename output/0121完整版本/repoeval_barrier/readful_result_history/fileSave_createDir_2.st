FUNCTION_BLOCK fileSave
VAR_INPUT
	filePath 	:STRING;
	devName		: STRING ;
	intervalt	:INT;
END_VAR
VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
	filePath1	:STRING;
END_VAR

filePath1 := filePath;
filePath1 := CONCAT(filePath1, '/');
filePath1 := CONCAT(filePath1, devName);

// Ensure the SysDir library is added to the project and the ADR() function is used correctly to reference the STRING
IF SysDirCreate2(ADR(filePath1), TRUE) <> ERR_OK THEN
  // Handle error if directory creation fails
  RETURN;
END_IF;
END_FUNCTION_BLOCK