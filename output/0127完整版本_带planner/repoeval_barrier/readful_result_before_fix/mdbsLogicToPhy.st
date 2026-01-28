FUNCTION_BLOCK mdbsLogicToPhy	//modbus华中挡板地址编号对应本地索引编号
VAR_INPUT
	section		:INT;	//区域限定 1:skyExt, 2:skyRet, 3:grdExt, 4:grdRet)
	lgcIdx		:INT;	//华中对应的地址	10,14{1..10}  17,20{1..11}
END_VAR
VAR_OUTPUT
	level		:INT;	//1->地轨	2->天轨
	phyIdx		:INT;	//内存物理地址对应数组索引
	direct		:TargetDirect;
END_VAR
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
