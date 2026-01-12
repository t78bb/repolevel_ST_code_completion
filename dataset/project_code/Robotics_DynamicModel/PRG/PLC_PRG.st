PROGRAM PLC_PRG
VAR
	state : TorqueLimitationDemoStates;
	
	currentTestMovement : UINT := 0;
	start : SMC_POS_REF;
	destination : SMC_POS_REF;
	
	groupPower : SMC_GroupPower;
	setDynamics : SMC_GroupSetDynamics;
	dynModel : DynModel_Scara2_Z;
	moveDirectAbs : MC_MoveDirectAbsolute := (CoordSystem:= SMC_COORD_SYSTEM.ACS);
	setLoad : SMC_GroupSetLoad := (ExecutionMode:= MC_EXECUTION_MODE.Immediately);
	setPosition : MC_GroupSetPosition;
	setAxisLimits : SetAxisLimits;
END_VAR
VAR CONSTANT
	/// Count of different test movements.
	TEST_MOVEMENT_COUNT : UINT := 2;
	
	/// Load mass in [kg]
	LOAD_MASS : LREAL := 3;
	/// Load length in [m]
	LOAD_LENGTH : LREAL := 0.2;
	/// Load calculated for a thin rod mounted directly
	/// to the z-axis in [kg m²]
	LOAD : SMC_DynLoad :=
		(
			Mass:= LOAD_MASS,
			PrincipalMoments:=
				[
					/// Ix
					0,
					/// Iy
					1/12.0 * LOAD_MASS * LOAD_LENGTH * LOAD_LENGTH,
					/// Iz
					1/12.0 * LOAD_MASS * LOAD_LENGTH * LOAD_LENGTH
				]
		);
	ZERO_LOAD : SMC_DynLoad :=
		(
			Mass:= 0,
			PrincipalMoments:= [0, 0, 0],
			PrincipalAxes:= (X:= 0, Y:= 0, Z:= 0, A:= 0, B:= 0, C:= 0)
		);
		
	/// Test movement positions in ACS (a0 and a1 in [°] and a2 in [m]).
	TEST_MOVEMENT_ONE_START : SMC_POS_REF := (a:= (a0:= 0, a1:= 0, a2:= 0));
	TEST_MOVEMENT_ONE_DESTINATION : SMC_POS_REF := (a:= (a0:= 90, a1:= 0, a2:= 0.02));
	TEST_MOVEMENT_TWO_START : SMC_POS_REF := (a:= (a0:= 0, a1:= -120, a2:= 0));
	TEST_MOVEMENT_TWO_DESTINATION : SMC_POS_REF := (a:= (a0:= 90, a1:= -120, a2:= 0.02));
	
	DEFAULT_REVOLUTE_AXIS_LIMITS : AxisLimits :=
		(
			maxVelocity:= 30,	/// [°/s]
			maxAcceleration:= 400,	/// [°/s²]
			maxDeceleration:= 400,	/// [°/s²]
			maxJerk:= 1E5,	/// [°/s³]
			maxTorque:= FPU.GetLRealSpecialVal(FPU.ESpecial_FP_Value.PosInf)	/// [Nm]
		);
	
	DEFAULT_PRISMATIC_AXIS_LIMITS : AxisLimits :=
		(
			maxVelocity:= 0.03,	/// [m/s]
			maxAcceleration:= 0.4,	/// [m/s²]
			maxDeceleration:= 0.4,	/// [m/s²]
			maxJerk:= 10,	/// [m/s³]
			maxTorque:= FPU.GetLRealSpecialVal(FPU.ESpecial_FP_Value.PosInf)	/// [N]
		);
END_VAR

