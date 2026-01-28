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
	tempDescription : STRING;
	tempValue : REAL;
END_VAR

tempDescription := 'Basic Object';
tempValue := 0.0;

sDescription := tempDescription;
rValue := tempValue;

CreateObject := TRUE;
RETURN;
END_FUNCTION_BLOCK
