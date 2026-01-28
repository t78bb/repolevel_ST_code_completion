FUNCTION_BLOCK Tank
VAR_INPUT
	stName: STRING;
	nMaxLevel	: INT;
	nMinLevel	: INT;
	nMaxTemp	: INT;
	nMinTemp	: INT;
	nUnitLevel							:INT:=0;
	nUnitTemp							:INT:=0;
END_VAR
VAR_OUTPUT
END_VAR
VAR
	name								:STRING;
	bLevel								:BOOL;
	bTemp								:BOOL;
END_VAR

name := stName;

IF (nUnitLevel > nMaxLevel) THEN
	nUnitLevel := nMaxLevel;
	bLevel := FALSE;
ELSIF (nUnitLevel < nMinLevel) THEN
	nUnitLevel := nMinLevel;
	bLevel := TRUE;
END_IF

IF (nUnitTemp > nMaxTemp) THEN
	nUnitTemp := nMaxTemp;
	bTemp := FALSE;
ELSIF (nUnitTemp < nMinTemp) THEN
	nUnitTemp := nMinTemp;
	bTemp := TRUE;
END_IF
END_FUNCTION_BLOCK
