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