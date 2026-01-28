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
	bInitSuccess : BOOL;
END_VAR

// Reset G-code processing related function blocks
fbSMC_ReadNCFile(bExecute := FALSE);
fbSMC_NCDecoder(bExecute := FALSE, ncprog := fbSMC_ReadNCFile.ncprog);
fbSMC_CheckVelocities(bExecute := FALSE);
fbSMC_Interpolator(bExecute := FALSE);

// Stop all axes
fbMC_AXISX_STOP(Axis := AxisX, Execute := TRUE);
fbMC_AXISY_STOP(Axis := AxisY, Execute := TRUE);
fbMC_AXISZ_STOP(Axis := AxisZ, Execute := TRUE);

// Perform homing for all axes
fbSMC_AXISX_HOMING(Axis := AxisX, Execute := TRUE);
fbSMC_AXISY_HOMING(Axis := AxisY, Execute := TRUE);
fbSMC_AXISZ_HOMING(Axis := AxisZ, Execute := TRUE);

// Check if initialization was successful
bInitSuccess := fbMC_AXISX_STOP.Done AND fbMC_AXISY_STOP.Done AND fbMC_AXISZ_STOP.Done AND
                fbSMC_AXISX_HOMING.Done AND fbSMC_AXISY_HOMING.Done AND fbSMC_AXISZ_HOMING.Done;

RETURN bInitSuccess;
END_FUNCTION
