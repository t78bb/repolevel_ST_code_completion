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
// Adjust SysDirCreate2 call to handle creation properly based on file path.
SysDirCreate2(filePath1, FALSE); // Replace TRUE with FALSE to handle cases where directory creation only happens if not existent.
END_FUNCTION_BLOCK