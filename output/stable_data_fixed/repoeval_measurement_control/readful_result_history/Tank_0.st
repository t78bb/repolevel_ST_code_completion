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
    nCurrentLevel: INT;
    nCurrentTemp: INT;
END_VAR

nCurrentLevel := nUnitLevel;
nCurrentTemp := nUnitTemp;

IF nCurrentLevel > nMaxLevel THEN
    nCurrentLevel := nMaxLevel;
ELSIF nCurrentLevel < nMinLevel THEN
    nCurrentLevel := nMinLevel;
END_IF;

IF nCurrentTemp > nMaxTemp THEN
    nCurrentTemp := nMaxTemp;
ELSIF nCurrentTemp < nMinTemp THEN
    nCurrentTemp := nMinTemp;
END_IF;

END_FUNCTION_BLOCK
