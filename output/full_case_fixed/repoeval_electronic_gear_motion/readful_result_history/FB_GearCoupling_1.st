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
IF bCoupleRising THEN
  fbGearIn.Master := Master;
  fbGearIn.Slave := Slave;
  fbGearIn.RatioNumerator := nRatioNumerator;
  fbGearIn.RatioDenominator := nRatioDenominator;
  fbGearIn.Acceleration := rAcceleration;
  fbGearIn.Execute := TRUE;
END_IF;

// 检查耦合完成或错误状态
IF fbGearIn.Execute THEN
  IF fbGearIn.Done THEN
    bInGear := TRUE;
    bCouplingDone := TRUE;
    fbGearIn.Execute := FALSE;
  ELSIF fbGearIn.Error THEN
    bError := TRUE;
    nErrorID := fbGearIn.ErrorID;
    fbGearIn.Execute := FALSE;
  END_IF;
END_IF;

// 解耦逻辑
IF bCoupleFalling THEN
  fbGearOut.Slave := Slave;
  fbGearOut.Execute := TRUE;
END_IF;

// 检查解耦完成或错误状态
IF fbGearOut.Execute THEN
  IF fbGearOut.Done THEN
    bInGear := FALSE;
    bDecouplingDone := TRUE;
    fbGearOut.Execute := FALSE;
  ELSIF fbGearOut.Error THEN
    bError := TRUE;
    nErrorID := fbGearOut.ErrorID;
    fbGearOut.Execute := FALSE;
  END_IF;
END_IF;
END_FUNCTION_BLOCK