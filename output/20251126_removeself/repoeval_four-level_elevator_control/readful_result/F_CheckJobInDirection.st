VAR
	i				:	USINT;		//循环变量
	bJobFound		:	BOOL := FALSE;	//是否找到任务
END_VAR

// 检查电梯运行方向上的任务
IF bIncreasing THEN
	// 向上检查（递增）
	FOR i := nStartFloor TO nEndFloor DO
		IF IGoFloor[i] OR IFloorUp[i] OR (i > 1 AND IFloorDown[i]) THEN
			bJobFound := TRUE;
			EXIT; // 找到任务后退出循环
		END_IF
	END_FOR
ELSE
	// 向下检查（递减）
	FOR i := nStartFloor TO nEndFloor BY -1 DO
		IF IGoFloor[i] OR (i < MaxNumFloor AND IFloorUp[i]) OR IFloorDown[i] THEN
			bJobFound := TRUE;
			EXIT; // 找到任务后退出循环
		END_IF
	END_FOR
END_IF

// 返回是否找到任务
F_CheckJobInDirection := bJobFound;