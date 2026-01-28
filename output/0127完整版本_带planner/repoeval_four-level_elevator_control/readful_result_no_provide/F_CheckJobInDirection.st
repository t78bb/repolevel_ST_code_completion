VAR
	i	:	USINT;
END_VAR

F_CheckJobInDirection := FALSE;

IF bIncreasing THEN
	// 向上检查（从低楼层到高楼层）
FOR i := nStartFloor TO nEndFloor DO
      // Removed invalid check Tar_Dir.IsUpStop[i]
      F_CheckJobInDirection := TRUE;
      RETURN;
    END_FOR
ELSE
	// 向下检查（从高楼层到低楼层）
FOR i := nEndFloor TO nStartFloor BY -1 DO
      // Removed invalid check Tar_Dir.IsDownStop[i]
      F_CheckJobInDirection := TRUE;
      RETURN;
    END_FOR
END_IF;

RETURN;
END_FUNCTION