{attribute 'enable_dynamic_creation'}
//This class creates the most basic object well called. This object is to be decorated
FUNCTION_BLOCK ConcreteComponent IMPLEMENTS Component_Interface
VAR_INPUT
END_VAR
VAR_OUTPUT
END_VAR
VAR
	sDescription : STRING;
	rValue : REAL;
END_VAR

METHOD CreateObject : BOOL
VAR
	bSuccess : BOOL;
END_VAR

bSuccess := FALSE;

IF sDescription = '' THEN
	sDescription := 'Default Description';
END_IF;

IF rValue = 0.0 THEN
	rValue := 1.0;
END_IF;

bSuccess := TRUE;

CreateObject := bSuccess;
END_FUNCTION_BLOCK
