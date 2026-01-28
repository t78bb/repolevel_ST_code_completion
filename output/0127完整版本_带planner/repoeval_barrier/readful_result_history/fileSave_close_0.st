FUNCTION_BLOCK fileSave
VAR_INPUT
	filePath 	:STRING;
	intervalt	:INT;
END_VAR
VAR
	isFileClosed : BOOL;
END_VAR

IF filePath = '' THEN
	RETURN;
END_IF;

IF fileHandle <> 0 THEN
	isFileClosed := SysFileClose(hFile := fileHandle);
	IF isFileClosed THEN
		fileHandle := 0;
	END_IF;
END_IF;

RETURN;
END_FUNCTION_BLOCK
