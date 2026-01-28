VAR
	fbPowerMgr			:	FB_DualAxisPower;	//双轴电源管理
	fbGearCtrl			:	FB_GearCoupling;	//齿轮耦合控制
	fbMoveVel			:	MC_MoveVelocity;	//速度运动
	fbHaltMaster		:	MC_Halt;			//主轴停止
	fbHaltSlave			:	MC_Halt;			//从轴停止
	fbStartRtrig		:	R_TRIG;				//启动上升沿
	fbStopRtrig			:	R_TRIG;				//停止上升沿
	nState				:	BYTE;				//内部状态机
END_VAR

fbStartRtrig(CLK := bStart);
fbStopRtrig(CLK := bStop);

CASE nState OF
	0: // 等待轴准备就绪
		fbPowerMgr(Axis1 := MasterAxis, Axis2 := SlaveAxis, bEnable := TRUE);
		bReady := fbPowerMgr.bReady;
		IF bReady THEN
			nState := 1;
		END_IF;

	1: // 启动运动
		IF fbStartRtrig.Q THEN
			fbMoveVel(Axis := MasterAxis, Velocity := rVelocity, Acceleration := rAcceleration, Deceleration := rDeceleration, Direction := nDirection, Execute := TRUE);
			IF fbMoveVel.Done THEN
				fbGearCtrl(Master := MasterAxis, Slave := SlaveAxis, RatioNumerator := nRatioNumerator, RatioDenominator := nRatioDenominator, Execute := TRUE);
				IF fbGearCtrl.Done THEN
					bRunning := TRUE;
					nState := 2;
				END_IF;
			END_IF;
		END_IF;

	2: // 运行中
		IF fbStopRtrig.Q THEN
			fbHaltMaster(Axis := MasterAxis, Execute := TRUE);
			fbHaltSlave(Axis := SlaveAxis, Execute := TRUE);
			IF fbHaltMaster.Done AND fbHaltSlave.Done THEN
				bRunning := FALSE;
				nState := 0;
			END_IF;
		END_IF;

	ELSE
		bError := TRUE;
END_CASE;

nCurrentState := nState;
END_FUNCTION_BLOCK
