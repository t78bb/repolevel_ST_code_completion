FUNCTION F_ClearFloorStop
VAR_INPUT
	nFloor			:	USINT;		//楼层号
	bClearUpStop	:	BOOL;		//是否清除上升停靠标志
	bClearDownStop	:	BOOL;		//是否清除下降停靠标志
	bClearStopFloor	:	BOOL;		//是否清除楼层停靠标志
END_VAR
IF (nFloor >= 1) AND (nFloor <= MaxNumFloor) THEN
 IF bClearUpStop AND (nFloor <= MaxNumFloor - 1) THEN
  IF nFloor < UpperBound(Tar_Dir.IsUpStop) THEN // Correct bounds check for IsUpStop array
   Tar_Dir.IsUpStop[nFloor] := FALSE;
   QFloorUpLed[nFloor] := FALSE;
  END_IF;
 END_IF;

 IF bClearDownStop AND (nFloor >= 2) THEN
  IF nFloor < UpperBound(Tar_Dir.IsDownStop) THEN // Correct bounds check for IsDownStop array
   Tar_Dir.IsDownStop[nFloor] := FALSE;
   QFloorDownLed[nFloor] := FALSE;
  END_IF;
 END_IF;

 IF bClearStopFloor THEN
  IF nFloor < UpperBound(Tar_Dir.IsStopFloor) THEN // Correct bounds check for IsStopFloor array
   Tar_Dir.IsStopFloor[nFloor] := FALSE;
   QGoFloorLed[nFloor] := FALSE;
  END_IF;
 END_IF;
END_IF;
RETURN;
END_FUNCTION