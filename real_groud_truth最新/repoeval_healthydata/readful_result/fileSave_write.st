VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
	data		: STRING;
	F_err		: DWORD;
	tempInt		: INT;
END_VAR
VAR_OUTPUT
END_VAR

# Initialize file handle and line count
IF fileHandle = 0 THEN
	fileHandle := SysFileOpen(filePath, 'w', F_err);
	IF F_err <> 0 THEN
		RETURN;
	END_IF;
	lineCount := 0;
END_IF;

# Write data to the file
lineCount := lineCount + 1;
tempInt := lineCount * intervalt;
data := INT_TO_STRING(lineCount);
data := concat(data, '$T$T');
data := concat(data, INT_TO_STRING(tempInt));
IF tempInt < 1000 THEN
	data := concat(data, '$T');
END_IF;
data := concat(data, '$T$T');
data := concat(data, INT_TO_STRING(positionInt));
data := concat(data, '$T');
data := concat(data, INT_TO_STRING(speedInt));
data := concat(data, '$T');
data := concat(data, INT_TO_STRING(stateInt));
data := concat(data, '$R');

# Write the data string to the file
SysFileWrite(hFile := fileHandle, pBuffer := ADR(data), size := SIZEOF(data), F_err);
IF F_err <> 0 THEN
	SysFileClose(hFile := fileHandle);
	fileHandle := 0;
	RETURN;
END_IF;

# Close the file if necessary
IF lineCount >= 100 THEN
	SysFileClose(hFile := fileHandle);
	fileHandle := 0;
END_IF;
END_FUNCTION_BLOCK