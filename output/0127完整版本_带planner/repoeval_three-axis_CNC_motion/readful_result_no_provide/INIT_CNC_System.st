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
