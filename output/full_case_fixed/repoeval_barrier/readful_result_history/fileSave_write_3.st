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
	fileHandle := FILE.Open(filePath, 'WRITE', F_err);
	IF F_err <> 0 THEN
		RETURN;
	END_IF;
END_IF;

lineCount := lineCount + 1;
tempInt := lineCount * intervalt;

data := INT_TO_STRING(lineCount);
data := CONCAT(data, CHAR(9) + CHAR(9)); // Replace '$T$T' with two tab characters (CHAR(9))
data := CONCAT(data, INT_TO_STRING(tempInt));
IF tempInt < 1000 THEN
  data := CONCAT(data, CHAR(9)); // Replace '$T' with a single tab character (CHAR(9))
END_IF;
data := CONCAT(data, CHAR(9) + CHAR(9)); // Replace '$T$T' with two tab characters
data := CONCAT(data, INT_TO_STRING(positionInt));
data := CONCAT(data, CHAR(9) + CHAR(9)); // Replace '$T$T' with two tab characters
data := CONCAT(data, INT_TO_STRING(speedInt));
data := CONCAT(data, CHAR(9) + CHAR(9)); // Replace '$T$T' with two tab characters
data := CONCAT(data, INT_TO_STRING(stateInt));
data := CONCAT(data, CHAR(10)); // Replace '$N' with a newline character (CHAR(10))

FILE.Write(fileHandle, ADR(data), LEN(data), F_err); // Write the updated string to the file
IF F_err <> 0 THEN
	FILE.Close(fileHandle, F_err);
	fileHandle := 0;
	RETURN;
END_IF;

RETURN;
END_FUNCTION_BLOCK