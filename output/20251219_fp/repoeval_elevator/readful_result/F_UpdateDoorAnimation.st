VAR
	nNextAni		:	DINT;		// 下一个动画值
END_VAR

IF bOpenDoor THEN
	// 开门动画
	IF nCurrentAni < nMaxAni THEN
		nNextAni := nCurrentAni + 1;
	ELSE
		nNextAni := nMaxAni; // 动画达到最大值
	END_IF;
ELSIF bCloseDoor THEN
	// 关门动画
	IF nCurrentAni > 0 THEN
		nNextAni := nCurrentAni - 1;
	ELSE
		nNextAni := 0; // 动画达到最小值
	END_IF;
ELSE
	// 保持当前动画值
	nNextAni := nCurrentAni;
END_IF;

F_UpdateDoorAnimation := nNextAni;