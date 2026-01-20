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
  bLevel := FALSE;
ELSIF (nUnitLevel < nMinLevel) THEN
  bLevel := TRUE;
END_IF;

IF (bLevel AND (nUnitLevel < nMaxLevel)) THEN // Combine conditions for incrementing nUnitLevel
 nUnitLevel := nUnitLevel + 1;
ELSIF (NOT bLevel AND (nUnitLevel > nMinLevel)) THEN // Combine conditions for decrementing nUnitLevel
 nUnitLevel := nUnitLevel - 1;
END_IF;

IF (nUnitTemp > nMaxTemp) THEN
  bTemp := FALSE;
ELSIF (nUnitTemp < nMinTemp) THEN
  bTemp := TRUE;
END_IF;

IF (bTemp AND (nUnitTemp < nMaxTemp)) THEN // Combine conditions for incrementing nUnitTemp
 nUnitTemp := nUnitTemp + 1;
ELSIF (NOT bTemp AND (nUnitTemp > nMinTemp)) THEN // Combine conditions for decrementing nUnitTemp
 nUnitTemp := nUnitTemp - 1;
END_IF;
END_FUNCTION_BLOCK