//Illustrative method of the pattern
METHOD getDescription : STRING
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
    isInitialized : BOOL;
    description : STRING;
END_VAR

IF NOT isInitialized THEN
    RETURN ''; // Return an empty string if the object is not initialized
END_IF;

description := CONCAT('Object Description: ', THIS^.sDescription);
RETURN description;
END_OTHER
