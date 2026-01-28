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
fbSMC_ReadNCFile(bExecute := FALSE);
fbSMC_ReadNCFile(bExecute := TRUE);

fbSMC_NCDecoder(bExecute := FALSE, ncprog := fbSMC_ReadNCFile.ncprog);
fbSMC_NCDecoder(bExecute := TRUE, ncprog := fbSMC_ReadNCFile.ncprog);

fbSMC_CheckVelocities(bExecute := FALSE);
fbSMC_CheckVelocities(bExecute := TRUE);

fbSMC_Interpolator(bExecute := FALSE);
fbSMC_Interpolator(bExecute := TRUE);

fbSMC_ControlAxisXByPos(bExecute := FALSE, Axis := AxisX);
fbSMC_ControlAxisXByPos(bExecute := TRUE, Axis := AxisX);

fbSMC_ControlAxisYByPos(bExecute := FALSE, Axis := AxisY);
fbSMC_ControlAxisYByPos(bExecute := TRUE, Axis := AxisY);

fbSMC_ControlAxisZByPos(bExecute := FALSE, Axis := AxisZ);
fbSMC_ControlAxisZByPos(bExecute := TRUE, Axis := AxisZ);

fbSMC_AXISX_HOMING(bExecute := FALSE, Axis := AxisX);
fbSMC_AXISX_HOMING(bExecute := TRUE, Axis := AxisX);

fbSMC_AXISY_HOMING(bExecute := FALSE, Axis := AxisY);
fbSMC_AXISY_HOMING(bExecute := TRUE, Axis := AxisY);

fbSMC_AXISZ_HOMING(bExecute := FALSE, Axis := AxisZ);
fbSMC_AXISZ_HOMING(bExecute := TRUE, Axis := AxisZ);

fbMC_AXISX_STOP(bExecute := FALSE, Axis := AxisX);
fbMC_AXISX_STOP(bExecute := TRUE, Axis := AxisX);

fbMC_AXISY_STOP(bExecute := FALSE, Axis := AxisY);
fbMC_AXISY_STOP(bExecute := TRUE, Axis := AxisY);

fbMC_AXISZ_STOP(bExecute := FALSE, Axis := AxisZ);
fbMC_AXISZ_STOP(bExecute := TRUE, Axis := AxisZ);

RETURN := TRUE;
END_FUNCTION
