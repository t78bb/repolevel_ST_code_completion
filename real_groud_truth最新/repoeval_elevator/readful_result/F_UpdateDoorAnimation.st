VAR_OUTPUT
	nUpdatedAni		:	DINT;		// 更新后的动画值
END_VAR
VAR
	nStep			:	DINT := 5;	// 动画步长
END_VAR

// 检查是否需要开门动画
IF bOpenDoor THEN
	IF nCurrentAni < nMaxAni THEN
		nUpdatedAni := nCurrentAni + nStep; // 增加动画值
	ELSE
		nUpdatedAni := nMaxAni; // 达到最大动画值
	END_IF;
ELSIF bCloseDoor THEN
	IF nCurrentAni > 0 THEN
		nUpdatedAni := nCurrentAni - nStep; // 减少动画值
	ELSE
		nUpdatedAni := 0; // 达到最小动画值
	END_IF;
ELSE
	// 如果没有开门或关门命令，保持当前动画值
	nUpdatedAni := nCurrentAni;
END_IF;

// 返回更新后的动画值
RETURN nUpdatedAni;