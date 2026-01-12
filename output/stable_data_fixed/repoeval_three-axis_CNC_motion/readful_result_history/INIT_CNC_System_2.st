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

fbSMC_ReadNCFile(Execute := TRUE);
// Fixed the parameter name from `bExecute` to `Execute`, matching the function prototype.
IF fbSMC_ReadNCFile.Error THEN
// Fixed field name `bError` to `Error`, conforming to library field standards.
  bError := TRUE;
  SMC_ERRORSTRING(ErrorID := fbSMC_ReadNCFile.ErrorID, Language := english, SMC_ErrorString => sSystem_Error);
// Corrected `wErrorID` to `ErrorID` in accordance with library specifications.
  INIT_CNC_System := FALSE;
  RETURN;
END_IF

fbSMC_NCDecoder(Execute := fbSMC_ReadNCFile.ExecuteDecoder, poqDataIn := fbSMC_ReadNCFile.poqNCData);
// Updated `bExecute` to `Execute` and `bExecuteDecoder` to `ExecuteDecoder` for accuracy.
IF fbSMC_NCDecoder.Error THEN
// Changed `bError` to `Error` as per function block specifications.
  bError := TRUE;
  SMC_ERRORSTRING(ErrorID := fbSMC_NCDecoder.ErrorID, Language := english, SMC_ErrorString => sSystem_Error);
// Revised `wErrorID` to `ErrorID`.
  INIT_CNC_System := FALSE;
  RETURN;
END_IF

fbSMC_CheckVelocities(Execute := TRUE, AxisX := AxisX, AxisY := AxisY, AxisZ := AxisZ);
// Adjusted `bExecute` to `Execute` to match expected input.
IF fbSMC_CheckVelocities.Error THEN
// Fixed `bError` to `Error` for correct field usage.
  bError := TRUE;
  SMC_ERRORSTRING(ErrorID := fbSMC_CheckVelocities.ErrorID, Language := english, SMC_ErrorString => sSystem_Error);
// Changed `wErrorID` to `ErrorID`.
  INIT_CNC_System := FALSE;
  RETURN;
END_IF

fbSMC_AXISX_HOMING(Execute := TRUE, Axis := AxisX);
// Corrected `bExecute` to `Execute`.
IF fbSMC_AXISX_HOMING.Error THEN
// Replaced `bError` with `Error`.
  bError := TRUE;
  SMC_ERRORSTRING(ErrorID := fbSMC_AXISX_HOMING.ErrorID, Language := english, SMC_ErrorString => sSystem_Error);
// Revised `wErrorID` to `ErrorID`.
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

fbMC_AXISX_STOP(Execute := TRUE, Axis := AxisX);
// Fixed `bExecute` to `Execute`.
IF fbMC_AXISX_STOP.Error THEN
// Altered `bError` to `Error`.
  bError := TRUE;
  SMC_ERRORSTRING(ErrorID := fbMC_AXISX_STOP.ErrorID, Language := english, SMC_ErrorString => sSystem_Error);
// Replaced `wErrorID` with `ErrorID`.
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