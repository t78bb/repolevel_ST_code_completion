FUNCTION_BLOCK FB_AutoSequence
VAR_INPUT
	bEnable				:	BOOL;			// 使能自动序列
	bReset				:	BOOL;			// 复位到排空状态
	
	// 液位传感器反馈
	bTankLevelFull		:	BOOL;			// 液位满传感器
	bTankLevelEmpty		:	BOOL;			// 液位空传感器
	
	// 设备状态反馈
	bMixerRunning		:	BOOL;			// 混合电机运行中
	bMedium1Opened		:	BOOL;			// 介质1阀门打开
	bMedium2Opened		:	BOOL;			// 介质2阀门打开
	bDrainOpened		:	BOOL;			// 排空阀门打开
	
	// 配置参数
	tMixingDuration		:	TIME := T#10S;	// 混合持续时间
END_VAR
VAR_OUTPUT
	// 设备控制输出
	bMixerRunCmd		:	BOOL;			// 混合电机运行命令
	bMedium1OpenCmd		:	BOOL;			// 介质1阀门打开命令
	bMedium2OpenCmd		:	BOOL;			// 介质2阀门打开命令
	bDrainOpenCmd		:	BOOL;			// 排空阀门打开命令
	
	// 状态输出
	eCurrentState		:	AUTO_SEQUENCE;	// 当前状态
	nCyclesCompleted	:	UINT;			// 完成的循环次数
END_VAR
VAR
	tonMixing			:	TON;			// 混合定时器
END_VAR

// 初始化设备控制输出
bMixerRunCmd := FALSE;
bMedium1OpenCmd := FALSE;
bMedium2OpenCmd := FALSE;
bDrainOpenCmd := FALSE;

// 检查复位条件
IF bReset THEN
// Replace AUTO_SEQUENCE.DRAINING with a constant value or default state
  eCurrentState := 0; // Assuming '0' corresponds to the DRAINING state
	nCyclesCompleted := 0;
	RETURN;
END_IF

// 检查使能条件
IF NOT bEnable THEN
// Replace AUTO_SEQUENCE.IDLE with a constant value or default state
  eCurrentState := 1; // Assuming '1' corresponds to the IDLE state
	RETURN;
END_IF

// 自动序列状态机
CASE eCurrentState OF
0:	// DRAINING state
 // 排空状态逻辑
 bDrainOpenCmd := TRUE;
 IF bTankLevelEmpty THEN
 eCurrentState := 2; // Transition to FILLING state
 END_IF;

2:	// FILLING state
 // 填充状态逻辑
 bMedium1OpenCmd := TRUE;
 bMedium2OpenCmd := TRUE;
 IF bTankLevelFull THEN
 eCurrentState := 3; // Transition to MIXING state
 END_IF;

3:	// MIXING state
 // 混合状态逻辑
 bMixerRunCmd := TRUE;
 tonMixing(IN := TRUE, PT := tMixingDuration);
 IF tonMixing.Q THEN
 eCurrentState := 0; // Transition back to DRAINING state
 nCyclesCompleted := nCyclesCompleted + 1;
 END_IF;

ELSE
 // 默认状态为初始状态
 eCurrentState := 1; // IDLE state
END_CASE
END_FUNCTION_BLOCK