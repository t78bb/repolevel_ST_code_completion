FUNCTION F_AxisStatusToString : STRING
VAR_INPUT
	fbReadStatus	:	MC_ReadStatus;		//轴状态读取功能块
END_VAR
IF NOT fbReadStatus.Enable THEN
	F_AxisStatusToString := 'InvalidStatus';
	RETURN;
END_IF

IF fbReadStatus.Done THEN
	F_AxisStatusToString := 'MotionCompleted';
	RETURN;
END_IF

IF fbReadStatus.MotionActive THEN
	F_AxisStatusToString := 'InMotion';
	RETURN;
END_IF

IF fbReadStatus.ErrorActive THEN
	F_AxisStatusToString := 'ErrorState';
	RETURN;
END_IF

IF fbReadStatus.StandStill THEN
	F_AxisStatusToString := 'StandStill';
	RETURN;
END_IF

F_AxisStatusToString := 'UnknownStatus';
RETURN;
END_FUNCTION
