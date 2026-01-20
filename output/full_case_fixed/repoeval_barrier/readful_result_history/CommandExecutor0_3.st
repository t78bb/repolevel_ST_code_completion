FUNCTION_BLOCK CommandExecutor0
VAR_INPUT
	level		:INT;			//1->地轨	2->天轨
	idx			:INT;			//挡板索引编号
	direct		:TargetDirect;	//方向
	percent		:REAL;			//比例阀百分比 传入0-100
END_VAR
VAR_OUTPUT
END_VAR
VAR
END_VAR

CASE direct OF
  TargetDirect.extend:
    CASE level OF
      1:
IF (idx >= 0) AND (idx < SIZEOF(gController.grd)) THEN
 IF (percent >= 0) AND (percent <= 100) THEN
  gController.grd[idx].extendPercent := REAL_TO_WORD(LIMIT(0, percent, 100) * 65535 / 100);
  gController.grd[idx].retractPercent := 0;
 ELSE
  gController.grd[idx].extendPercent := 0; // Resetting for safety
  gController.grd[idx].retractPercent := 0;
 END_IF;
END_IF;
      2:
IF (idx >= 0) AND (idx < SIZEOF(gController.sky)) THEN
 IF (percent >= 0) AND (percent <= 100) THEN
  gController.sky[idx].extendPercent := REAL_TO_WORD(LIMIT(0, percent, 100) * 65535 / 100);
  gController.sky[idx].retractPercent := 0;
 ELSE
  gController.sky[idx].extendPercent := 0; // Resetting for safety
  gController.sky[idx].retractPercent := 0;
 END_IF;
END_IF;
    END_CASE
  TargetDirect.retract:
    CASE level OF
      1:
        IF (idx >= 0) AND (idx < SIZEOF(gController.grd)) THEN
          IF (percent >= 0) AND (percent <= 100) THEN
            gController.grd[idx].extendPercent := 0;
            gController.grd[idx].retractPercent := REAL_TO_WORD(percent * 65535 / 100);
          END_IF;
        END_IF;
      2:
        IF (idx >= 0) AND (idx < SIZEOF(gController.sky)) THEN
          IF (percent >= 0) AND (percent <= 100) THEN
            gController.sky[idx].extendPercent := 0;
            gController.sky[idx].retractPercent := REAL_TO_WORD(percent * 65535 / 100);
          END_IF;
        END_IF;
    END_CASE
END_CASE
END_FUNCTION_BLOCK