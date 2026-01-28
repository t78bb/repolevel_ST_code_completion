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

// 复位逻辑
IF bReset THEN
	eCurrentState := AUTO_SEQUENCE.DRAINING;
	nCyclesCompleted := 0;
END_IF

// 自动序列状态机
IF bEnable THEN
	CASE eCurrentState OF
		AUTO_SEQUENCE.FILLING:
			// 确保其他设备不工作
			bMixerRunCmd := FALSE;
			bDrainOpenCmd := FALSE;

			// 开启介质阀门
			bMedium1OpenCmd := TRUE;
			bMedium2OpenCmd := TRUE;

			// 检查液位满传感器
			IF bTankLevelFull THEN
				bMedium1OpenCmd := FALSE;
				bMedium2OpenCmd := FALSE;
				eCurrentState := AUTO_SEQUENCE.MIXING;
			END_IF;

		AUTO_SEQUENCE.MIXING:
			// 确保其他设备不工作
			bMedium1OpenCmd := FALSE;
			bMedium2OpenCmd := FALSE;
			bDrainOpenCmd := FALSE;

			// 开启混合电机
			bMixerRunCmd := TRUE;

			// 启动混合定时器
			tonMixing(IN := TRUE, PT := tMixingDuration);

			// 检查定时器是否完成
			IF tonMixing.Q THEN
				bMixerRunCmd := FALSE;
				eCurrentState := AUTO_SEQUENCE.DRAINING;
			END_IF;

		AUTO_SEQUENCE.DRAINING:
			// 确保其他设备不工作
			bMixerRunCmd := FALSE;
			bMedium1OpenCmd := FALSE;
			bMedium2OpenCmd := FALSE;

			// 开启排空阀门
			bDrainOpenCmd := TRUE;

			// 检查液位空传感器
			IF bTankLevelEmpty THEN
				bDrainOpenCmd := FALSE;
				eCurrentState := AUTO_SEQUENCE.FILLING;
				nCyclesCompleted := nCyclesCompleted + 1;
			END_IF;

		ELSE
			// 默认状态，确保所有设备关闭
			bMixerRunCmd := FALSE;
			bMedium1OpenCmd := FALSE;
			bMedium2OpenCmd := FALSE;
			bDrainOpenCmd := FALSE;
	END_CASE;
END_IF;
END_FUNCTION_BLOCK
