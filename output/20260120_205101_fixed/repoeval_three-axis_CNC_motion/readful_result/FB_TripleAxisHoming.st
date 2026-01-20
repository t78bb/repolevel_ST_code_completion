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
	bBusy := TRUE;

	// X轴回零
	fbHomingX.Axis := AxisX;
	fbHomingX.Execute := NOT bXHomingDone;
	fbHomingX.Velocity := fVelocityFast;
	fbHomingX.Acceleration := fAcceleration;
	fbHomingX.Deceleration := fDeceleration;
	fbHomingX.HomeSwitch := bAxisXRefSwitch;
	fbHomingX();

	IF fbHomingX.Done THEN
		bXHomingDone := TRUE;
		bAxisXHomeOK := TRUE;
	ELSIF fbHomingX.Error THEN
		bXError := TRUE;
		sXErrorString := fbHomingX.ErrorText;
	END_IF;

	// Y轴回零
	fbHomingY.Axis := AxisY;
	fbHomingY.Execute := NOT bYHomingDone;
	fbHomingY.Velocity := fVelocityFast;
	fbHomingY.Acceleration := fAcceleration;
	fbHomingY.Deceleration := fDeceleration;
	fbHomingY.HomeSwitch := bAxisYRefSwitch;
	fbHomingY();

	IF fbHomingY.Done THEN
		bYHomingDone := TRUE;
		bAxisYHomeOK := TRUE;
	ELSIF fbHomingY.Error THEN
		bYError := TRUE;
		sYErrorString := fbHomingY.ErrorText;
	END_IF;

	// Z轴回零
	fbHomingZ.Axis := AxisZ;
	fbHomingZ.Execute := NOT bZHomingDone;
	fbHomingZ.Velocity := fVelocityFast;
	fbHomingZ.Acceleration := fAcceleration;
	fbHomingZ.Deceleration := fDeceleration;
	fbHomingZ.HomeSwitch := bAxisZRefSwitch;
	fbHomingZ();

	IF fbHomingZ.Done THEN
		bZHomingDone := TRUE;
		bAxisZHomeOK := TRUE;
	ELSIF fbHomingZ.Error THEN
		bZError := TRUE;
		sZErrorString := fbHomingZ.ErrorText;
	END_IF;

	// 检查是否所有轴都回零完成
	IF bXHomingDone AND bYHomingDone AND bZHomingDone THEN
		bHomeOK := TRUE;
		bBusy := FALSE;
	END_IF;

	// 错误处理
	IF bXError OR bYError OR bZError THEN
		bError := TRUE;
		bBusy := FALSE;
		sErrorString := CONCAT(CONCAT(sXErrorString, sYErrorString), sZErrorString);
	END_IF;

ELSE
	bBusy := FALSE;
	bHomeOK := FALSE;
	bAxisXHomeOK := FALSE;
	bAxisYHomeOK := FALSE;
	bAxisZHomeOK := FALSE;
	bError := FALSE;
	sErrorString := '';
	bXHomingDone := FALSE;
	bYHomingDone := FALSE;
	bZHomingDone := FALSE;
	bXError := FALSE;
	bYError := FALSE;
	bZError := FALSE;
END_IF;
END_FUNCTION_BLOCK
