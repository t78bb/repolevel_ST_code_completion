VAR
	fbHomingX			:	SMC_HOMING;			//X轴回零功能块
	fbHomingY			:	SMC_HOMING;			//Y轴回零功能块
	fbHomingZ			:	SMC_HOMING;			//Z轴回零功能块
	bXHomingDone		:	BOOL;				//X轴回零完成标志
	bYHomingDone		:	BOOL;				//Y轴回零完成标志
	bZHomingDone		:	BOOL;				//Z轴回零完成标志
	bXHomingError		:	BOOL;				//X轴回零错误标志
	bYHomingError		:	BOOL;				//Y轴回零错误标志
	bZHomingError		:	BOOL;				//Z轴回零错误标志
	sTempErrorString	:	STRING;				//临时错误信息字符串
END_VAR

IF bExecute THEN
	bBusy := TRUE;
	bError := FALSE;
	sErrorString := '';
	
	// X轴回零过程
	fbHomingX.Axis := AxisX;
	fbHomingX.Execute := NOT bXHomingDone;
	fbHomingX.Velocity := fVelocityFast;
	fbHomingX.Acceleration := fAcceleration;
	fbHomingX.Deceleration := fDeceleration;
	fbHomingX.HomeSwitch := bAxisXRefSwitch;
	fbHomingX();
	bXHomingDone := fbHomingX.Done;
	bXHomingError := fbHomingX.Error;
	
	// Y轴回零过程
	fbHomingY.Axis := AxisY;
	fbHomingY.Execute := NOT bYHomingDone AND bXHomingDone;
	fbHomingY.Velocity := fVelocityFast;
	fbHomingY.Acceleration := fAcceleration;
	fbHomingY.Deceleration := fDeceleration;
	fbHomingY.HomeSwitch := bAxisYRefSwitch;
	fbHomingY();
	bYHomingDone := fbHomingY.Done;
	bYHomingError := fbHomingY.Error;
	
	// Z轴回零过程
	fbHomingZ.Axis := AxisZ;
	fbHomingZ.Execute := NOT bZHomingDone AND bYHomingDone;
	fbHomingZ.Velocity := fVelocityFast;
	fbHomingZ.Acceleration := fAcceleration;
	fbHomingZ.Deceleration := fDeceleration;
	fbHomingZ.HomeSwitch := bAxisZRefSwitch;
	fbHomingZ();
	bZHomingDone := fbHomingZ.Done;
	bZHomingError := fbHomingZ.Error;
	
	// 错误处理
	IF bXHomingError THEN
		bError := TRUE;
		sTempErrorString := fbHomingX.ErrorID;
	ELSIF bYHomingError THEN
		bError := TRUE;
		sTempErrorString := fbHomingY.ErrorID;
	ELSIF bZHomingError THEN
		bError := TRUE;
		sTempErrorString := fbHomingZ.ErrorID;
	END_IF;
	
	IF bError THEN
		sErrorString := CONCAT('Homing Error: ', sTempErrorString);
		bBusy := FALSE;
		RETURN;
	END_IF;
	
	// 回零完成状态
	bAxisXHomeOK := bXHomingDone;
	bAxisYHomeOK := bYHomingDone;
	bAxisZHomeOK := bZHomingDone;
	bHomeOK := bXHomingDone AND bYHomingDone AND bZHomingDone;
	
	IF bHomeOK THEN
		bBusy := FALSE;
	END_IF;
ELSE
	bBusy := FALSE;
	bHomeOK := FALSE;
	bAxisXHomeOK := FALSE;
	bAxisYHomeOK := FALSE;
	bAxisZHomeOK := FALSE;
	bError := FALSE;
	sErrorString := '';
END_IF;
END_FUNCTION_BLOCK
