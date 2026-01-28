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
	eCurrentState := AUTO_SEQUENCE.DRAINING;
	nCyclesCompleted := 0;
	RETURN;
END_IF

// 检查使能条件
IF NOT bEnable THEN
	eCurrentState := AUTO_SEQUENCE.IDLE;
	RETURN;
END_IF

// 自动序列状态机
CASE eCurrentState OF
	AUTO_SEQUENCE.DRAINING:
		// 排空状态逻辑
		bDrainOpenCmd := TRUE;
		IF bTankLevelEmpty THEN
			eCurrentState := AUTO_SEQUENCE.FILLING;
		END_IF;

	AUTO_SEQUENCE.FILLING:
		// 填充状态逻辑
		bMedium1OpenCmd := TRUE;
		bMedium2OpenCmd := TRUE;
		IF bTankLevelFull THEN
			eCurrentState := AUTO_SEQUENCE.MIXING;
		END_IF;

	AUTO_SEQUENCE.MIXING:
		// 混合状态逻辑
		bMixerRunCmd := TRUE;
		tonMixing(IN := TRUE, PT := tMixingDuration);
		IF tonMixing.Q THEN
			eCurrentState := AUTO_SEQUENCE.DRAINING;
			nCyclesCompleted := nCyclesCompleted + 1;
		END_IF;

	ELSE
		// 默认状态为初始状态
		eCurrentState := AUTO_SEQUENCE.IDLE;
END_CASE
END_FUNCTION_BLOCK
