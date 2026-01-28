VAR
	fbPowerMgr			:	FB_DualAxisPower;	//双轴电源管理
	fbGearCtrl			:	FB_GearCoupling;	//齿轮耦合控制
	fbMoveVel			:	MC_MoveVelocity;	//速度运动
	fbHaltMaster		:	MC_Halt;			//主轴停止
	fbHaltSlave			:	MC_Halt;			//从轴停止
	fbStartRtrig		:	R_TRIG;				//启动上升沿
	fbStopRtrig			:	R_TRIG;				//停止上升沿
	nState				:	BYTE;				//内部状态机
	rSlaveVelocity		:	REAL;				//从轴速度
END_VAR

fbStartRtrig(CLK := bStart);
fbStopRtrig(CLK := bStop);

IF fbStopRtrig.Q THEN
	// 停止信号优先处理
	fbHaltMaster(Execute := TRUE, Axis := MasterAxis, Deceleration := rDeceleration);
	fbHaltSlave(Execute := TRUE, Axis := SlaveAxis, Deceleration := rDeceleration);
	bRunning := FALSE;
	bReady := FALSE;
	nState := 0;
	RETURN;
END_IF

IF fbStartRtrig.Q THEN
	// 检查输入参数合法性
	IF nRatioNumerator = 0 OR nRatioDenominator = 0 OR (nDirection <> 1 AND nDirection <> -1) THEN
		bError := TRUE;
		RETURN;
	END_IF;

	// 计算从轴速度
	rSlaveVelocity := rVelocity * nRatioNumerator / nRatioDenominator * nDirection;

	// 设置主轴和从轴运动参数
	fbMoveVel(Execute := TRUE, Axis := MasterAxis, Velocity := rVelocity, Acceleration := rAcceleration, Deceleration := rDeceleration);
	fbGearCtrl(Execute := TRUE, Master := MasterAxis, Slave := SlaveAxis, RatioNumerator := nRatioNumerator, RatioDenominator := nRatioDenominator);

	// 更新状态
	bRunning := TRUE;
	bReady := FALSE;
	nState := 1;
	RETURN;
END_IF;

CASE nState OF
	0: // 等待轴准备就绪
		IF fbPowerMgr.Axis1Ready AND fbPowerMgr.Axis2Ready THEN
			bReady := TRUE;
		END_IF;

	1: // 运行中
		IF NOT fbMoveVel.Busy THEN
			bRunning := FALSE;
			bReady := TRUE;
			nState := 0;
		END_IF;

		IF fbMoveVel.Error OR fbGearCtrl.Error THEN
			bError := TRUE;
			fbHaltMaster(Execute := TRUE, Axis := MasterAxis, Deceleration := rDeceleration);
			fbHaltSlave(Execute := TRUE, Axis := SlaveAxis, Deceleration := rDeceleration);
			nState := 0;
		END_IF;
END_CASE;
END_FUNCTION_BLOCK
