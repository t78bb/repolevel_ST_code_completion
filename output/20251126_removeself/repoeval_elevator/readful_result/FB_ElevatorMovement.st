VAR
	nCurrentTarget		:	INT;				// 当前目标楼层
	nState				:	INT;				// 状态机
END_VAR

CASE nState OF
	0: // 空闲状态
		bMovingUp := FALSE;
		bMovingDown := FALSE;
		bArrivedAtTarget := FALSE;
		
		// 查找下一个目标楼层
		FOR i := 0 TO 3 DO
			IF TargetFloors[i] THEN
				nCurrentTarget := i;
				nState := 1; // 开始移动
				EXIT;
			END_IF
		END_FOR
		
	1: // 移动到目标楼层
		IF CurrentFloor < nCurrentTarget THEN
			bMovingUp := TRUE;
			bMovingDown := FALSE;
		ELSIF CurrentFloor > nCurrentTarget THEN
			bMovingUp := FALSE;
			bMovingDown := TRUE;
		ELSE
			bMovingUp := FALSE;
			bMovingDown := FALSE;
			bArrivedAtTarget := TRUE;
			TargetFloors[nCurrentTarget] := FALSE; // 清除目标楼层
			nState := 0; // 返回空闲状态
		END_IF
		
		// 检查门是否准备好
		IF bDoorReady THEN
			IF bMovingUp THEN
				CurrentFloor := CurrentFloor + 1;
			ELSIF bMovingDown THEN
				CurrentFloor := CurrentFloor - 1;
			END_IF
		END_IF
END_CASE