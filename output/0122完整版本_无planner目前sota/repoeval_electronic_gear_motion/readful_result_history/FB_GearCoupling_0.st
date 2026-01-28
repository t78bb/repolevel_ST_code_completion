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
	bInternalError		:	BOOL;			//内部错误标志
END_VAR

// 检测耦合信号的边沿
bCoupleRising := bCouple AND NOT bLastCouple;
bCoupleFalling := NOT bCouple AND bLastCouple;
bLastCouple := bCouple;

// 耦合逻辑控制
IF bCoupleRising THEN
	fbGearIn.Axis := Slave;
	fbGearIn.Master := Master;
	fbGearIn.RatioNumerator := nRatioNumerator;
	fbGearIn.RatioDenominator := nRatioDenominator;
	fbGearIn.Acceleration := rAcceleration;
	fbGearIn.Deceleration := rDeceleration;
	fbGearIn.Execute := TRUE;
END_IF

IF NOT fbGearIn.Execute THEN
	bCouplingDone := fbGearIn.Done;
	bError := fbGearIn.Error;
	nErrorID := fbGearIn.ErrorID;
END_IF

// 解耦逻辑控制
IF bCoupleFalling THEN
	fbGearOut.Axis := Slave;
	fbGearOut.Execute := TRUE;
END_IF

IF NOT fbGearOut.Execute THEN
	bDecouplingDone := fbGearOut.Done;
	bError := fbGearOut.Error;
	nErrorID := fbGearOut.ErrorID;
END_IF

// 更新耦合状态
bInGear := fbGearIn.InGear;
END_FUNCTION_BLOCK
