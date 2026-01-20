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
	bXHomingDone		:	BOOL;				//X轴回零完成标志
	bYHomingDone		:	BOOL;				//Y轴回零完成标志
	bZHomingDone		:	BOOL;				//Z轴回零完成标志
	bXError				:	BOOL;				//X轴错误标志
	bYError				:	BOOL;				//Y轴错误标志
	bZError				:	BOOL;				//Z轴错误标志
	sXErrorString		:	STRING;				//X轴错误信息
	sYErrorString		:	STRING;				//Y轴错误信息
	sZErrorString		:	STRING;				//Z轴错误信息
END_VAR

IF bExecute THEN
	// X轴回零
	fbHomingX.Axis := AxisX;
	fbHomingX.bExecute := NOT bXHomingDone;
	fbHomingX.bReferenceSwitch := bAxisXRefSwitch;
	fbHomingX.Velocity := fVelocityFast;
	fbHomingX.Acceleration := fAcceleration;
	fbHomingX.Deceleration := fDeceleration;
	fbHomingX();
	bXHomingDone := fbHomingX.bDone;
	bXError := fbHomingX.bError;
	sXErrorString := fbHomingX.sErrorString;

	// Y轴回零
	fbHomingY.Axis := AxisY;
	fbHomingY.bExecute := NOT bYHomingDone;
	fbHomingY.bReferenceSwitch := bAxisYRefSwitch;
	fbHomingY.Velocity := fVelocityFast;
	fbHomingY.Acceleration := fAcceleration;
	fbHomingY.Deceleration := fDeceleration;
	fbHomingY();
	bYHomingDone := fbHomingY.bDone;
	bYError := fbHomingY.bError;
	sYErrorString := fbHomingY.sErrorString;

	// Z轴回零
	fbHomingZ.Axis := AxisZ;
	fbHomingZ.bExecute := NOT bZHomingDone;
	fbHomingZ.bReferenceSwitch := bAxisZRefSwitch;
	fbHomingZ.Velocity := fVelocityFast;
	fbHomingZ.Acceleration := fAcceleration;
	fbHomingZ.Deceleration := fDeceleration;
	fbHomingZ();
	bZHomingDone := fbHomingZ.bDone;
	bZError := fbHomingZ.bError;
	sZErrorString := fbHomingZ.sErrorString;

	// 更新输出状态
	bAxisXHomeOK := bXHomingDone AND NOT bXError;
	bAxisYHomeOK := bYHomingDone AND NOT bYError;
	bAxisZHomeOK := bZHomingDone AND NOT bZError;
	bHomeOK := bAxisXHomeOK AND bAxisYHomeOK AND bAxisZHomeOK;
	bBusy := NOT bHomeOK;
	bError := bXError OR bYError OR bZError;

	// 错误信息汇总
	IF bXError THEN
		sErrorString := sXErrorString;
	ELSIF bYError THEN
		sErrorString := sYErrorString;
	ELSIF bZError THEN
		sErrorString := sZErrorString;
	END_IF;
ELSE
	// 停止所有轴的回零
	fbHomingX.bExecute := FALSE;
	fbHomingY.bExecute := FALSE;
	fbHomingZ.bExecute := FALSE;
	fbHomingX();
	fbHomingY();
	fbHomingZ();

	// 重置状态
	bHomeOK := FALSE;
	bAxisXHomeOK := FALSE;
	bAxisYHomeOK := FALSE;
	bAxisZHomeOK := FALSE;
	bBusy := FALSE;
	bError := FALSE;
	sErrorString := '';
END_IF;
END_FUNCTION_BLOCK
