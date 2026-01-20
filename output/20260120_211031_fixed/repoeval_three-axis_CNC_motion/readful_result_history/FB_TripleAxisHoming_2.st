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
	bAxisXBusy			:	BOOL;				//X轴回零忙标志
	bAxisYBusy			:	BOOL;				//Y轴回零忙标志
	bAxisZBusy			:	BOOL;				//Z轴回零忙标志
	bAxisXError			:	BOOL;				//X轴回零错误标志
	bAxisYError			:	BOOL;				//Y轴回零错误标志
	bAxisZError			:	BOOL;				//Z轴回零错误标志
	sAxisXErrorString	:	STRING;				//X轴错误信息字符串
	sAxisYErrorString	:	STRING;				//Y轴错误信息字符串
	sAxisZErrorString	:	STRING;				//Z轴错误信息字符串
END_VAR

IF bExecute THEN
	// X轴回零处理
	fbHomingX.Execute := TRUE;
	fbHomingX.Axis := AxisX;
	fbHomingX.VelocitySlow := fVelocitySlow;
	fbHomingX.VelocityFast := fVelocityFast;
	fbHomingX.Acceleration := fAcceleration;
	fbHomingX.Deceleration := fDeceleration;
	fbHomingX.RefSwitch := bAxisXRefSwitch;
	fbHomingX();

	bAxisXBusy := fbHomingX.Busy;
	bAxisXError := fbHomingX.Error;
	sAxisXErrorString := fbHomingX.ErrorString;
	bAxisXHomeOK := fbHomingX.HomeDone;

	// Y轴回零处理
	fbHomingY.Execute := TRUE;
	fbHomingY.Axis := AxisY;
	fbHomingY.VelocitySlow := fVelocitySlow;
	fbHomingY.VelocityFast := fVelocityFast;
	fbHomingY.Acceleration := fAcceleration;
	fbHomingY.Deceleration := fDeceleration;
	fbHomingY.RefSwitch := bAxisYRefSwitch;
	fbHomingY();

	bAxisYBusy := fbHomingY.Busy;
	bAxisYError := fbHomingY.Error;
	sAxisYErrorString := fbHomingY.ErrorString;
	bAxisYHomeOK := fbHomingY.HomeDone;

	// Z轴回零处理
	fbHomingZ.Execute := TRUE;
	fbHomingZ.Axis := AxisZ;
	fbHomingZ.VelocitySlow := fVelocitySlow;
	fbHomingZ.VelocityFast := fVelocityFast;
	fbHomingZ.Acceleration := fAcceleration;
	fbHomingZ.Deceleration := fDeceleration;
	fbHomingZ.RefSwitch := bAxisZRefSwitch;
	fbHomingZ();

	bAxisZBusy := fbHomingZ.Busy;
	bAxisZError := fbHomingZ.Error;
	sAxisZErrorString := fbHomingZ.ErrorString;
	bAxisZHomeOK := fbHomingZ.HomeDone;

	// 总状态更新
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
sErrorString := STRING#''; // Assign an empty constant string
	END_IF;

	bHomeOK := bAxisXHomeOK AND bAxisYHomeOK AND bAxisZHomeOK;

ELSE
	// 停止回零
	fbHomingX.Execute := FALSE;
	fbHomingY.Execute := FALSE;
	fbHomingZ.Execute := FALSE;

	bBusy := FALSE;
	bError := FALSE;
	sErrorString := '';
	bHomeOK := FALSE;
	bAxisXHomeOK := FALSE;
	bAxisYHomeOK := FALSE;
	bAxisZHomeOK := FALSE;
END_IF;
END_FUNCTION_BLOCK