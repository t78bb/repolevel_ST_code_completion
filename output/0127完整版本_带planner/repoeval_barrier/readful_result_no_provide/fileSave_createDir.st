VAR
	completePath : STRING;
	dirExists    : BOOL;
	result       : BOOL;
END_VAR

completePath := CONCAT(filePath, '/');
completePath := CONCAT(completePath, devName);

// Removed SysDirExists as it is not defined and redundant with SysDirCreate2 logic.

IF NOT dirExists THEN
result := SysDirCreate2(completePath, TRUE); // Store SysDirCreate2's return code in 'result' (RTS_IEC_RESULT).
IF result = 0 THEN // Check if the directory was created successfully (0 implies success).
 RETURN;
ELSE
 RETURN;
END_IF;
ELSE
RETURN;
END_IF;
END_FUNCTION_BLOCK