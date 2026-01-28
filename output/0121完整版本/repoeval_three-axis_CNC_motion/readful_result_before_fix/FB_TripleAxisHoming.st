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
	fbHomingX			:	SMC_HOMING;			//X轴回零功能块
	fbHomingY			:	SMC_HOMING;			//Y轴回零功能块
	fbHomingZ			:	SMC_HOMING;			//Z轴回零功能块
	bAxisXBusy			:	BOOL;				//X轴回零进行中
	bAxisYBusy			:	BOOL;				//Y轴回零进行中
	bAxisZBusy			:	BOOL;				//Z轴回零进行中
	bAxisXError			:	BOOL;				//X轴回零错误
	bAxisYError			:	BOOL;				//Y轴回零错误
	bAxisZError			:	BOOL;				//Z轴回零错误
	sAxisXErrorString	:	STRING;				//X轴错误信息
	sAxisYErrorString	:	STRING;				//Y轴错误信息
	sAxisZErrorString	:	STRING;				//Z轴错误信息
END_VAR

fbHomingX.Execute := bExecute;
fbHomingX.Axis := AxisX;
fbHomingX.ReferenceSwitch := bAxisXRefSwitch;
fbHomingX.VelocitySlow := fVelocitySlow;
fbHomingX.VelocityFast := fVelocityFast;
fbHomingX.Acceleration := fAcceleration;
fbHomingX.Deceleration := fDeceleration;

fbHomingY.Execute := bExecute;
fbHomingY.Axis := AxisY;
fbHomingY.ReferenceSwitch := bAxisYRefSwitch;
fbHomingY.VelocitySlow := fVelocitySlow;
fbHomingY.VelocityFast := fVelocityFast;
fbHomingY.Acceleration := fAcceleration;
fbHomingY.Deceleration := fDeceleration;

fbHomingZ.Execute := bExecute;
fbHomingZ.Axis := AxisZ;
fbHomingZ.ReferenceSwitch := bAxisZRefSwitch;
fbHomingZ.VelocitySlow := fVelocitySlow;
fbHomingZ.VelocityFast := fVelocityFast;
fbHomingZ.Acceleration := fAcceleration;
fbHomingZ.Deceleration := fDeceleration;

bAxisXBusy := fbHomingX.Busy;
bAxisYBusy := fbHomingY.Busy;
bAxisZBusy := fbHomingZ.Busy;

bAxisXError := fbHomingX.Error;
bAxisYError := fbHomingY.Error;
bAxisZError := fbHomingZ.Error;

sAxisXErrorString := fbHomingX.ErrorString;
sAxisYErrorString := fbHomingY.ErrorString;
sAxisZErrorString := fbHomingZ.ErrorString;

bAxisXHomeOK := fbHomingX.HomeOK;
bAxisYHomeOK := fbHomingY.HomeOK;
bAxisZHomeOK := fbHomingZ.HomeOK;

bBusy := bAxisXBusy OR bAxisYBusy OR bAxisZBusy;
bError := bAxisXError OR bAxisYError OR bAxisZError;

IF bError THEN
	IF bAxisXError THEN
		sErrorString := sAxisXErrorString;
	ELSIF bAxisYError THEN
		sErrorString := sAxisYErrorString;
	ELSIF bAxisZError THEN
		sErrorString := sAxisZErrorString;
	END_IF;
ELSE
	sErrorString := '';
END_IF;

bHomeOK := bAxisXHomeOK AND bAxisYHomeOK AND bAxisZHomeOK;
END_FUNCTION_BLOCK
