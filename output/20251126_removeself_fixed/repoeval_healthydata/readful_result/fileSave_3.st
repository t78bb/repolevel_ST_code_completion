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

IF fileHandle = 0 THEN
	(* Create a new file or open an existing one *)
	fileName := concat(filePath, 'dataLog.txt');
	fileHandle := SysFileOpen(fileName := fileName, mode := 'WRITE_APPEND', error := F_err);
	IF F_err <> 0 THEN
		(* Handle file open error *)
		SysLog('Error opening file: ' + fileName);
		RETURN;
	END_IF;
END_IF;

(* Write data to the file *)
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

SysFileWrite(hFile := fileHandle, data := data, error := F_err);
IF F_err <> 0 THEN
	(* Handle file write error *)
	SysLog('Error writing to file: ' + fileName);
END_IF;

(* Close the file if necessary *)
IF lineCount >= 100 THEN
	SysFileClose(hFile := fileHandle);
	fileHandle := 0;
END_IF;