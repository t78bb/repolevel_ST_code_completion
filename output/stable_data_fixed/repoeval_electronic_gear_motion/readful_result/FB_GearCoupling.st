FUNCTION_BLOCK FB_GearCoupling
VAR_INPUT
	Master				:	AXIS_REF;		//主轴引用
	Slave				:	AXIS_REF;		//从轴引用
	bCouple				:	BOOL;			//TRUE=耦合，FALSE=解耦
	nRatioNumerator		:	INT := 1;		//传动比分子
	nRatioDenominator	:	INT := 1;		//传动比分母
	rAcceleration		:	REAL := 10000.0;//加速度
	rDeceleration		:	REAL := 10000.0;//减速度
END_VAR
VAR_OUTPUT
	bInGear				:	BOOL;			//耦合状态
	bCouplingDone		:	BOOL;			//耦合完成
	bDecouplingDone		:	BOOL;			//解耦完成
	bError				:	BOOL;			//错误标志
	nErrorID			:	DWORD;			//错误代码
END_VAR

VAR
	bCouplePrev			:	BOOL;			// Previous state of bCouple
	fbStartRtrig		:	R_TRIG;			// Rising edge detection for bCouple
	fbStopRtrig			:	R_TRIG;			// Rising edge detection for decoupling
END_VAR

fbStartRtrig(CLK := bCouple);
fbStopRtrig(CLK := NOT bCouple);

IF fbStartRtrig.Q THEN
	// Start coupling process
	IF NOT bInGear THEN
		// Perform coupling
		Master.Axis := Master;
		Slave.Axis := Slave;
		Master.Acceleration := rAcceleration;
		Master.Deceleration := rDeceleration;
		Slave.Acceleration := rAcceleration;
		Slave.Deceleration := rDeceleration;
		Master.RatioNumerator := nRatioNumerator;
		Master.RatioDenominator := nRatioDenominator;
		bInGear := TRUE;
		bCouplingDone := TRUE;
		bDecouplingDone := FALSE;
		bError := FALSE;
		nErrorID := 0;
	END_IF;
ELSIF fbStopRtrig.Q THEN
	// Start decoupling process
	IF bInGear THEN
		// Perform decoupling
		bInGear := FALSE;
		bCouplingDone := FALSE;
		bDecouplingDone := TRUE;
		bError := FALSE;
		nErrorID := 0;
	END_IF;
END_IF;

IF bError THEN
	// Handle error condition
	bInGear := FALSE;
	bCouplingDone := FALSE;
	bDecouplingDone := FALSE;
	nErrorID := 16#0001; // Example error code
END_IF;

END_FUNCTION_BLOCK
