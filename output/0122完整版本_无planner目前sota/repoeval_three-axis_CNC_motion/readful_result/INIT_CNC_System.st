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

fbSMC_ReadNCFile(bExecute := FALSE);
fbSMC_NCDecoder(bExecute := FALSE, ncprog := fbSMC_ReadNCFile.ncprog);
fbSMC_CheckVelocities(bExecute := FALSE);
fbSMC_Interpolator(bExecute := FALSE);

fbSMC_AXISX_HOMING(bExecute := FALSE, Axis := AxisX);
fbSMC_AXISY_HOMING(bExecute := FALSE, Axis := AxisY);
fbSMC_AXISZ_HOMING(bExecute := FALSE, Axis := AxisZ);

fbMC_AXISX_STOP(bExecute := FALSE, Axis := AxisX);
fbMC_AXISY_STOP(bExecute := FALSE, Axis := AxisY);
fbMC_AXISZ_STOP(bExecute := FALSE, Axis := AxisZ);

bInitSuccess := TRUE;
RETURN bInitSuccess;
END_FUNCTION
