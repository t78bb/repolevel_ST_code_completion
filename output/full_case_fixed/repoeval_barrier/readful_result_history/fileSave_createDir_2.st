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
// Ensure the directory separator aligns with platform requirements.
filePath1 := CONCAT(filePath1, '/');
// Concatenate device name to form complete directory path.
filePath1 := CONCAT(filePath1, devName);
// Correct the parameter for SysDirCreate2 to adhere to functionality requirements.
SysDirCreate2(filePath1, TRUE); // Set parameter back to TRUE to ensure directory creation if it does not exist.
END_FUNCTION_BLOCK