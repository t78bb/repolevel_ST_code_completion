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
		statusString := 'Error Stop';
	ELSIF fbReadStatus.Disabled THEN
		statusString := 'Disabled';
	ELSIF fbReadStatus.Standstill THEN
		statusString := 'Standstill';
	ELSIF fbReadStatus.Homing THEN
		statusString := 'Homing';
	ELSIF fbReadStatus.Stopping THEN
		statusString := 'Stopping';
	ELSIF fbReadStatus.ConstantVelocity THEN
		statusString := 'Constant Velocity';
	ELSIF fbReadStatus.Accelerating THEN
		statusString := 'Accelerating';
	ELSIF fbReadStatus.Decelerating THEN
		statusString := 'Decelerating';
	ELSIF fbReadStatus.Synchronous THEN
		statusString := 'Synchronous';
	ELSE
		statusString := 'Unknown Status';
	END_IF;
ELSE
	statusString := 'Invalid Status';
END_IF;

RETURN statusString;