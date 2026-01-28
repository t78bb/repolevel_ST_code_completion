VAR
	// 内部状态变量
	eNextState			:	AUTO_SEQUENCE;	// 下一个状态
	tStateTimer			:	TIME;			// 状态计时器
	nCycleCounter		:	UINT := 0;		// 循环计数器
	bTransitionFlag		:	BOOL := FALSE;	// 状态转换标志
END_VAR

// 自动序列状态枚举
TYPE AUTO_SEQUENCE :
(
	IDLE,				// 空闲状态
	FILLING_MEDIUM1,	// 介质1填充状态
	FILLING_MEDIUM2,	// 介质2填充状态
	MIXING,				// 混合状态
	DRAINING			// 排空状态
);
END_TYPE

// 自动序列逻辑实现
IF bEnable THEN
	CASE eCurrentState OF
		IDLE:
			IF bTankLevelEmpty THEN
				eNextState := FILLING_MEDIUM1;
			END_IF;
			
		FILLING_MEDIUM1:
			bMedium1OpenCmd := TRUE;
			IF bTankLevelFull THEN
				bMedium1OpenCmd := FALSE;
				eNextState := FILLING_MEDIUM2;
			END_IF;
			
		FILLING_MEDIUM2:
			bMedium2OpenCmd := TRUE;
			IF bTankLevelFull THEN
				bMedium2OpenCmd := FALSE;
				eNextState := MIXING;
			END_IF;
			
		MIXING:
			bMixerRunCmd := TRUE;
			IF tStateTimer >= tMixingDuration THEN
				bMixerRunCmd := FALSE;
				eNextState := DRAINING;
			END_IF;
			
		DRAINING:
			bDrainOpenCmd := TRUE;
			IF bTankLevelEmpty THEN
				bDrainOpenCmd := FALSE;
				eNextState := IDLE;
				nCycleCounter := nCycleCounter + 1;
			END_IF;
	END_CASE;
	
	// 状态更新
	IF eNextState <> eCurrentState THEN
		eCurrentState := eNextState;
		tStateTimer := T#0S; // 重置状态计时器
	END_IF;
	
	// 状态计时器更新
	tStateTimer := tStateTimer + T#1MS;
ELSE
	// 禁用时复位所有命令和状态
	bMixerRunCmd := FALSE;
	bMedium1OpenCmd := FALSE;
	bMedium2OpenCmd := FALSE;
	bDrainOpenCmd := FALSE;
	eCurrentState := IDLE;
	nCycleCounter := 0;
END_IF;

IF bReset THEN
	// 复位逻辑
	bMixerRunCmd := FALSE;
	bMedium1OpenCmd := FALSE;
	bMedium2OpenCmd := FALSE;
	bDrainOpenCmd := FALSE;
	eCurrentState := IDLE;
	nCycleCounter := 0;
	tStateTimer := T#0S;
END_IF;