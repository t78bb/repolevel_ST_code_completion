VAR
	nNewAni			:	DINT;		// 新的动画值
END_VAR

nNewAni := nCurrentAni;

// 开门动画（增加动画值）
IF bOpenDoor AND nNewAni < nMaxAni THEN
	nNewAni := nNewAni + 1;
END_IF

// 关门动画（减少动画值）
IF bCloseDoor AND nNewAni > 0 THEN
	nNewAni := nNewAni - 1;
END_IF

// 楼层呼叫动画（增加动画值）
IF bCallFloor AND nNewAni < nMaxAni THEN
	nNewAni := nNewAni + 1;
END_IF

// 保持动画值不变
IF NOT bCallFloor AND NOT bOpenDoor AND NOT bCloseDoor THEN
	nNewAni := nCurrentAni;
END_IF

F_UpdateDoorAnimation := nNewAni;
END_FUNCTION
