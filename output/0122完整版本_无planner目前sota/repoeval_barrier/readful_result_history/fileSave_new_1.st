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
	filePath1	: STRING;
	currentTime : TIME;
	timestamp   : STRING;
END_VAR

filePath1 := filePath;
filePath1 := CONCAT(filePath1, '/');
filePath1 := CONCAT(filePath1, devName);
// Corrected SysDirCreate2 call as per its definition, ensuring the directory name is passed correctly.
SysDirCreate2(szDir := ADR(filePath1), xRecursive := TRUE);

// Corrected time retrieval using SysTimeRtcGet function.
SysTimeRtcGet(pTime := currentTime);

// Added manual conversion from TIME to STRING to handle the timestamp logic.
timestamp := CONCAT(SysTimeRtcConvert(currentTime), '');

// Corrected SysFileOpen function call to include a third parameter for pResult.
fileName := CONCAT(filePath1, '/');
fileName := CONCAT(fileName, timestamp);
fileName := CONCAT(fileName, '.txt');
fileHandle := SysFileOpen(szFile := ADR(fileName), am := AM_WRITE, pResult := ADR(resultCode));
IF fileHandle = 0 THEN
  RETURN;
END_IF;
END_FUNCTION_BLOCK