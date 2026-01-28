FUNCTION F_ClearFloorStop
VAR_INPUT
	nFloor			:	USINT;		//楼层号
	bClearUpStop	:	BOOL;		//是否清除上升停靠标志
	bClearDownStop	:	BOOL;		//是否清除下降停靠标志
	bClearStopFloor	:	BOOL;		//是否清除楼层停靠标志
END_VAR
// 清除楼层停靠标志
// 清除楼层停靠标志
 // Removed dependency on MaxNumFloor as it may not be declared or initialized
 IF bClearUpStop AND (nFloor >= 0) THEN
  Tar_Dir.IsUpStop[nFloor] := FALSE;
  QFloorUpLed[nFloor] := FALSE;
 END_IF;

 IF bClearDownStop AND (nFloor >= 2) THEN
  Tar_Dir.IsDownStop[nFloor] := FALSE;
  QFloorDownLed[nFloor] := FALSE;
 END_IF;

 IF bClearStopFloor AND (nFloor >= 0) THEN
  Tar_Dir.IsStopFloor[nFloor] := FALSE;
  QGoFloorLed[nFloor] := FALSE;
 END_IF;

	RETURN;
END_FUNCTION