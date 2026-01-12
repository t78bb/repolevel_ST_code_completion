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