CASE state OF
	PowerAxisGroup:
		groupPower.bDriveStart := TRUE;
		groupPower.bRegulatorOn := TRUE;
		groupPower.Enable := TRUE;
		
		IF groupPower.Status THEN
			state := InitializeDynamicModel;
		END_IF
	
	InitializeDynamicModel:
		dynModel.Init();
		
		setDynamics.Dynamics := dynModel;
		/// Gravitational acceleration in [m/s²]
		setDynamics.GravitationalAcceleration.dZ := 9.81;
		setDynamics.Execute := TRUE;
		
		IF setDynamics.Done THEN
			state := InitializeTestMovement;
		END_IF
	
	InitializeTestMovement:
		CASE currentTestMovement OF
			0:
				start := TEST_MOVEMENT_ONE_START;
				destination := TEST_MOVEMENT_ONE_DESTINATION;
			1:
				start := TEST_MOVEMENT_TWO_START;
				destination := TEST_MOVEMENT_TWO_DESTINATION;
		END_CASE
		
		setLoad.Load := ZERO_LOAD;
		setLoad.Execute := TRUE;
		
		IF setLoad.Done THEN
			setLoad.Execute := FALSE;
			state := InitializeUnlimitedTorqueMovement;
		END_IF
	
	InitializeUnlimitedTorqueMovement:
		setAxisLimits.AxisLimits[0] := DEFAULT_REVOLUTE_AXIS_LIMITS;
		setAxisLimits.AxisLimits[1] := DEFAULT_REVOLUTE_AXIS_LIMITS;
		setAxisLimits.AxisLimits[2] := DEFAULT_PRISMATIC_AXIS_LIMITS;
		
		setAxisLimits.Execute := TRUE;
		
		IF setAxisLimits.Done AND_THEN ResetRobotPosition() THEN
			setAxisLimits.Execute := FALSE;
			state := ExecuteUnlimitedTorqueMovement;
		END_IF
	
	ExecuteUnlimitedTorqueMovement:
		moveDirectAbs.Position := destination;
		moveDirectAbs.Execute := TRUE;
		
		IF moveDirectAbs.Done THEN
			moveDirectAbs.Execute := FALSE;
			state := InitializeLimitedTorqueMovement;
		END_IF
	
	InitializeLimitedTorqueMovement:
		/// Torque limit for axis 2 in [Nm]
		setAxisLimits.AxisLimits[1].maxTorque := 2;
		setAxisLimits.Execute := TRUE;
		
		IF setAxisLimits.Done AND_THEN ResetRobotPosition() THEN
			setAxisLimits.Execute := FALSE;
			state := ExecuteLimitedTorqueMovement;
		END_IF
	
	ExecuteLimitedTorqueMovement:
		moveDirectAbs.Position := destination;
		moveDirectAbs.Execute := TRUE;
		
		IF moveDirectAbs.Done THEN
			moveDirectAbs.Execute := FALSE;
			state := InitializeMovementWithLoad;
		END_IF
	
	InitializeMovementWithLoad:
		setLoad.Load := LOAD;
		setLoad.Execute := TRUE;
		
		IF setLoad.Done AND_THEN ResetRobotPosition() THEN
			setLoad.Execute := FALSE;
			state := ExecuteMovementWithLoad;
		END_IF
	
	ExecuteMovementWithLoad:
		moveDirectAbs.Position := destination;
		moveDirectAbs.Execute := TRUE;
		
		IF moveDirectAbs.Done THEN
			moveDirectAbs.Execute := FALSE;
			state := FinalizeTestMovement;
		END_IF
	
	FinalizeTestMovement:
		currentTestMovement := currentTestMovement + 1;
		
		IF currentTestMovement < TEST_MOVEMENT_COUNT THEN
			state := InitializeTestMovement;
		ELSE
			state := DemoFinished;
		END_IF
END_CASE

groupPower(AxisGroup:= AxisGroup);
setDynamics(AxisGroup:= AxisGroup);
moveDirectAbs(AxisGroup:= AxisGroup);
setLoad(AxisGroup:= AxisGroup);
setPosition(AxisGroup:= AxisGroup);
setAxisLimits(AxisGroup:= AxisGroup);