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

structured-text
METHOD CheckTankStatus : BOOL
VAR_INPUT
    nCurrentLevel : INT;
    nCurrentTemp  : INT;
END_VAR
VAR
    bLevelInRange : BOOL;
    bTempInRange  : BOOL;
END_VAR

// Check if the current level is within the defined range
bLevelInRange := (nCurrentLevel >= nMinLevel) AND (nCurrentLevel <= nMaxLevel);

// Check if the current temperature is within the defined range
bTempInRange := (nCurrentTemp >= nMinTemp) AND (nCurrentTemp <= nMaxTemp);

// Return TRUE if both level and temperature are within range, otherwise FALSE
CheckTankStatus := bLevelInRange AND bTempInRange;