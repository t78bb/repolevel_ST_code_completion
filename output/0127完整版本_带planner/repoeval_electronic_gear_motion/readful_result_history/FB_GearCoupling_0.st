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
	fbGearIn			:	MC_GearIn;		//齿轮耦合功能块
	fbGearOut			:	MC_GearOut;		//齿轮解耦功能块
	bLastCouple			:	BOOL;			//上次耦合状态
	bCoupleRising		:	BOOL;			//耦合上升沿
	bCoupleFalling		:	BOOL;			//耦合下降沿
END_VAR

// 检测耦合信号的边沿
bCoupleRising := bCouple AND NOT bLastCouple;
bCoupleFalling := NOT bCouple AND bLastCouple;
bLastCouple := bCouple;

// 耦合逻辑
IF bCouple THEN
	IF bCoupleRising THEN
		// 配置齿轮耦合功能块
		fbGearIn.Master := Master;
		fbGearIn.Slave := Slave;
		fbGearIn.RatioNumerator := nRatioNumerator;
		fbGearIn.RatioDenominator := nRatioDenominator;
		fbGearIn.Acceleration := rAcceleration;
		fbGearIn.Deceleration := rDeceleration;
		fbGearIn.Execute := TRUE;
	END_IF
	
	// 检查耦合状态
	IF fbGearIn.Done THEN
		bInGear := TRUE;
		bCouplingDone := TRUE;
		bError := FALSE;
		nErrorID := 0;
	ELSIF fbGearIn.Error THEN
		bError := TRUE;
		nErrorID := fbGearIn.ErrorID;
	END_IF
ELSE
	// 解耦逻辑
	IF bCoupleFalling THEN
		// 配置齿轮解耦功能块
		fbGearOut.Master := Master;
		fbGearOut.Slave := Slave;
		fbGearOut.Execute := TRUE;
	END_IF
	
	// 检查解耦状态
	IF fbGearOut.Done THEN
		bInGear := FALSE;
		bDecouplingDone := TRUE;
		bError := FALSE;
		nErrorID := 0;
	ELSIF fbGearOut.Error THEN
		bError := TRUE;
		nErrorID := fbGearOut.ErrorID;
	END_IF
END_IF
END_FUNCTION_BLOCK
