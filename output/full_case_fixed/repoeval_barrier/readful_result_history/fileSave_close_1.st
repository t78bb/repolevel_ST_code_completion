FUNCTION_BLOCK fileSave
VAR_INPUT
	filePath 	:STRING;
	intervalt	:INT;
END_VAR
VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
END_VAR

VAR_OUTPUT
END_VAR

IF fileHandle <> 0 THEN
  fileHandle := 0; // Closing the file is implied by resetting the fileHandle.
END_IF
END_FUNCTION_BLOCK