FUNCTION_BLOCK CommandExecutor
VAR_INPUT
	level		:INT;			//1->地轨	2->天轨
	idx			:INT;			//挡板索引编号
	percent		:REAL;			//比例阀百分比 传入-100~+100
END_VAR
VAR_OUTPUT
END_VAR
VAR
	convertedValue : WORD;    //用于存储转换后的比例阀指令值
END_VAR

IF percent > 100 THEN
	percent := 100; //限制最大值为100
ELSIF percent < -100 THEN
	percent := -100; //限制最小值为-100
END_IF

convertedValue := REAL_TO_WORD(ABS(percent) * 65535 / 100); //将百分比值转换为比例阀指令值

IF percent > 0 THEN
	CASE level OF
		1: //地轨
			gController.grd[idx].extendPercent := convertedValue;
			gController.grd[idx].retractPercent := 0;
		2: //天轨
			gController.sky[idx].extendPercent := convertedValue;
			gController.sky[idx].retractPercent := 0;
	END_CASE
ELSE
	CASE level OF
		1: //地轨
			gController.grd[idx].extendPercent := 0;
			gController.grd[idx].retractPercent := convertedValue;
		2: //天轨
			gController.sky[idx].extendPercent := 0;
			gController.sky[idx].retractPercent := convertedValue;
	END_CASE
END_IF
END_FUNCTION_BLOCK
