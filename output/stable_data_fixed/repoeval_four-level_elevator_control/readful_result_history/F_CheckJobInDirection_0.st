FUNCTION F_CheckJobInDirection : BOOL
VAR_INPUT
	nStartFloor		:	USINT;		//起始楼层
	nEndFloor		:	USINT;		//结束楼层
	bIncreasing		:	BOOL;		//TRUE=向上检查（递增），FALSE=向下检查（递减）
END_VAR

VAR
    nFloorIndex : USINT; // 楼层索引
END_VAR

// 初始化返回值为FALSE
F_CheckJobInDirection := FALSE;

// 根据检查方向进行楼层遍历
IF bIncreasing THEN
    // 向上检查（递增）
    FOR nFloorIndex := nStartFloor TO nEndFloor DO
        IF IGoFloor[nFloorIndex] OR IFloorUp[nFloorIndex] THEN
            F_CheckJobInDirection := TRUE;
            RETURN;
        END_IF
    END_FOR
ELSE
    // 向下检查（递减）
    FOR nFloorIndex := nStartFloor TO nEndFloor BY -1 DO
        IF IGoFloor[nFloorIndex] OR IFloorDown[nFloorIndex] THEN
            F_CheckJobInDirection := TRUE;
            RETURN;
        END_IF
    END_FOR
END_IF;

// 如果没有找到符合条件的任务，则返回FALSE
RETURN;

END_FUNCTION
