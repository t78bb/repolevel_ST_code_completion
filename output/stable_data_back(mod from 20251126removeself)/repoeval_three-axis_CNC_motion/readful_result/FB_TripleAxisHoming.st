VAR
	fbHomeX				:	MC_Home;			//X轴回零功能块
	fbHomeY				:	MC_Home;			//Y轴回零功能块
	fbHomeZ				:	MC_Home;			//Z轴回零功能块
END_VAR

// X轴回零
fbHomeX(
	Execute := bExecute,
	Axis := AxisX,
	Velocity := fVelocitySlow,
	Acceleration := fAcceleration,
	Deceleration := fDeceleration,
	RefSwitch := bAxisXRefSwitch
);

// Y轴回零
fbHomeY(
	Execute := bExecute,
	Axis := AxisY,
	Velocity := fVelocitySlow,
	Acceleration := fAcceleration,
	Deceleration := fDeceleration,
	RefSwitch := bAxisYRefSwitch
);

// Z轴回零
fbHomeZ(
	Execute := bExecute,
	Axis := AxisZ,
	Velocity := fVelocitySlow,
	Acceleration := fAcceleration,
	Deceleration := fDeceleration,
	RefSwitch := bAxisZRefSwitch
);

// 输出状态更新
bAxisXHomeOK := fbHomeX.Done;
bAxisYHomeOK := fbHomeY.Done;
bAxisZHomeOK := fbHomeZ.Done;

bHomeOK := bAxisXHomeOK AND bAxisYHomeOK AND bAxisZHomeOK;
bBusy := fbHomeX.Busy OR fbHomeY.Busy OR fbHomeZ.Busy;
bError := fbHomeX.Error OR fbHomeY.Error OR fbHomeZ.Error;

IF fbHomeX.Error THEN
	sErrorString := fbHomeX.ErrorString;
ELSIF fbHomeY.Error THEN
	sErrorString := fbHomeY.ErrorString;
ELSIF fbHomeZ.Error THEN
	sErrorString := fbHomeZ.ErrorString;
END_IF;