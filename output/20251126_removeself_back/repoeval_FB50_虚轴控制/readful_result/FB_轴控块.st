VAR
	diState: DINT;
	MC_MoveAbsolute_1: MC_MoveAbsolute;
	MC_MoveRelative_1: MC_MoveRelative;
	MC_MoveVelocity_1: MC_MoveVelocity;
	MC_Stop_1: MC_Stop;
	MC_Home_1: MC_Home;
	MC_Reset_1: MC_Reset;
	MC_SetPosition_1: MC_SetPosition;
	T_InchWaitTime: TON;
	bJogForwardInternal: BOOL;
	bJogBackwardInternal: BOOL;
	bInchForwardInternal: BOOL;
	bInchBackwardInternal: BOOL;
	bStopInternal: BOOL;
	bResetInternal: BOOL;
	bAbsInternal: BOOL;
	bRelInternal: BOOL;
	bVelInternal: BOOL;
	bSetPosInternal: BOOL;
	bReStartSlaveInternal: BOOL;
END_VAR
VAR_IN_OUT
	Axis: SM3_BASIC.AXIS_REF_SM3;
END_VAR

(* State Machine Logic *)
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
		AxisStandstill := TRUE;
		AxisError := FALSE;
		AxisAccing := FALSE;
		AxisDecing := FALSE;
		FBErrorOccured := FALSE;
		Homing := FALSE;
		Stopping := FALSE;
		ErrorID := 0;
		SetPosDone := FALSE;
		bOperational := FALSE;
		eComState := SM3_Basic.SMC_CommunicationState.OFF;
		wComState := 0;
		ReStartSlaveDone := FALSE;
		IF Enable THEN
			diState := 10;
		END_IF;
		
	10: (* Check Axis State *)
		IF AxisStandstill THEN
			diState := 20;
		ELSIF AxisError THEN
			diState := 100;
		END_IF;
		
	20: (* Execute Commands *)
		IF JogFor THEN
			bJogForwardInternal := TRUE;
			diState := 30;
		ELSIF JogBack THEN
			bJogBackwardInternal := TRUE;
			diState := 30;
		ELSIF StopExcute THEN
			bStopInternal := TRUE;
			diState := 40;
		ELSIF ResetExcute THEN
			bResetInternal := TRUE;
			diState := 50;
		ELSIF AbsExcute THEN
			bAbsInternal := TRUE;
			diState := 60;
		ELSIF RelExcute THEN
			bRelInternal := TRUE;
			diState := 70;
		ELSIF VelExcute THEN
			bVelInternal := TRUE;
			diState := 80;
		ELSIF SetPosExcute THEN
			bSetPosInternal := TRUE;
			diState := 90;
		ELSIF ReStartSlaveEx THEN
			bReStartSlaveInternal := TRUE;
			diState := 110;
		END_IF;
		
	30: (* Jogging *)
		IF bJogForwardInternal THEN
			MC_MoveVelocity_1.Execute := TRUE;
			MC_MoveVelocity_1.Velocity := JogVelocity;
			MC_MoveVelocity_1.Direction := MC_DIRECTION.FORWARD;
			JogBusy := TRUE;
		ELSIF bJogBackwardInternal THEN
			MC_MoveVelocity_1.Execute := TRUE;
			MC_MoveVelocity_1.Velocity := JogVelocity;
			MC_MoveVelocity_1.Direction := MC_DIRECTION.BACKWARD;
			JogBusy := TRUE;
		END_IF;
		IF NOT JogFor AND NOT JogBack THEN
			MC_MoveVelocity_1.Execute := FALSE;
			JogBusy := FALSE;
			diState := 20;
		END_IF;
		
	40: (* Stop Execution *)
		MC_Stop_1.Execute := TRUE;
		Stopping := TRUE;
		IF MC_Stop_1.Done THEN
			StopDone := TRUE;
			Stopping := FALSE;
			diState := 20;
		END_IF;
		
	50: (* Reset Execution *)
		MC_Reset_1.Execute := TRUE;
		IF MC_Reset_1.Done THEN
			diState := 20;
		END_IF;
		
	60: (* Absolute Move *)
		MC_MoveAbsolute_1.Execute := TRUE;
		MC_MoveAbsolute_1.Position := AbsPosition;
		MC_MoveAbsolute_1.Velocity := AbsVelocity;
		MC_MoveAbsolute_1.Acceleration := AbsAcceleration;
		MC_MoveAbsolute_1.Deceleration := AbsDeceleration;
		AbsBusy := TRUE;