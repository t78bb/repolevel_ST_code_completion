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

It seems like you are working with a motion control system, and the provided code fragments are written in Structured Text (ST), commonly used in PLC programming. Below, I'll continue by implementing a function block (`FB_GearMotionControl`) that integrates the gear coupling functionality (`FB_GearCoupling`) with motion control logic. This will ensure the system can handle coupling, decoupling, and motion control seamlessly.

```st
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
	fbGearCoupling		:	FB_GearCoupling;	//齿轮耦合功能块
	bCouplingActive		:	BOOL;				//耦合激活标志
	bMotionActive		:	BOOL;				//运动激活标志
	bStartRisingEdge	:	BOOL;				//启动信号上升沿
	bStopRisingEdge		:	BOOL;				//停止信号上升沿
	nState				:	BYTE := 0;			//状态机状态
END_VAR

// 状态机定义
// 0: 初始化
// 1: 准备就绪
// 2: 耦合中
// 3: 运动中
// 4: 停止中
// 5: 错误处理

// 主程序逻辑
CASE nState OF
	0: // 初始化
		bRunning := FALSE;
		bReady := FALSE;
		bError := FALSE;
		bCouplingActive := FALSE;
		bMotionActive := FALSE;
		nCurrentState := 0;
		IF NOT bError THEN
			nState := 1; // 转到准备就绪状态
		END_IF;

	1: // 准备就绪
		bReady := TRUE;
		IF bStart THEN
			bStartRisingEdge := TRUE;
		END_IF;

		IF bStartRisingEdge THEN
			bStartRisingEdge := FALSE;
			nState := 2; // 转到耦合状态
		END_IF;

	2: // 耦合中
		fbGearCoupling.Master := MasterAxis;
		fbGearCoupling.Slave := SlaveAxis;
		fbGearCoupling.bCouple := TRUE;
		fbGearCoupling.nRatioNumerator := nRatioNumerator;
		fbGearCoupling.nRatioDenominator := nRatioDenominator;
		fbGearCoupling.rAcceleration := rAcceleration;
		fbGearCoupling.rDeceleration := rDeceleration;

		// 调用耦合功能块
		fbGearCoupling();

		IF fbGearCoupling.bCouplingDone THEN
			bCouplingActive := TRUE;
			nState := 3; // 转到运动状态
		END_IF;

		IF fbGearCoupling.bError THEN
			bError := TRUE;
			nState := 5; // 转到错误处理状态
		END_IF;

	3: // 运动中
		bRunning := TRUE;
		bReady := FALSE;

		// 运动逻辑
		// 此处可以调用其他运动功能块，例如 MC_MoveVelocity
		// 示例代码省略，假设运动逻辑正常运行

		IF bStop THEN
			bStopRisingEdge := TRUE;
		END_IF;

		IF bStopRisingEdge THEN
			bStopRisingEdge := FALSE;
			nState := 4; // 转到停止状态
		END_IF;

	4: // 停止中
		bRunning := FALSE;
END_FUNCTION_BLOCK