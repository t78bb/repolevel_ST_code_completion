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
	eNextState			:	AUTO_SEQUENCE;	// 下一个状态
	tTimer				:	TON;			// 定时器
	bTimerElapsed		:	BOOL;			// 定时器到时标志
END_VAR

// 状态机逻辑
CASE eCurrentState OF
	AUTO_SEQUENCE.EmptyTank:
		// 排空状态
		bDrainOpenCmd := TRUE;
		bMedium1OpenCmd := FALSE;
		bMedium2OpenCmd := FALSE;
		bMixerRunCmd := FALSE;

		// 检查液位空传感器
		IF bTankLevelEmpty THEN
			eNextState := AUTO_SEQUENCE.FillTank;
		ELSE
			eNextState := AUTO_SEQUENCE.EmptyTank;
		END_IF;

	AUTO_SEQUENCE.FillTank:
		// 填充状态
		bDrainOpenCmd := FALSE;
		bMedium1OpenCmd := TRUE;
		bMedium2OpenCmd := TRUE;
		bMixerRunCmd := FALSE;

		// 检查液位满传感器
		IF bTankLevelFull THEN
			eNextState := AUTO_SEQUENCE.MixContents;
		ELSE
			eNextState := AUTO_SEQUENCE.FillTank;
		END_IF;

	AUTO_SEQUENCE.MixContents:
		// 混合状态
		bDrainOpenCmd := FALSE;
		bMedium1OpenCmd := FALSE;
		bMedium2OpenCmd := FALSE;
		bMixerRunCmd := TRUE;

		// 启动混合定时器
		tTimer(IN := TRUE, PT := tMixingDuration);
		bTimerElapsed := tTimer.Q;

		// 检查混合时间是否完成
		IF bTimerElapsed THEN
			eNextState := AUTO_SEQUENCE.EmptyTank;
			nCyclesCompleted := nCyclesCompleted + 1;
		ELSE
			eNextState := AUTO_SEQUENCE.MixContents;
		END_IF;

	ELSE
		// 默认状态
		eNextState := AUTO_SEQUENCE.EmptyTank;
END_CASE;

// 状态更新
IF bReset THEN
	eCurrentState := AUTO_SEQUENCE.EmptyTank;
	nCyclesCompleted := 0;
ELSE
	IF bEnable THEN
		eCurrentState := eNextState;
	END_IF;
END_IF;

END_FUNCTION_BLOCK
