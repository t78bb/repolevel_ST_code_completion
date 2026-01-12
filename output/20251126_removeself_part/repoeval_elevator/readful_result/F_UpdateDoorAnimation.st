VAR_OUTPUT
	nUpdatedAni		:	DINT;		// 更新后的动画值
END_VAR
VAR
	bDoorMoving		:	BOOL;		// 门正在移动
END_VAR

// 初始化输出值
nUpdatedAni := nCurrentAni;

// 检查是否需要开门
IF bOpenDoor AND NOT bDoorMoving THEN
	bDoorMoving := TRUE;
	IF nCurrentAni < nMaxAni THEN
		nUpdatedAni := nCurrentAni + 1; // 增加动画值
	ELSE
		bDoorMoving := FALSE; // 动画达到最大值，停止移动
	END_IF
END_IF

// 检查是否需要关门
IF bCloseDoor AND NOT bDoorMoving THEN
	bDoorMoving := TRUE;
	IF nCurrentAni > 0 THEN
		nUpdatedAni := nCurrentAni - 1; // 减少动画值
	ELSE
		bDoorMoving := FALSE; // 动画达到最小值，停止移动
	END_IF
END_IF

// 如果有楼层呼叫且门未完全打开，保持门打开
IF bCallFloor AND nCurrentAni < nMaxAni THEN
	nUpdatedAni := nMaxAni;
END_IF

// 返回更新后的动画值
RETURN nUpdatedAni;