FUNCTION_BLOCK fileSave
VAR_INPUT
	filePath 	:STRING;
	intervalt	:INT;
	devName		: STRING ;
END_VAR
VAR
	lineCount	: INT;
	fileHandle  : DWORD;
	fileName	: STRING;
	timestamp	: STRING;
	fullPath	: STRING;
	isValidPath	: BOOL;
END_VAR

timestamp := SysTimeGetTimestamp(TRUE); // Step 1: Get current system time and generate timestamp
fileName := concat(timestamp, '_', devName); // Step 2: Generate file name by combining timestamp and devName
fullPath := concat(filePath, '/', fileName); // Step 3: Construct full file path

isValidPath := SysFileCheckPath(fullPath, FILE_WRITE); // Step 4: Check if file path is valid and writable

IF isValidPath THEN
	fileHandle := SysFileOpen(fullPath, 'w'); // Step 5: Open the file for writing
	IF fileHandle <> 0 THEN
		lineCount := 0; // Initialize line count
		// Step 6: File write logic based on intervalt parameter will be implemented during actual write operations
	ELSE
		fileHandle := 0; // Handle error in opening file
	END_IF;
END_IF;
END_FUNCTION_BLOCK
