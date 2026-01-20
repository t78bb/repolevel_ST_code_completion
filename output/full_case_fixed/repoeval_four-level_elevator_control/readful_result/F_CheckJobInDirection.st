FUNCTION F_CheckJobInDirection : BOOL
VAR_INPUT
	nStartFloor		:	USINT;		//起始楼层
	nEndFloor		:	USINT;		//结束楼层
	bIncreasing		:	BOOL;		//TRUE=向上检查（递增），FALSE=向下检查（递减）
END_VAR
VAR
	i	:	USINT;
END_VAR

F_CheckJobInDirection := FALSE;

IF bIncreasing THEN
	// 向上检查（从低楼层到高楼层）
	FOR i := nStartFloor TO nEndFloor DO
		IF Tar_Dir.IsStopFloor[i] THEN
			F_CheckJobInDirection := TRUE;
			RETURN;
		END_IF
	END_FOR
ELSE
	// 向下检查（从高楼层到低楼层）
i := nEndFloor; // Initialize i to nEndFloor
WHILE i >= nStartFloor DO // Simplify logic by removing unnecessary bounds check; `USINT` naturally limits to 255
 IF Tar_Dir.IsStopFloor[i] THEN
  F_CheckJobInDirection := TRUE;
  RETURN;
 END_IF
 IF i = 0 THEN // Check explicitly for underflow
  EXIT; // Exit the loop if `i` reaches its lower bound (0)
 ELSE
  i := i - 1; // Decrement safely within valid range
 END_IF
END_WHILE
END_IF

RETURN;
END_FUNCTION