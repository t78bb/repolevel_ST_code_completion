FUNCTION_BLOCK FB_GearMotionControl
VAR_INPUT
	MasterAxis			:	AXIS_REF;		//主轴引用
	SlaveAxis			:	AXIS_REF;		//从轴引用
	bStart				:	BOOL;			//启动信号
	bStop				:	BOOL;			//停止信号
	nRatioNumerator		:	INT := 1;		//传动比分子
	nRatioDenominator	:	INT := 1;		//传动比分母
	nDirection			:	INT := 1;		//运动方向（1=正向，-1=反向）
	rVelocity			:	REAL := 360.0;	//主轴速度
	rAcceleration		:	REAL := 10000.0;//加速度
	rDeceleration		:	REAL := 10000.0;//减速度
END_VAR
VAR_OUTPUT
	bRunning			:	BOOL;			//运行中
	bReady				:	BOOL;			//准备就绪（可以启动）
	bError				:	BOOL;			//错误标志
	nCurrentState		:	BYTE;			//当前状态
END_VAR

VAR
	bStartRising		:	BOOL;			//启动信号上升沿
	bStopRising			:	BOOL;			//停止信号上升沿
	bLastStart			:	BOOL;			//上次启动信号状态
	bLastStop			:	BOOL;			//上次停止信号状态
	fbGearCoupling		:	FB_GearCoupling;//齿轮耦合功能块
	nState				:	BYTE := 0;		//状态变量
END_VAR

// 检测启动和停止信号的边沿
bStartRising := bStart AND NOT bLastStart;
bStopRising := bStop AND NOT bLastStop;
bLastStart := bStart;
bLastStop := bStop;

// 状态机控制
CASE nState OF
	0: // 初始化状态
		bReady := TRUE;
		bRunning := FALSE;
		IF bStartRising THEN
			nState := 1;
		END_IF;

	1: // 启动齿轮耦合
		fbGearCoupling.Master := MasterAxis;
		fbGearCoupling.Slave := SlaveAxis;
		fbGearCoupling.bCouple := TRUE;
		fbGearCoupling.nRatioNumerator := nRatioNumerator;
		fbGearCoupling.nRatioDenominator := nRatioDenominator;
		fbGearCoupling.rAcceleration := rAcceleration;
		fbGearCoupling.rDeceleration := rDeceleration;
		fbGearCoupling();
		IF fbGearCoupling.bCouplingDone THEN
			nState := 2;
		END_IF;

	2: // 运行状态
		bRunning := TRUE;
		IF bStopRising THEN
			nState := 3;
		END_IF;

	3: // 停止齿轮耦合
		fbGearCoupling.bCouple := FALSE;
		fbGearCoupling();
		IF fbGearCoupling.bDecouplingDone THEN
			nState := 0;
		END_IF;

ELSE
	nState := 0; // 默认回到初始化状态
END_CASE;

// 错误处理
bError := fbGearCoupling.bError;

END_FUNCTION_BLOCK
