VAR
	isOddSection : BOOL;
	isSkySection : BOOL;
	isValidIdx   : BOOL;
END_VAR

isOddSection := (section MOD 2) = 1;
isSkySection := (section = 1) OR (section = 2);

IF isSkySection THEN
	level := 2; // 天轨
	isValidIdx := (lgcIdx >= 1) AND (lgcIdx <= 10);
ELSE
	level := 1; // 地轨
	isValidIdx := (lgcIdx >= 1) AND (lgcIdx <= 11);
END_IF;

IF isOddSection THEN
	direct := TargetDirect.extend;
ELSE
	direct := TargetDirect.retract;
END_IF;

IF isValidIdx THEN
	phyIdx := lgcIdx - 1;
ELSE
	phyIdx := -1; // 默认值表示匹配失败
END_IF;
END_FUNCTION_BLOCK
