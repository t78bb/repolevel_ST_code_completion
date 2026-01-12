VAR
	bFullConditionMet	:	BOOL;
	bEmptyConditionMet	:	BOOL;
END_VAR

// 检查液位是否达到满液位阈值
bFullConditionMet := rTankLevel >= rFullThreshold;

// 检查液位是否达到空液位阈值
bEmptyConditionMet := rTankLevel <= rEmptyThreshold;

// 更新输出状态
bLevelFull := bFullConditionMet;
bLevelEmpty := bEmptyConditionMet;

// 返回TRUE表示函数执行成功
F_UpdateLimitSwitches := TRUE;
RETURN;