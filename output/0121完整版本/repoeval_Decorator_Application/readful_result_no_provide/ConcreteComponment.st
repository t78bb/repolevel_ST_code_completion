VAR
  sDescription : STRING;
  rValue : REAL;
END_VAR

// Move the METHOD declaration into the FUNCTION_BLOCK header
METHOD CreateObject : BOOL;

END_FUNCTION_BLOCK // NOTE: Close FUNCTION_BLOCK

// Create separated METHOD implementation
METHOD CreateObject : BOOL
VAR
  bSuccess : BOOL;
END_VAR

bSuccess := FALSE;

IF sDescription = '' THEN
  sDescription := 'Default Description'; // Default initialization
END_IF;

IF rValue = 0.0 THEN
  rValue := 1.0; // Real initialization
END_IF;

bSuccess := TRUE;

CreateObject := bSuccess; // Assign output to method return
END_METHOD