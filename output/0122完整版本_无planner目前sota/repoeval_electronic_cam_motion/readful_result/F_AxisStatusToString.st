FUNCTION F_AxisStatusToString : STRING
VAR_INPUT
	fbReadStatus	:	MC_ReadStatus;		//轴状态读取功能块
END_VAR
IF fbReadStatus.Errorstop THEN
	F_AxisStatusToString := 'Errorstop';
	RETURN;
END_IF

IF fbReadStatus.Disabled THEN
	F_AxisStatusToString := 'Disabled';
	RETURN;
END_IF

IF fbReadStatus.Homing THEN
	F_AxisStatusToString := 'Homing';
	RETURN;
END_IF

IF fbReadStatus.Stopping THEN
	F_AxisStatusToString := 'Stopping';
	RETURN;
END_IF

IF fbReadStatus.SynchronizedMotion THEN
	F_AxisStatusToString := 'SynchronizedMotion';
	RETURN;
END_IF

IF fbReadStatus.ContinuousMotion THEN
	F_AxisStatusToString := 'ContinuousMotion';
	RETURN;
END_IF

IF fbReadStatus.Standstill THEN
	F_AxisStatusToString := 'Standstill';
	RETURN;
END_IF

F_AxisStatusToString := 'Unknown';
RETURN;
END_FUNCTION
