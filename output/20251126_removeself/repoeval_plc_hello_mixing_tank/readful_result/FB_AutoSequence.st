VAR
	// 内部状态变量
	eState				:	AUTO_SEQUENCE := IDLE;	// 状态机当前状态
	tStateTimer			:	TIME := T#0S;			// 状态计时器
	nCycleCounter		:	UINT := 0;				// 循环计数器
END_VAR

// 状态机逻辑
CASE eState OF
	IDLE:
		// 等待使能信号
		IF bEnable THEN
			eState := FILLING;
		END_IF;
		
	FILLING:
		// 打开填充阀门
		bMedium1OpenCmd := TRUE;
		bMedium2OpenCmd := TRUE;
		
		// 检查液位满传感器
		IF bTankLevelFull THEN
			bMedium1OpenCmd := FALSE;
			bMedium2OpenCmd := FALSE;
			eState := MIXING;
			tStateTimer := tMixingDuration; // 设置混合持续时间
		END_IF;
		
	MIXING:
		// 启动混合电机
		bMixerRunCmd := TRUE;
		
		// 检查混合时间是否结束
		IF tStateTimer <= T#0S THEN
			bMixerRunCmd := FALSE;
			eState := DRAINING;
		ELSE
			tStateTimer := tStateTimer - T#1S; // 减少计时器
		END_IF;
		
	DRAINING:
		// 打开排空阀门
		bDrainOpenCmd := TRUE;
		
		// 检查液位空传感器
		IF bTankLevelEmpty THEN
			bDrainOpenCmd := FALSE;
			nCycleCounter := nCycleCounter + 1; // 增加循环计数
			eState := IDLE; // 返回到空闲状态
		END_IF;
		
	DEFAULT:
		// 默认状态处理
		eState := IDLE;
END_CASE;

// 复位逻辑
IF bReset THEN
	eState := IDLE;
	nCycleCounter := 0;
	bMixerRunCmd := FALSE;
	bMedium1OpenCmd := FALSE;
	bMedium2OpenCmd := FALSE;
	bDrainOpenCmd := FALSE;
END_IF;

// 状态输出
eCurrentState := eState;
nCyclesCompleted := nCycleCounter;