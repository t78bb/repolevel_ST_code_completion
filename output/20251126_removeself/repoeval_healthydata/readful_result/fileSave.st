VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
	data		: STRING;
	F_err		: DWORD;
	tempInt		: INT;
	datetime	: DATE_AND_TIME;
	UdIntms 	: UDINT;
	UdMsOffset  : UDINT;
	DTimer_Str  : STRING;
	uiYear 		: UINT; 
	uiMonth 	: UINT; 
	uiDay 		: UINT; 
	uiHour 		: UINT; 
	uiMinute 	: UINT; 
	uiSecond 	: UINT;	
	uiMsSecond	: UINT;
END_VAR
VAR_OUTPUT
END_VAR

// Initialize file handle and line count
fileHandle := 0;
lineCount := 0;

// Create or open the file
fileName := concat(filePath, '/data.txt');
fileHandle := SysFileOpen(fileName, 'w+');

// Check if the file was opened successfully
IF fileHandle <> 0 THEN
	// Write header to the file
	data := 'LineCount$T$TTime$T$TPosition$T$TSpeed$T$TState';
	SysFileWrite(fileHandle, ADR(data), LEN(data), F_err);
	
	// Initialize datetime
	datetime := SysTimeGet();
	UdIntms := SysTimeGetMs();
	
	// Main loop to write data
	WHILE TRUE DO
		// Increment line count and calculate time
		lineCount := lineCount + 1;
		tempInt := lineCount * intervalt;
		
		// Format data string
		data := INT_TO_STRING(lineCount);
		data := concat(data, '$T$T');
		data := concat(data, INT_TO_STRING(tempInt));
		data := concat(data, '$T$T');
		data := concat(data, INT_TO_STRING(positionInt));
		data := concat(data, '$T$T');
		data := concat(data, INT_TO_STRING(speedInt));
		data := concat(data, '$T$T');
		data := concat(data, INT_TO_STRING(stateInt));
		
		// Write data to file
		SysFileWrite(fileHandle, ADR(data), LEN(data), F_err);
		
		// Delay for the specified interval
		SysDelay(intervalt);
	END_WHILE;
	
	// Close the file when done
	SysFileClose(fileHandle);
	fileHandle := 0;
END_IF