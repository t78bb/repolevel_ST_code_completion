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

IF (bLevel) THEN
 IF (nUnitLevel < nMaxLevel) THEN // Ensure nUnitLevel does not exceed nMaxLevel
  nUnitLevel := nUnitLevel + 1;
 END_IF;
ELSE
 IF (nUnitLevel > nMinLevel) THEN // Ensure nUnitLevel does not go below nMinLevel
  nUnitLevel := nUnitLevel - 1;
 END_IF;
END_IF;

IF (nUnitTemp > nMaxTemp) THEN
  bTemp := FALSE;
ELSIF (nUnitTemp < nMinTemp) THEN
  bTemp := TRUE;
END_IF;

IF (bTemp) THEN
 IF (nUnitTemp < nMaxTemp) THEN // Ensure nUnitTemp does not exceed nMaxTemp
  nUnitTemp := nUnitTemp + 1;
 END_IF;
ELSE
 IF (nUnitTemp > nMinTemp) THEN // Ensure nUnitTemp does not go below nMinTemp
  nUnitTemp := nUnitTemp - 1;
 END_IF;
END_IF;
END_FUNCTION_BLOCK