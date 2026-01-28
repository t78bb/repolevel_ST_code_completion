FUNCTION F_CheckJobInDirection : BOOL
VAR_INPUT
	nStartFloor		:	USINT;		//起始楼层
	nEndFloor		:	USINT;		//结束楼层
	bIncreasing		:	BOOL;		//TRUE=向上检查（递增），FALSE=向下检查（递减）
END_VAR

VAR
	i				:	USINT;		//循环变量
	bJobExists		:	BOOL;		//是否存在任务
END_VAR

// 初始化任务存在标志
bJobExists := FALSE;

// 根据检查方向进行任务检查
IF bIncreasing THEN
	// 向上检查任务
	FOR i := nStartFloor TO nEndFloor DO
		IF IGoFloor[i] OR IFloorUp[i] THEN
			bJobExists := TRUE;
			EXIT; // 找到任务后退出循环
		END_IF
	END_FOR;
ELSE
	// 向下检查任务
	FOR i := nStartFloor TO nEndFloor BY -1 DO
		IF IGoFloor[i] OR IFloorDown[i] THEN
			bJobExists := TRUE;
			EXIT; // 找到任务后退出循环
		END_IF
	END_FOR;
END_IF;

// 返回任务存在标志
RETURN bJobExists;
END_FUNCTION