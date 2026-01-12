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

VAR_OUTPUT
	bInitSuccess			:	BOOL;
	bError					:	BOOL;
	sSystem_Error			:	STRING;
END_VAR

VAR
	ErrorID					:	UINT;
END_VAR

// Initialize CNC system
bInitSuccess := FALSE;
bError := FALSE;

// Perform homing for Axis X
fbSMC_AXISX_HOMING(
	bExecute := TRUE,
	Axis := AxisX
);
IF fbSMC_AXISX_HOMING.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_AXISX_HOMING.iErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	RETURN FALSE;
END_IF

// Perform homing for Axis Y
fbSMC_AXISY_HOMING(
	bExecute := TRUE,
	Axis := AxisY
);
IF fbSMC_AXISY_HOMING.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_AXISY_HOMING.iErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	RETURN FALSE;
END_IF

// Perform homing for Axis Z
fbSMC_AXISZ_HOMING(
	bExecute := TRUE,
	Axis := AxisZ
);
IF fbSMC_AXISZ_HOMING.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_AXISZ_HOMING.iErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	RETURN FALSE;
END_IF

// Check velocities for all axes
fbSMC_CheckVelocities(
	bExecute := TRUE,
	AxisX := AxisX,
	AxisY := AxisY,
	AxisZ := AxisZ
);
IF fbSMC_CheckVelocities.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_CheckVelocities.iErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	RETURN FALSE;
END_IF

// Initialize interpolator
fbSMC_Interpolator(
	bExecute := TRUE,
	dOverride := 1.0,
	poqDataIn := fbSMC_ReadNCFile.poqPath,
	dwIpoTime := 10,
	bEmergency_Stop := FALSE
);
IF fbSMC_Interpolator.bError THEN
	bError := TRUE;
	SMC_ERRORSTRING(ErrorID := fbSMC_Interpolator.wErrorID, Language := english, SMC_ErrorString => sSystem_Error);
	RETURN FALSE;
END_IF

// Initialization successful
bInitSuccess := TRUE;
RETURN TRUE;