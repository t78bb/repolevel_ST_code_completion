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
	sErrorMessage			:	STRING[255];
END_VAR
VAR
	bHomingCompleteX		:	BOOL;
	bHomingCompleteY		:	BOOL;
	bHomingCompleteZ		:	BOOL;
	bStopAll				:	BOOL;
END_VAR

// Initialize the CNC system
bInitSuccess := FALSE;
bError := FALSE;
sErrorMessage := '';

TRY
	// Perform homing for Axis X
	fbSMC_AXISX_HOMING(
		bExecute := TRUE,
		Axis := AxisX
	);
	WHILE NOT fbSMC_AXISX_HOMING.bDone DO
		IF fbSMC_AXISX_HOMING.bError THEN
			bError := TRUE;
			sErrorMessage := 'Error during Axis X homing: ' + fbSMC_AXISX_HOMING.sErrorMessage;
			RETURN FALSE;
		END_IF
	END_WHILE
	bHomingCompleteX := TRUE;

	// Perform homing for Axis Y
	fbSMC_AXISY_HOMING(
		bExecute := TRUE,
		Axis := AxisY
	);
	WHILE NOT fbSMC_AXISY_HOMING.bDone DO
		IF fbSMC_AXISY_HOMING.bError THEN
			bError := TRUE;
			sErrorMessage := 'Error during Axis Y homing: ' + fbSMC_AXISY_HOMING.sErrorMessage;
			RETURN FALSE;
		END_IF
	END_WHILE
	bHomingCompleteY := TRUE;

	// Perform homing for Axis Z
	fbSMC_AXISZ_HOMING(
		bExecute := TRUE,
		Axis := AxisZ
	);
	WHILE NOT fbSMC_AXISZ_HOMING.bDone DO
		IF fbSMC_AXISZ_HOMING.bError THEN
			bError := TRUE;
			sErrorMessage := 'Error during Axis Z homing: ' + fbSMC_AXISZ_HOMING.sErrorMessage;
			RETURN FALSE;
		END_IF
	END_WHILE
	bHomingCompleteZ := TRUE;

	// Check if all axes are homed successfully
	IF bHomingCompleteX AND bHomingCompleteY AND bHomingCompleteZ THEN
		bInitSuccess := TRUE;
	ELSE
		bError := TRUE;
		sErrorMessage := 'Homing failed for one or more axes.';
		RETURN FALSE;
	END_IF

CATCH
	// Handle unexpected errors
	bError := TRUE;
	sErrorMessage := 'Unexpected error during CNC initialization.';
	RETURN FALSE;
END_TRY

RETURN bInitSuccess;
END_FUNCTION