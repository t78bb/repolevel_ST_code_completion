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
eCurrentState		:	UINT;			// 当前状态 (Replaced AUTO_SEQUENCE with UINT)
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
    1:	// Replacing AUTO_SEQUENCE.FILLING with 1
      // 确保其他设备不工作
      bMixerRunCmd := FALSE;
      bDrainOpenCmd := FALSE;

      // 打开介质阀门
      bMedium1OpenCmd := TRUE;
      bMedium2OpenCmd := TRUE;

      // 检查液位满
      IF bTankLevelFull THEN
        bMedium1OpenCmd := FALSE;
        bMedium2OpenCmd := FALSE;
        eCurrentState := 2;	// Replacing AUTO_SEQUENCE.MIXING with 2
      END_IF;

    2:	// Replacing AUTO_SEQUENCE.MIXING with 2
      // 确保其他设备不工作
      bMedium1OpenCmd := FALSE;
      bMedium2OpenCmd := FALSE;
      bDrainOpenCmd := FALSE;

      // 启动混合电机
      bMixerRunCmd := TRUE;

      // 启动混合定时器
      tonMixing(IN := TRUE, PT := tMixingDuration);

      // 检查混合时间是否完成
      IF tonMixing.Q THEN
        bMixerRunCmd := FALSE;
        eCurrentState := 3;	// Replacing AUTO_SEQUENCE.DRAINING with 3
      END_IF;

    3:	// Replacing AUTO_SEQUENCE.DRAINING with 3
      // 确保其他设备不工作
      bMixerRunCmd := FALSE;
      bMedium1OpenCmd := FALSE;
      bMedium2OpenCmd := FALSE;

      // 打开排空阀门
      bDrainOpenCmd := TRUE;

      // 检查液位空
      IF bTankLevelEmpty THEN
        bDrainOpenCmd := FALSE;
        eCurrentState := 1;	// Replacing AUTO_SEQUENCE.FILLING with 1
        nCyclesCompleted := nCyclesCompleted + 1;
      END_IF;

    // 默认状态
    ELSE
      eCurrentState := 1; // Replacing AUTO_SEQUENCE.FILLING with 1
  END_CASE;
END_IF;
END_FUNCTION_BLOCK