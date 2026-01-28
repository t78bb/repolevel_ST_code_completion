FUNCTION_BLOCK fileSave
VAR_INPUT
	filePath 	:STRING;
	intervalt	:INT;
	positionInt 	:INT;
	speedInt 		:INT;
	stateInt		:INT;
END_VAR
VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
	data		: STRING;
	F_err		: DWORD;
	tempInt		: INT;
END_VAR

IF fileHandle = 0 THEN
fileHandle := SysFileOpen(filePath, AM_APPEND, F_err); // Correct access mode for appending content
END_IF

IF fileHandle <> 0 THEN
	lineCount := lineCount + 1;
	tempInt := lineCount * intervalt;
	data := INT_TO_STRING(lineCount);
	data := CONCAT(data, '$T$T');
	data := CONCAT(data, INT_TO_STRING(tempInt));
	IF tempInt < 1000 THEN
		data := CONCAT(data, '$T');
	END_IF
	data := CONCAT(data, '$T$T');
	data := CONCAT(data, INT_TO_STRING(positionInt));
	data := CONCAT(data, '$T$T');
	data := CONCAT(data, INT_TO_STRING(speedInt));
	data := CONCAT(data, '$T$T');
	data := CONCAT(data, INT_TO_STRING(stateInt));
	data := CONCAT(data, '$N');

SysFileWrite(fileHandle, ADR(data), LEN(data), F_err); // Correct method for writing data to a file
END_IF
END_FUNCTION_BLOCK