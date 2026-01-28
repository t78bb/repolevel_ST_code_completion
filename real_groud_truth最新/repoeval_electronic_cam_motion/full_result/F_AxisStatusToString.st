FUNCTION F_AxisStatusToString : STRING
VAR_INPUT
	fbReadStatus	:	MC_ReadStatus;		//轴状态读取功能块
END_VAR

VAR
	statusString	:	STRING;
END_VAR

statusString := '';

IF fbReadStatus.Valid THEN
	IF fbReadStatus.Errorstop THEN
		statusString := 'Errorstop';
	ELSIF fbReadStatus.Disabled THEN
		statusString := 'Disabled';
	ELSIF fbReadStatus.Standstill THEN
		statusString := 'Standstill';
	ELSIF fbReadStatus.Stopping THEN
		statusString := 'Stopping';
	ELSIF fbReadStatus.Homing THEN
		statusString := 'Homing';
	ELSIF fbReadStatus.Moving THEN
		statusString := 'Moving';
	ELSE
		statusString := 'Unknown';
	END_IF;
ELSE
	statusString := 'Invalid Status';
END_IF;

F_AxisStatusToString := statusString;
END_FUNCTION