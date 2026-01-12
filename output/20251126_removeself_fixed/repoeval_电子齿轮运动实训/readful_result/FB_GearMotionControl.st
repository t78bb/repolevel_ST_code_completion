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

structured-text
VAR
	fbGearCoupling		:	FB_GearCoupling;	//齿轮耦合功能块
	fbMoveAbsolute		:	MC_MoveAbsolute;	//绝对位置移动功能块
	fbMoveVelocity		:	MC_MoveVelocity;	//速度移动功能块
	bStartRising		:	BOOL;				//启动信号上升沿
	bStopRising			:	BOOL;				//停止信号上升沿
	bLastStart			:	BOOL;				//上次启动信号状态
	bLastStop			:	BOOL;				//上次停止信号状态
END_VAR

// 检测启动和停止信号的边沿
bStartRising := bStart AND NOT bLastStart;
bStopRising := bStop AND NOT bLastStop;
bLastStart := bStart;
bLastStop := bStop;

// 主状态机逻辑
CASE nCurrentState OF
	0: // 初始状态
		bReady := TRUE;
		bRunning := FALSE;
		IF bStartRising THEN
			nCurrentState := 1; // 转到启动状态
		END_IF

	1: // 启动状态
		bReady := FALSE;
		bRunning := TRUE;
		fbGearCoupling(
			Master := MasterAxis,
			Slave := SlaveAxis,
			bCouple := TRUE,
			nRatioNumerator := nRatioNumerator,
			nRatioDenominator := nRatioDenominator,
			rAcceleration := rAcceleration,
			rDeceleration := rDeceleration
		);
		IF fbGearCoupling.bCouplingDone THEN
			nCurrentState := 2; // 转到运行状态
		END_IF

	2: // 运行状态
		fbMoveVelocity(
			Axis := MasterAxis,
			Velocity := rVelocity * nDirection,
			Acceleration := rAcceleration,
			Deceleration := rDeceleration,
			bExecute := TRUE
		);
		IF bStopRising THEN
			nCurrentState := 3; // 转到停止状态
		END_IF

	3: // 停止状态
		fbMoveVelocity(
			Axis := MasterAxis,
			bExecute := FALSE
		);
		fbGearCoupling(
			Master := MasterAxis,
			Slave := SlaveAxis,
			bCouple := FALSE,
			nRatioNumerator := nRatioNumerator,
			nRatioDenominator := nRatioDenominator,
			rAcceleration := rAcceleration,
			rDeceleration := rDeceleration
		);
		IF fbGearCoupling.bDecouplingDone THEN
			nCurrentState := 0; // 回到初始状态
		END_IF

	ELSE
		// 错误处理
		bError := TRUE;
	END_CASE