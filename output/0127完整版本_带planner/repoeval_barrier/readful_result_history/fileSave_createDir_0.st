FUNCTION_BLOCK fileSave
VAR_INPUT
	filePath 	:STRING;
	devName		: STRING ;
	intervalt	:INT;
END_VAR
VAR
	completePath : STRING;
	dirExists    : BOOL;
	result       : BOOL;
END_VAR

completePath := CONCAT(filePath, '/');
completePath := CONCAT(completePath, devName);

dirExists := SysDirExists(completePath);

IF NOT dirExists THEN
	result := SysDirCreate2(completePath, TRUE);
	RETURN result;
ELSE
	RETURN TRUE;
END_IF;
END_FUNCTION_BLOCK
