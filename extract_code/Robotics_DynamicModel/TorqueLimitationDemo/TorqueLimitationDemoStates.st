{attribute 'strict'}
TYPE TorqueLimitationDemoStates :
(
	PowerAxisGroup,
	InitializeDynamicModel,
	InitializeTestMovement,
	InitializeUnlimitedTorqueMovement,
	ExecuteUnlimitedTorqueMovement,
	InitializeLimitedTorqueMovement,
	ExecuteLimitedTorqueMovement,
	InitializeMovementWithLoad,
	ExecuteMovementWithLoad,
	FinalizeTestMovement,
	DemoFinished
);
END_TYPE
