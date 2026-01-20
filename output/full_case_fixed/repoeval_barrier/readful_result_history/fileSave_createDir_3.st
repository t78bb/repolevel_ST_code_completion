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
// Replace directory separator '/' with '\' if running on a Windows-based system.
// Ensure the directory separator aligns with platform requirements.
filePath1 := CONCAT(filePath1, '/');
// Concatenate device name to form complete directory path.
filePath1 := CONCAT(filePath1, devName);
// Ensure SysDirCreate2 is invoked using a properly formatted absolute path.
SysDirCreate2(filePath1, TRUE); // Confirm parameter is TRUE for directory creation if it does not exist.
END_FUNCTION_BLOCK