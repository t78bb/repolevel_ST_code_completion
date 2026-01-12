FUNCTION_BLOCK SetAxisLimits
VAR_IN_OUT
	AxisGroup : AXIS_GROUP_REF_SM3;
END_VAR
VAR_INPUT
	Execute : BOOL;
	AxisLimits : ARRAY[0..SMC_RCNST.MAX_AXES-1] OF AxisLimits;
END_VAR
VAR_OUTPUT
	Done : BOOL;
	Error : BOOL;
	ErrorID : SMC_ERROR;
END_VAR
VAR
	state : INT := IDLE_STATE;
	
	groupDisable : MC_GroupDisable;
	groupEnable : MC_GroupEnable;
	groupStatus : MC_GroupReadStatus;
	groupReadConfig : MC_GroupReadConfiguration;
	changeDynamicLimits : SMC_ChangeDynamicLimits;
	
	currentAxis : IDENT_IN_GROUP_REF_SM3;
	oldExecute : BOOL;
END_VAR
VAR CONSTANT
	IDLE_STATE : INT := 0;
	CHECK_STATE : INT := 10;
	DISABLE_STATE : INT := 20;
	READ_CONFIG_STATE : INT := 30;
	CHANGE_DYNAMIC_LIMIT_STATE : INT := 40;
	PREPARE_NEXT_AXIS_STATE : INT := 50;
	ENABLE_STATE : INT := 60;
	DONE_STATE : INT := 100;
	ERROR_STATE : INT := 1000;
END_VAR

IF Execute AND_THEN NOT oldExecute THEN
	state := CHECK_STATE;
	currentAxis := 0;
	ErrorID := SMC_NO_ERROR;
ELSIF NOT Execute
	AND_THEN (state = DONE_STATE OR_ELSE state = ERROR_STATE)
THEN
	state := IDLE_STATE;
	ErrorID := SMC_NO_ERROR;
END_IF

CASE state OF
	CHECK_STATE:
		IF groupStatus.Valid AND_THEN groupStatus.GroupStandby THEN
			state := DISABLE_STATE;
		ELSIF groupStatus.Valid THEN
			state := READ_CONFIG_STATE;
		END_IF
	
	DISABLE_STATE:
		groupDisable.Execute := TRUE;
		
		IF groupDisable.Done THEN
			groupDisable.Execute := FALSE;
			state := READ_CONFIG_STATE;
		ELSIF groupDisable.Error THEN
			groupDisable.Execute := FALSE;
			state := ERROR_STATE;
			ErrorID := groupDisable.ErrorID;
		END_IF
	
	READ_CONFIG_STATE:
		groupReadConfig(
			AxisGroup:= AxisGroup,
			Enable:= TRUE,
			IdentInGroup:= currentAxis);
		
		IF groupReadConfig.Valid THEN
			state := CHANGE_DYNAMIC_LIMIT_STATE;
		ELSIF groupReadConfig.Error THEN
			state := ERROR_STATE;
			ErrorID := groupReadConfig.ErrorID;
		END_IF
	
	CHANGE_DYNAMIC_LIMIT_STATE:
		changeDynamicLimits(
			Axis:= groupReadConfig.pAxis^,
			bExecute:= TRUE,
			fMaxVelocity:= AxisLimits[currentAxis].maxVelocity,
			fMaxAcceleration:= AxisLimits[currentAxis].maxAcceleration,
			fMaxDeceleration:= AxisLimits[currentAxis].maxDeceleration,
			fMaxJerk:= AxisLimits[currentAxis].maxJerk,
			fMaxTorque:= AxisLimits[currentAxis].maxTorque);
		
		IF changeDynamicLimits.bDone THEN
			changeDynamicLimits(Axis:= groupReadConfig.pAxis^, bExecute:= FALSE);
			state := PREPARE_NEXT_AXIS_STATE;
		ELSIF changeDynamicLimits.bError THEN
			state := ERROR_STATE;
			ErrorID := changeDynamicLimits.ErrorID;
			changeDynamicLimits(Axis:= groupReadConfig.pAxis^, bExecute:= FALSE);
		END_IF
	
	PREPARE_NEXT_AXIS_STATE:
		currentAxis := currentAxis + 1;
		
		IF currentAxis < groupReadConfig.NumAxes THEN
			state := READ_CONFIG_STATE;
		ELSE
			state := ENABLE_STATE;
		END_IF
	
	ENABLE_STATE:
		groupEnable.Execute := TRUE;
		
		IF groupEnable.Done THEN
			groupEnable.Execute := FALSE;
			state := DONE_STATE;
		ELSIF groupEnable.Error THEN
			groupEnable.Execute := FALSE;
			state := ERROR_STATE;
			ErrorID := groupEnable.ErrorID;
		END_IF
END_CASE

groupDisable(AxisGroup:= AxisGroup);
groupEnable(AxisGroup:= AxisGroup);
groupStatus(AxisGroup:= AxisGroup, Enable:= TRUE);

Done := state = DONE_STATE;
Error := state = ERROR_STATE;

oldExecute := Execute;