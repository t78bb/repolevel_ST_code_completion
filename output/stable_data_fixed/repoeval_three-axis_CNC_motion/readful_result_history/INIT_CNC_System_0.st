FUNCTION INIT_CNC_System : BOOL
VAR_IN_OUT
	fbSMC_ReadNCFile		:	SMC_ReadNCFile;
	fbSMC_NCDecoder			:	SMC_NCDecoder;
	fbSMC_CheckVelocities	:	SMC_CheckVelocities;
	fbSMC_Interpolator		:	SMC_Interpolator;
	fbSMC_ControlAxisXByPos	:	SMC_ControlAxisByPos;
	fbSMC_ControlAxisYByPos	:	SMC_ControlAxisByPos;
	fbSMC_ControlAxisZByPos	:	SMC_ControlAxisByPos;
	fbSMC_AXISX_HOMING		:	SMC_HOMING;
	fbSMC_AXISY_HOMING		:	SMC_HOMING;
	fbSMC_AXISZ_HOMING		:	SMC_HOMING;
	fbMC_AXISX_STOP			:	MC_STOP;
	fbMC_AXISY_STOP			:	MC_STOP;
	fbMC_AXISZ_STOP			:	MC_STOP;
END_VAR
VAR_INPUT
	AxisX					:	SM3_Basic.AXIS_REF_SM3
	AxisY					:	SM3_Basic.AXIS_REF_SM3
	AxisZ					:	SM3_Basic.AXIS_REF_SM3
END_VAR

VAR
	bError : BOOL := FALSE;
	sSystem_Error : STRING;
	ErrorID : UDINT;
END_VAR

fbSMC_ReadNCFile(bExecute := TRUE);
IF fbSMC_ReadNCFile.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_ReadNCFile.wErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	INIT_CNC_System := FALSE;
	RETURN;
END_IF

fbSMC_NCDecoder(bExecute := fbSMC_ReadNCFile.bExecuteDecoder, poqDataIn := fbSMC_ReadNCFile.poqNCData);
IF fbSMC_NCDecoder.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_NCDecoder.wErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	INIT_CNC_System := FALSE;
	RETURN;
END_IF

fbSMC_CheckVelocities(bExecute := TRUE, AxisX := AxisX, AxisY := AxisY, AxisZ := AxisZ);
IF fbSMC_CheckVelocities.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_CheckVelocities.wErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	INIT_CNC_System := FALSE;
	RETURN;
END_IF

fbSMC_AXISX_HOMING(bExecute := TRUE, Axis := AxisX);
IF fbSMC_AXISX_HOMING.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_AXISX_HOMING.wErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	INIT_CNC_System := FALSE;
	RETURN;
END_IF

fbSMC_AXISY_HOMING(bExecute := TRUE, Axis := AxisY);
IF fbSMC_AXISY_HOMING.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_AXISY_HOMING.wErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	INIT_CNC_System := FALSE;
	RETURN;
END_IF

fbSMC_AXISZ_HOMING(bExecute := TRUE, Axis := AxisZ);
IF fbSMC_AXISZ_HOMING.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_AXISZ_HOMING.wErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	INIT_CNC_System := FALSE;
	RETURN;
END_IF

fbMC_AXISX_STOP(bExecute := TRUE, Axis := AxisX);
IF fbMC_AXISX_STOP.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbMC_AXISX_STOP.wErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	INIT_CNC_System := FALSE;
	RETURN;
END_IF

fbMC_AXISY_STOP(bExecute := TRUE, Axis := AxisY);
IF fbMC_AXISY_STOP.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbMC_AXISY_STOP.wErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	INIT_CNC_System := FALSE;
	RETURN;
END_IF

fbMC_AXISZ_STOP(bExecute := TRUE, Axis := AxisZ);
IF fbMC_AXISZ_STOP.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbMC_AXISZ_STOP.wErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	INIT_CNC_System := FALSE;
	RETURN;
END_IF

INIT_CNC_System := TRUE;
RETURN;

END_FUNCTION
