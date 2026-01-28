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
