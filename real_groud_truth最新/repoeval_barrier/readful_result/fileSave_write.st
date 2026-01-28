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

# Check if the file handle is valid
IF fileHandle = 0 THEN
	# Attempt to open the file for writing
	fileHandle := SysFileOpen(filePath, 'w', F_err);
	IF F_err <> 0 THEN
		# Handle file open error
		RETURN;
	END_IF;
END_IF;

# Increment the line count and calculate the time interval
lineCount := lineCount + 1;
tempInt := lineCount * intervalt;

# Construct the data string
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

# Write the data to the file
SysFileWrite(hFile := fileHandle, pData := ADR(data), size := SIZEOF(data), F_err);
IF F_err <> 0 THEN
	# Handle file write error
	RETURN;
END_IF;

# Optionally close the file if needed
IF lineCount >= 100 THEN
	SysFileClose(hFile := fileHandle);
	fileHandle := 0;
END_IF;