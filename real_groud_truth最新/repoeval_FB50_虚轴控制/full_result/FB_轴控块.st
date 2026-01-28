FUNCTION_BLOCK FB_轴控块
VAR_INPUT
	Enable: BOOL;
	
	JogFor: BOOL;
	JogBack: BOOL;		
	JogVelocity :LREAL;
	
	StopExcute: BOOL;
	ResetExcute: BOOL;
	
	AbsExcute: BOOL;	
	AbsPosition: LREAL;
	AbsVelocity: LREAL;
	AbsAcceleration: LREAL;
	AbsDeceleration: LREAL;
	
	RelExcute: BOOL;
	RelPosition: LREAL;
	RelVelocity: LREAL;
	RelAcceleration: LREAL;
	RelDeceleration: LREAL;
	
	VelExcute: BOOL;
	VelVelocity: LREAL;
	
    InchForward: BOOL;
	InchBackward: BOOL;	
	InchDistance: LREAL;
	InchVelocity: LREAL;
	InchAcceleration: LREAL;
	InchDeceleration: LREAL;
	
	SetPosExcute: BOOL;

	ReStartSlaveEx: BOOL;
END_VAR
VAR_OUTPUT
	EnableStatus: BOOL;
	StopDone: BOOL;
	AbsDone: BOOL;
	RelDone: BOOL;
	VelBusy: BOOL;	
	InchBusy: BOOL;
	JogBusy: BOOL;
	AbsBusy: BOOL;
	RelBusy: BOOL;
	AxisStandstill: BOOL;
	AxisError: BOOL;
	AxisAccing: BOOL;
	AxisDecing: BOOL;
	FBErrorOccured: BOOL;
	Homing: BOOL;
	Stopping: BOOL;	
	ErrorID: SMC_ERROR;
	
	SetPosDone: BOOL;	

	bOperational: BOOL;
	eComState: SM3_Basic.SMC_CommunicationState;
	wComState: WORD;
	
	ReStartSlaveDone: BOOL;
END_VAR

VAR
	diState: DINT;
	MC_MoveAbsolute_1: MC_MoveAbsolute;
	MC_MoveRelative_1: MC_MoveRelative;
	MC_MoveVelocity_1: MC_MoveVelocity;
	MC_Stop_1: MC_Stop;
	MC_Home_1: MC_Home;
	MC_SetPosition_1: MC_SetPosition;
	TON_WaitTime: TON;
	bJogForwardInternal: BOOL;
	bJogBackwardInternal: BOOL;
	bInchForwardInternal: BOOL;
	bInchBackwardInternal: BOOL;
	bAbsInternal: BOOL;
	bRelInternal: BOOL;
	bVelInternal: BOOL;
	bStopInternal: BOOL;
	bResetInternal: BOOL;
	bSetPosInternal: BOOL;
	bReStartSlaveInternal: BOOL;
END_VAR
VAR_IN_OUT
	Axis: SM3_BASIC.AXIS_REF_SM3;
END_VAR

CASE diState OF
	0: (* Initialization *)
		EnableStatus := FALSE;
		StopDone := FALSE;
		AbsDone := FALSE;
		RelDone := FALSE;
		VelBusy := FALSE;
		InchBusy := FALSE;
		JogBusy := FALSE;
		AbsBusy := FALSE;
		RelBusy := FALSE;
		AxisStandstill := FALSE;
		AxisError := FALSE;
		AxisAccing := FALSE;
		AxisDecing := FALSE;
		FBErrorOccured := FALSE;
		Homing := FALSE;
		Stopping := FALSE;
		ErrorID := 0;
		SetPosDone := FALSE;
		bOperational := FALSE;
		eComState := SM3_Basic.SMC_CommunicationState.Unknown;
		wComState := 0;
		ReStartSlaveDone := FALSE;

		IF Enable THEN
			diState := 10; (* Move to next state *)
		END_IF;

	10: (* Axis Standstill Check *)
		AxisStandstill := TRUE;
		IF JogFor XOR JogBack THEN
			diState := 20; (* Jogging state *)
		ELSIF AbsExcute THEN
			diState := 30; (* Absolute move state *)
		ELSIF RelExcute THEN
			diState := 40; (* Relative move state *)
		ELSIF VelExcute THEN
			diState := 50; (* Velocity move state *)
		ELSIF InchForward XOR InchBackward THEN
			diState := 60; (* Inch move state *)
		ELSIF StopExcute THEN
			diState := 70; (* Stop state *)
		ELSIF ResetExcute THEN
			diState := 80; (* Reset state *)
		ELSIF SetPosExcute THEN
			diState := 90; (* Set position state *)
		ELSIF ReStartSlaveEx THEN
			diState := 100; (* Restart slave state *)
		END_IF;

	20: (* Jogging *)
		JogBusy := TRUE;
		MC_MoveVelocity_1.Execute := TRUE;
		MC_MoveVelocity_1.Velocity := JogVelocity;
		MC_MoveVelocity_1.Acceleration := AbsAcceleration;
		MC_MoveVelocity_1.Deceleration := AbsDeceleration;
		MC_MoveVelocity_1.Direction := IF JogFor THEN 1 ELSE -1 END_IF;

		IF NOT JogFor AND NOT JogBack THEN
			MC_MoveVelocity_1.Execute := FALSE;
			JogBusy := FALSE;
			diState := 10; (* Return to standstill check *)
		END_IF;

	30: (* Absolute Move *)
		AbsBusy := TRUE;
		MC_MoveAbsolute_1.Execute := TRUE;
		MC_MoveAbsolute_1.Position := AbsPosition;
		MC_MoveAbsolute_1.Velocity := AbsVelocity;
		MC_MoveAbsolute_1.Acceleration := AbsAcceleration;
		MC_MoveAbsolute_1.Deceleration := AbsDeceleration;

		IF MC_MoveAbsolute_1.Done THEN
			AbsDone := TRUE;
			AbsBusy := FALSE;
			diState := 10; (* Return to standstill check *)
		END_IF;

	40: (* Relative Move *)
		RelBusy := TRUE;
		MC_MoveRelative_1.Execute := TRUE;
		MC_MoveRelative_1.Distance := RelPosition;
		MC_MoveRelative_1.Velocity := RelVelocity;
		MC_MoveRelative_1.Acceleration := RelAcceleration;
		MC_MoveRelative_1.Deceleration := RelDeceleration;

		IF MC_MoveRelative_1.Done THEN
			RelDone := TRUE;
			RelBusy := FALSE;
			diState := 10; (* Return to standstill check *)
		END_IF;

	50: (* Velocity Move *)
		VelBusy := TRUE;
		MC_MoveVelocity_1.Execute := TRUE;
		MC_MoveVelocity_1.V
END_FUNCTION_BLOCK