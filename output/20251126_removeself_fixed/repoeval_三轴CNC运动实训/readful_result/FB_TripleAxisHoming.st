FUNCTION_BLOCK FB_TripleAxisHoming
VAR_INPUT
	bExecute			:	BOOL;				//执行回零信号
	AxisX				:	AXIS_REF;			//X轴引用
	AxisY				:	AXIS_REF;			//Y轴引用
	AxisZ				:	AXIS_REF;			//Z轴引用
	bAxisXRefSwitch		:	BOOL;				//X轴零点开关
	bAxisYRefSwitch		:	BOOL;				//Y轴零点开关
	bAxisZRefSwitch		:	BOOL;				//Z轴零点开关
	fVelocitySlow		:	REAL;				//慢速回零速度
	fVelocityFast		:	REAL;				//快速回零速度
	fAcceleration		:	REAL;				//加速度
	fDeceleration		:	REAL;				//减速度
END_VAR
VAR_OUTPUT
	bHomeOK				:	BOOL;				//三轴都回零完成
	bAxisXHomeOK		:	BOOL;				//X轴回零完成
	bAxisYHomeOK		:	BOOL;				//Y轴回零完成
	bAxisZHomeOK		:	BOOL;				//Z轴回零完成
	bBusy				:	BOOL;				//回零进行中
	bError				:	BOOL;				//错误标志
	sErrorString		:	STRING;				//错误信息字符串
END_VAR

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