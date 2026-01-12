FUNCTION F_AxisStatusToString : STRING
VAR_INPUT
	fbReadStatus	:	MC_ReadStatus;		//轴状态读取功能块
END_VAR

VAR
	sStatusString : STRING;
END_VAR

IF fbReadStatus.Valid THEN
	IF fbReadStatus.Errorstop THEN
		sStatusString := 'Errorstop';
	ELSIF fbReadStatus.Disabled THEN
		sStatusString := 'Disabled';
	ELSIF fbReadStatus.Standstill THEN
		sStatusString := 'Standstill';
	ELSIF fbReadStatus.Stopping THEN
		sStatusString := 'Stopping';
	ELSIF fbReadStatus.Homing THEN
		sStatusString := 'Homing';
	ELSIF fbReadStatus.DiscreteMotion THEN
		sStatusString := 'DiscreteMotion';
	ELSIF fbReadStatus.ContinuousMotion THEN
		sStatusString := 'ContinuousMotion';
	ELSIF fbReadStatus.SynchronizedMotion THEN
		sStatusString := 'SynchronizedMotion';
	ELSE
		sStatusString := 'Unknown';
	END_IF;
ELSE
	sStatusString := 'Invalid';
END_IF;

F_AxisStatusToString := sStatusString;
RETURN;

END_FUNCTION
