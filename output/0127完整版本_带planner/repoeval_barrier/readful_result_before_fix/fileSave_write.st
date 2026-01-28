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
	data		: STRING;
	F_err		: DWORD;
	currentTime	: TIME;
	lastSaveTime: TIME;
	timeElapsed	: TIME;
END_VAR

IF filePath = '' THEN
	RETURN;
END_IF;

currentTime := TIME();
timeElapsed := currentTime - lastSaveTime;

IF timeElapsed >= T#1S * intervalt THEN
	lineCount := lineCount + 1;
	lastSaveTime := currentTime;

	data := INT_TO_STRING(lineCount);
	data := CONCAT(data, '$T$T');
	data := CONCAT(data, TIME_TO_STRING(currentTime));
	data := CONCAT(data, '$T$T');
	data := CONCAT(data, INT_TO_STRING(positionInt));
	data := CONCAT(data, '$T$T');
	data := CONCAT(data, INT_TO_STRING(speedInt));
	data := CONCAT(data, '$T$T');
	data := CONCAT(data, INT_TO_STRING(stateInt));
	data := CONCAT(data, '$N');

	fileHandle := FILE.Open(filePath, 'APPEND', F_err);
	IF F_err = 0 THEN
		FILE.Write(fileHandle, ADR(data), LEN(data), F_err);
		FILE.Close(fileHandle, F_err);
	END_IF;
END_IF;
END_FUNCTION_BLOCK
