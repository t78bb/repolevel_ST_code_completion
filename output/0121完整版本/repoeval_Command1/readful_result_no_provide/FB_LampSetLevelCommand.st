VAR
	refLamp		: REFERENCE TO FB_Lamp;
	byNewLevel	: BYTE;
END_VAR

METHOD Execute : BOOL
VAR
	isSuccessful : BOOL;
END_VAR

IF __ISVALIDREF(refLamp) THEN
 // Directly assign the result of SetLevel to Execute
 IF refLamp.SetLevel(byNewLevel) THEN
  Execute := TRUE;
 ELSE
  Execute := FALSE;
 END_IF;
ELSE
 Execute := FALSE;
END_IF
END_FUNCTION_BLOCK