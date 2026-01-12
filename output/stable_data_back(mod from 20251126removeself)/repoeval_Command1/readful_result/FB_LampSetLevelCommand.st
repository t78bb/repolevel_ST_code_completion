VAR
    refLamp : REFERENCE TO FB_Lamp; // Reference to the lamp object
    byNewLevel : BYTE;             // New brightness level to set
END_VAR

METHOD PUBLIC Execute : BOOL
VAR
    bSuccess : BOOL; // Indicates if the operation was successful
END_VAR

// Check if the lamp reference is valid
IF (__ISVALIDREF(refLamp)) THEN
    // Set the new brightness level for the lamp
    bSuccess := refLamp.SetLevel(byNewLevel);
    RETURN bSuccess; // Return the success status
ELSE
    // If the lamp reference is invalid, return FALSE
    RETURN FALSE;
END_IF