FUNCTION F_UpdateLimitSwitches : BOOL
VAR_INPUT
	rTankLevel			:	REAL;			// 当前液位 (%)
	rFullThreshold		:	REAL := 85.0;	// 满液位阈值 (%)
	rEmptyThreshold		:	REAL := 5.0;	// 空液位阈值 (%)
END_VAR
VAR_OUTPUT
	bLevelFull			:	BOOL;			// 液位满开关
	bLevelEmpty			:	BOOL;			// 液位空开关
END_VAR

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

END_FUNCTION
