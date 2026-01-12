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