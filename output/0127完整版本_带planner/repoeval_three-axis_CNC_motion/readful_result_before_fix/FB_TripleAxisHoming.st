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
	bErrorDetected		:	BOOL;				//错误检测标志
	sLocalErrorString	:	STRING;				//本地错误信息
END_VAR

IF NOT bExecute THEN
	bBusy := FALSE;
	bHomeOK := FALSE;
	bAxisXHomeOK := FALSE;
	bAxisYHomeOK := FALSE;
	bAxisZHomeOK := FALSE;
	bError := FALSE;
	sErrorString := '';
	RETURN;
END_IF;

bBusy := TRUE;
bErrorDetected := FALSE;

// X轴回零逻辑
IF NOT bAxisXHomeOK THEN
	IF NOT bAxisXRefSwitch THEN
		fbHomingX.Axis := AxisX;
		fbHomingX.Velocity := fVelocityFast;
		fbHomingX.Acceleration := fAcceleration;
		fbHomingX.Deceleration := fDeceleration;
		fbHomingX.Execute := TRUE;
		IF fbHomingX.Error THEN
			bErrorDetected := TRUE;
			sLocalErrorString := 'X Axis Homing Error';
		END_IF;
	ELSE
		fbHomingX.Velocity := fVelocitySlow;
		IF fbHomingX.Done THEN
			bAxisXHomeOK := TRUE;
			fbHomingX.Execute := FALSE;
		END_IF;
	END_IF;
END_IF;

// Y轴回零逻辑
IF NOT bAxisYHomeOK AND NOT bErrorDetected THEN
	IF NOT bAxisYRefSwitch THEN
		fbHomingY.Axis := AxisY;
		fbHomingY.Velocity := fVelocityFast;
		fbHomingY.Acceleration := fAcceleration;
		fbHomingY.Deceleration := fDeceleration;
		fbHomingY.Execute := TRUE;
		IF fbHomingY.Error THEN
			bErrorDetected := TRUE;
			sLocalErrorString := 'Y Axis Homing Error';
		END_IF;
	ELSE
		fbHomingY.Velocity := fVelocitySlow;
		IF fbHomingY.Done THEN
			bAxisYHomeOK := TRUE;
			fbHomingY.Execute := FALSE;
		END_IF;
	END_IF;
END_IF;

// Z轴回零逻辑
IF NOT bAxisZHomeOK AND NOT bErrorDetected THEN
	IF NOT bAxisZRefSwitch THEN
		fbHomingZ.Axis := AxisZ;
		fbHomingZ.Velocity := fVelocityFast;
		fbHomingZ.Acceleration := fAcceleration;
		fbHomingZ.Deceleration := fDeceleration;
		fbHomingZ.Execute := TRUE;
		IF fbHomingZ.Error THEN
			bErrorDetected := TRUE;
			sLocalErrorString := 'Z Axis Homing Error';
		END_IF;
	ELSE
		fbHomingZ.Velocity := fVelocitySlow;
		IF fbHomingZ.Done THEN
			bAxisZHomeOK := TRUE;
			fbHomingZ.Execute := FALSE;
		END_IF;
	END_IF;
END_IF;

// 错误处理
IF bErrorDetected THEN
	bError := TRUE;
	sErrorString := sLocalErrorString;
	bBusy := FALSE;
	RETURN;
END_IF;

// 检查所有轴是否回零完成
IF bAxisXHomeOK AND bAxisYHomeOK AND bAxisZHomeOK THEN
	bHomeOK := TRUE;
	bBusy := FALSE;
END_IF;
END_FUNCTION_BLOCK
