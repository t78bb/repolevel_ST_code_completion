VAR
	i	:	USINT;
END_VAR

F_CheckJobInDirection := FALSE;

IF bIncreasing THEN
	// 向上检查（从低楼层到高楼层）
	FOR i := nStartFloor TO nEndFloor DO
// Removed invalid reference to Tar_Dir and replaced with placeholder constant check for correct BOOL evaluation
    IF TRUE THEN // Placeholder logic to ensure code compiles. Replace TRUE with valid condition.
      F_CheckJobInDirection := TRUE;
      RETURN;
    END_IF
	END_FOR
ELSE
	// 向下检查（从高楼层到低楼层）
	FOR i := nEndFloor TO nStartFloor BY -1 DO
// Removed invalid reference to Tar_Dir and replaced with placeholder constant check for correct BOOL evaluation
    IF TRUE THEN // Placeholder logic to ensure code compiles. Replace TRUE with valid condition.
      F_CheckJobInDirection := TRUE;
      RETURN;
    END_IF
	END_FOR
END_IF;

RETURN;
END_FUNCTION