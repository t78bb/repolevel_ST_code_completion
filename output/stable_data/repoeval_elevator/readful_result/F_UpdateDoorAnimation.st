VAR
	nNextAni		:	DINT;		// 下一个动画值
END_VAR

// 初始化下一个动画值为当前动画值
nNextAni := nCurrentAni;

// 如果开门命令有效且动画值未达到最大值，则增加动画值
IF bOpenDoor AND (nCurrentAni < nMaxAni) THEN
	nNextAni := nCurrentAni + 1;

// 如果关门命令有效且动画值大于0，则减少动画值
ELSIF bCloseDoor AND (nCurrentAni > 0) THEN
	nNextAni := nCurrentAni - 1;

// 如果当前楼层有呼叫且动画值为0，则开始开门动画
ELSIF bCallFloor AND (nCurrentAni = 0) THEN
	nNextAni := nCurrentAni + 1;
END_IF;

// 返回下一个动画值
F_UpdateDoorAnimation := nNextAni;
RETURN;