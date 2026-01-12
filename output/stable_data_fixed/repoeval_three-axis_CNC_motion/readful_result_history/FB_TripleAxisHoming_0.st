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
	fbHomeX			:	MC_Home;			//X轴回零
	fbHomeY			:	MC_Home;			//Y轴回零
	fbHomeZ			:	MC_Home;			//Z轴回零
	bXBusy			:	BOOL;				//X轴回零忙标志
	bYBusy			:	BOOL;				//Y轴回零忙标志
	bZBusy			:	BOOL;				//Z轴回零忙标志
	bXError			:	BOOL;				//X轴错误标志
	bYError			:	BOOL;				//Y轴错误标志
	bZError			:	BOOL;				//Z轴错误标志
	sXErrorString	:	STRING;				//X轴错误信息
	sYErrorString	:	STRING;				//Y轴错误信息
	sZErrorString	:	STRING;				//Z轴错误信息
END_VAR

fbHomeX(
	Execute := bExecute,
	Axis := AxisX,
	Position := 0.0,
	Velocity := fVelocitySlow,
	Acceleration := fAcceleration,
	Deceleration := fDeceleration,
	BufferMode := MC_BufferModeAborting
);
bXBusy := fbHomeX.Busy;
bXError := fbHomeX.Error;
sXErrorString := fbHomeX.ErrorID;

fbHomeY(
	Execute := bExecute,
	Axis := AxisY,
	Position := 0.0,
	Velocity := fVelocitySlow,
	Acceleration := fAcceleration,
	Deceleration := fDeceleration,
	BufferMode := MC_BufferModeAborting
);
bYBusy := fbHomeY.Busy;
bYError := fbHomeY.Error;
sYErrorString := fbHomeY.ErrorID;

fbHomeZ(
	Execute := bExecute,
	Axis := AxisZ,
	Position := 0.0,
	Velocity := fVelocitySlow,
	Acceleration := fAcceleration,
	Deceleration := fDeceleration,
	BufferMode := MC_BufferModeAborting
);
bZBusy := fbHomeZ.Busy;
bZError := fbHomeZ.Error;
sZErrorString := fbHomeZ.ErrorID;

bAxisXHomeOK := NOT bXBusy AND NOT bXError AND bAxisXRefSwitch;
bAxisYHomeOK := NOT bYBusy AND NOT bYError AND bAxisYRefSwitch;
bAxisZHomeOK := NOT bZBusy AND NOT bZError AND bAxisZRefSwitch;

bHomeOK := bAxisXHomeOK AND bAxisYHomeOK AND bAxisZHomeOK;
bBusy := bXBusy OR bYBusy OR bZBusy;
bError := bXError OR bYError OR bZError;

IF bXError THEN
	sErrorString := sXErrorString;
ELSIF bYError THEN
	sErrorString := sYErrorString;
ELSIF bZError THEN
	sErrorString := sZErrorString;
ELSE
	sErrorString := '';
END_IF;

END_FUNCTION_BLOCK
