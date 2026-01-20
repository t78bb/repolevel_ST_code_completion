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
	bAxisXError			:	BOOL;				//X轴错误标志
	bAxisYError			:	BOOL;				//Y轴错误标志
	bAxisZError			:	BOOL;				//Z轴错误标志
	sAxisXErrorString	:	STRING;				//X轴错误信息字符串
	sAxisYErrorString	:	STRING;				//Y轴错误信息字符串
	sAxisZErrorString	:	STRING;				//Z轴错误信息字符串
END_VAR

fbHomingX.Execute := bExecute;
fbHomingX.Axis := AxisX;
fbHomingX.bRefSwitch := bAxisXRefSwitch;
fbHomingX.fVelocitySlow := fVelocitySlow;
fbHomingX.fVelocityFast := fVelocityFast;
fbHomingX.fAcceleration := fAcceleration;
fbHomingX.fDeceleration := fDeceleration;

fbHomingY.Execute := bExecute;
fbHomingY.Axis := AxisY;
fbHomingY.bRefSwitch := bAxisYRefSwitch;
fbHomingY.fVelocitySlow := fVelocitySlow;
fbHomingY.fVelocityFast := fVelocityFast;
fbHomingY.fAcceleration := fAcceleration;
fbHomingY.fDeceleration := fDeceleration;

fbHomingZ.Execute := bExecute;
fbHomingZ.Axis := AxisZ;
fbHomingZ.bRefSwitch := bAxisZRefSwitch;
fbHomingZ.fVelocitySlow := fVelocitySlow;
fbHomingZ.fVelocityFast := fVelocityFast;
fbHomingZ.fAcceleration := fAcceleration;
fbHomingZ.fDeceleration := fDeceleration;

bAxisXHomeOK := fbHomingX.bHomeOK;
bAxisYHomeOK := fbHomingY.bHomeOK;
bAxisZHomeOK := fbHomingZ.bHomeOK;

bAxisXBusy := fbHomingX.bBusy;
bAxisYBusy := fbHomingY.bBusy;
bAxisZBusy := fbHomingZ.bBusy;

bAxisXError := fbHomingX.bError;
bAxisYError := fbHomingY.bError;
bAxisZError := fbHomingZ.bError;

sAxisXErrorString := fbHomingX.sErrorString;
sAxisYErrorString := fbHomingY.sErrorString;
sAxisZErrorString := fbHomingZ.sErrorString;

bBusy := bAxisXBusy OR bAxisYBusy OR bAxisZBusy;
bError := bAxisXError OR bAxisYError OR bAxisZError;

IF NOT bBusy THEN
	bHomeOK := bAxisXHomeOK AND bAxisYHomeOK AND bAxisZHomeOK;
ELSE
	bHomeOK := FALSE;
END_IF;

IF bError THEN
	sErrorString := CONCAT(CONCAT(sAxisXErrorString, sAxisYErrorString), sAxisZErrorString);
ELSE
	sErrorString := '';
END_IF;
END_FUNCTION_BLOCK
